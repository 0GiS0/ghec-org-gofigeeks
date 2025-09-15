
# AI Assistant Template Repository Files
# This file contains all file resources specific to the AI Assistant template

locals {
  ai_assistant_key     = "backstage-template-ai-assistant"
  ai_assistant_enabled = contains(keys(var.template_repositories), local.ai_assistant_key)

  # List all files in ai-assistant template
  ai_assistant_all = local.ai_assistant_enabled ? fileset(path.module, "software_templates/ai-assistant/**") : []

  # Exclude unwanted directories (none for now, but pattern for future)
  ai_assistant_all_filtered = [
    for f in local.ai_assistant_all : f
    if length(regexall("/bin/", f)) == 0
    && length(regexall("/obj/", f)) == 0
    && length(regexall("/\\.vs/", f)) == 0
    && length(regexall("/Debug/", f)) == 0
    && length(regexall("/Release/", f)) == 0
    && !endswith(f, ".user")
    && !endswith(f, ".suo")
    && !endswith(f, ".cache")
  ]

  # Separate template (.tpl) files vs regular files
  ai_assistant_template_raw = [for f in local.ai_assistant_all_filtered : f if endswith(f, ".tpl")]
  ai_assistant_regular_raw  = [for f in local.ai_assistant_all_filtered : f if !endswith(f, ".tpl")]

  # Map for regular files (destination keeps ai-assistant/ prefix)
  ai_assistant_regular_map = { for f in local.ai_assistant_regular_raw :
    replace(f, "software_templates/ai-assistant/", "") => {
      source_file    = "${path.module}/${f}"
      commit_message = "Sync AI assistant file ${replace(f, "software_templates/ai-assistant/", "")}"
    }
  }

  # Map for templated files (.tpl) removing extension in destination
  ai_assistant_template_map = { for f in local.ai_assistant_template_raw :
    replace(replace(f, "software_templates/ai-assistant/", ""), ".tpl", "") => {
      source_file      = "${path.module}/${f}"
      commit_message   = "Add templated AI assistant file ${replace(replace(f, "software_templates/ai-assistant/", ""), ".tpl", "")}"
      use_templatefile = true
      template_vars = {
        github_organization = var.github_organization
      }
    }
  }
}

# Regular file resources (direct file content)
resource "github_repository_file" "ai_assistant_files" {
  for_each = local.ai_assistant_regular_map

  repository          = github_repository.templates[local.ai_assistant_key].name
  branch              = "main"
  file                = each.key
  content             = file(each.value.source_file)
  commit_message      = each.value.commit_message
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template file resources (files that need template processing)
resource "github_repository_file" "ai_assistant_template_files" {
  for_each = local.ai_assistant_template_map

  repository = github_repository.templates[local.ai_assistant_key].name
  branch     = "main"
  file       = each.key
  content = each.value.use_templatefile ? templatefile(
    each.value.source_file,
    each.value.template_vars
  ) : file(each.value.source_file)
  commit_message      = each.value.commit_message
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}
