# Astro Frontend Template Repository Files
# Dynamic file syncing for Astro frontend template, modeled after node-service

locals {
  astro_frontend_key     = "backstage-template-astro-frontend"
  astro_frontend_enabled = contains(keys(var.template_repositories), local.astro_frontend_key)

  # All files under skeleton/
  astro_frontend_skeleton_all = local.astro_frontend_enabled ? fileset(path.module, "templates/astro-frontend/skeleton/**") : []

  # Exclude unwanted directories (node_modules, coverage)
  astro_frontend_skeleton_all_filtered = [
    for f in local.astro_frontend_skeleton_all : f
    if length(regexall("/node_modules/", f)) == 0
    && length(regexall("/coverage/", f)) == 0
  ]

  # Split into templated (.tpl) and regular files
  astro_frontend_skeleton_template_raw = [for f in local.astro_frontend_skeleton_all_filtered : f if endswith(f, ".tpl")]
  astro_frontend_skeleton_regular_raw  = [for f in local.astro_frontend_skeleton_all_filtered : f if !endswith(f, ".tpl")]

  # Map regular skeleton files (destination keeps skeleton/ prefix)
  astro_frontend_skeleton_regular_map = { for f in local.astro_frontend_skeleton_regular_raw :
    replace(f, "templates/astro-frontend/", "") => {
      source_file    = "${path.module}/${f}"
      commit_message = "Sync Astro skeleton file ${replace(f, "templates/astro-frontend/", "")}"
    }
  }

  # Map templated skeleton files (.tpl) removing extension in destination
  astro_frontend_skeleton_template_map = { for f in local.astro_frontend_skeleton_template_raw :
    replace(replace(f, "templates/astro-frontend/", ""), ".tpl", "") => {
      source_file      = "${path.module}/${f}"
      commit_message   = "Add templated Astro skeleton file ${replace(replace(f, "templates/astro-frontend/", ""), ".tpl", "")}"
      use_templatefile = true
      template_vars = {
        github_organization = var.github_organization
      }
    }
  }

  # Explicit template-level (non-skeleton) regular files
  astro_frontend_template_level_files = local.astro_frontend_enabled ? {
    "README.md" = {
      source_file    = "${path.module}/templates/astro-frontend/README.md"
      commit_message = "Sync Astro frontend template README"
    }
    "docs/index.md" = {
      source_file    = "${path.module}/templates/astro-frontend/docs/index.md"
      commit_message = "Sync Astro frontend template docs index"
    }
    "docs/template-usage.md" = {
      source_file    = "${path.module}/templates/astro-frontend/docs/template-usage.md"
      commit_message = "Sync Astro frontend template usage guide"
    }
    "mkdocs.yml" = {
      source_file    = "${path.module}/templates/astro-frontend/mkdocs.yml"
      commit_message = "Sync Astro frontend template mkdocs configuration"
    }
    ".github/dependabot.yml" = {
      source_file    = "${path.module}/templates/astro-frontend/.github/dependabot.yml"
      commit_message = "Sync Astro frontend dependabot configuration"
    }
    ".devcontainer/devcontainer.json" = {
      source_file    = "${path.module}/templates/astro-frontend/.devcontainer/devcontainer.json"
      commit_message = "Sync Astro frontend devcontainer configuration"
    }
  } : {}

  # Combine skeleton regular + template-level regular files
  astro_frontend_files = local.astro_frontend_enabled ? merge(
    local.astro_frontend_skeleton_regular_map,
    local.astro_frontend_template_level_files
  ) : {}

  # Template (.tpl) files including the Backstage catalog-info at repo root
  astro_frontend_template_files = local.astro_frontend_enabled ? merge(
    local.astro_frontend_skeleton_template_map,
    {
      "catalog-info.yaml" = {
        source_file      = "${path.module}/templates/astro-frontend/catalog-info.yaml.tpl"
        commit_message   = "Add Astro frontend template catalog-info.yaml for Backstage"
        use_templatefile = true
        template_vars = {
          github_organization = var.github_organization
          github_repository   = local.astro_frontend_key
        }
      }
      # Root .gitignore for skeleton gets rendered from .gitignore.tpl into skeleton/.gitignore
      "skeleton/.gitignore" = {
        source_file      = "${path.module}/templates/astro-frontend/.gitignore.tpl"
        commit_message   = "Add Astro frontend skeleton .gitignore"
        use_templatefile = true
        template_vars = {
          github_organization = var.github_organization
        }
      }
    }
  ) : {}
}

# Regular file resources
resource "github_repository_file" "astro_frontend_files" {
  for_each = local.astro_frontend_files

  repository          = github_repository.templates[local.astro_frontend_key].name
  branch              = "main"
  file                = each.key
  content             = file(each.value.source_file)
  commit_message      = each.value.commit_message
  commit_author       = local.template_commit_config.commit_author
  commit_email        = local.template_commit_config.commit_email
  overwrite_on_create = true

  depends_on = [github_repository.templates]
}

# Template-rendered file resources
resource "github_repository_file" "astro_frontend_template_files" {
  for_each = local.astro_frontend_template_files

  repository = github_repository.templates[local.astro_frontend_key].name
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
