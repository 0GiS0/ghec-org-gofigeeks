# Node.js Service Template Repository Files
# This file contains all file resources specific to the Node.js Service template

locals {
  # Template-specific configuration
  node_service_key     = "backstage-template-node-service"
  node_service_enabled = contains(keys(var.template_repositories), local.node_service_key)

  # Dynamically list all skeleton files (fileset returns files only)
  node_service_skeleton_all = local.node_service_enabled ? fileset(path.module, "templates/node-service/skeleton/**") : []

  # Exclude unwanted directories (node_modules, coverage, dist) to avoid committing dependencies or build output
  node_service_skeleton_all_filtered = [
    for f in local.node_service_skeleton_all : f
    if length(regexall("/node_modules/", f)) == 0
    && length(regexall("/coverage/", f)) == 0
    && length(regexall("/dist/", f)) == 0
  ]

  # Separate template (.tpl) files vs regular files (after filtering)
  node_service_skeleton_template_raw = [for f in local.node_service_skeleton_all_filtered : f if endswith(f, ".tpl")]
  node_service_skeleton_regular_raw  = [for f in local.node_service_skeleton_all_filtered : f if !endswith(f, ".tpl")]

  # Map for regular skeleton files (destination keeps skeleton/ prefix)
  node_service_skeleton_regular_map = { for f in local.node_service_skeleton_regular_raw :
    replace(f, "templates/node-service/", "") => {
      source_file    = "${path.module}/${f}"
      commit_message = "Sync Node.js skeleton file ${replace(f, "templates/node-service/", "")}" # generic to avoid churn
    }
  }

  # Map for templated skeleton files (.tpl) removing extension in destination
  node_service_skeleton_template_map = { for f in local.node_service_skeleton_template_raw :
    replace(replace(f, "templates/node-service/", ""), ".tpl", "") => {
      source_file      = "${path.module}/${f}"
      commit_message   = "Add templated Node.js skeleton file ${replace(replace(f, "templates/node-service/", ""), ".tpl", "")}"
      use_templatefile = true
      template_vars = {
        github_organization = var.github_organization
      }
    }
  }

  # Explicit template-level (non-skeleton) regular files
  node_service_template_level_files = local.node_service_enabled ? {
    # README now templated via templatefile (see node_service_template_files merge)
    "docs/index.md" = {
      source_file    = "${path.module}/templates/node-service/docs/index.md"
      commit_message = "Sync Node.js service template docs index"
    }
    "docs/template-usage.md" = {
      source_file    = "${path.module}/templates/node-service/docs/template-usage.md"
      commit_message = "Sync Node.js service template usage guide"
    }
    "mkdocs.yml" = {
      source_file    = "${path.module}/templates/node-service/mkdocs.yml"
      commit_message = "Sync Node.js service template mkdocs configuration"
    }
    ".github/dependabot.yml" = {
      source_file    = "${path.module}/templates/node-service/.github/dependabot.yml"
      commit_message = "Sync Node.js service template dependabot"
    }
  } : {}

  # Combine skeleton regular + template-level regular files
  node_service_files = local.node_service_enabled ? merge(
    local.node_service_skeleton_regular_map,
    local.node_service_template_level_files
  ) : {}

  # Explicit non-.tpl skeleton files that still require template processing (none currently) + template-level templated files
  node_service_template_files = local.node_service_enabled ? merge(
    local.node_service_skeleton_template_map,
    {
      # Backstage root catalog-info remains templated
      "catalog-info.yaml" = {
        source_file      = "${path.module}/templates/node-service/catalog-info.yaml.tpl"
        commit_message   = "Add Node.js service template catalog-info.yaml for Backstage"
        use_templatefile = true
        template_vars = {
          github_organization = var.github_organization
          github_repository   = local.node_service_key
        }
      }

      "README.md" = {
        source_file      = "${path.module}/templates/node-service/README.md.tpl"
        commit_message   = "Add templated Node.js service README with dynamic badges"
        use_templatefile = true
        template_vars = {
          github_organization = var.github_organization
          repository_name     = github_repository.templates[local.node_service_key].name
        }
      }
    },
    {
      # Example environment file stays non-templated but we include it here if in future becomes templated; keep in regular map otherwise
    }
  ) : {}
}

# Regular file resources (direct file content)
resource "github_repository_file" "node_service_files" {
  for_each = local.node_service_files

  repository          = github_repository.templates[local.node_service_key].name
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
resource "github_repository_file" "node_service_template_files" {
  for_each = local.node_service_template_files

  repository = github_repository.templates[local.node_service_key].name
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
