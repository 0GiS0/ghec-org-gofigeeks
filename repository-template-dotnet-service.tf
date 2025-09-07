# .NET Service Template Repository Files
# This file contains all file resources specific to the .NET Service template

locals {
  # Template-specific configuration
  dotnet_service_key     = "backstage-template-dotnet-service"
  dotnet_service_enabled = contains(keys(var.template_repositories), local.dotnet_service_key)

  # Dynamically list all skeleton files (fileset returns files only)
  dotnet_service_skeleton_all = local.dotnet_service_enabled ? fileset(path.module, "templates/dotnet-service/skeleton/**") : []

  # Exclude unwanted directories (bin, obj, etc.) to avoid committing build artifacts
  dotnet_service_skeleton_all_filtered = [
    for f in local.dotnet_service_skeleton_all : f
    if length(regexall("/bin/", f)) == 0
    && length(regexall("/obj/", f)) == 0
    && length(regexall("/\\.vs/", f)) == 0
    && length(regexall("/Debug/", f)) == 0
    && length(regexall("/Release/", f)) == 0
    && !endswith(f, ".user")
    && !endswith(f, ".suo")
    && !endswith(f, ".cache")
  ]

  # Separate template (.tpl) files vs regular files (after filtering)
  dotnet_service_skeleton_template_raw = [for f in local.dotnet_service_skeleton_all_filtered : f if endswith(f, ".tpl")]
  dotnet_service_skeleton_regular_raw  = [for f in local.dotnet_service_skeleton_all_filtered : f if !endswith(f, ".tpl")]

  # Map for regular skeleton files (destination keeps skeleton/ prefix)
  dotnet_service_skeleton_regular_map = { for f in local.dotnet_service_skeleton_regular_raw :
    replace(f, "templates/dotnet-service/", "") => {
      source_file    = "${path.module}/${f}"
      commit_message = "Sync .NET skeleton file ${replace(f, "templates/dotnet-service/", "")}" # generic to avoid churn
    }
  }

  # Map for templated skeleton files (.tpl) removing extension in destination
  dotnet_service_skeleton_template_map = { for f in local.dotnet_service_skeleton_template_raw :
    replace(replace(f, "templates/dotnet-service/", ""), ".tpl", "") => {
      source_file      = "${path.module}/${f}"
      commit_message   = "Add templated .NET skeleton file ${replace(replace(f, "templates/dotnet-service/", ""), ".tpl", "")}"
      use_templatefile = true
      template_vars = {
        github_organization = var.github_organization
      }
    }
  }

  # Explicit template-level (non-skeleton) regular files
  dotnet_service_template_level_files = local.dotnet_service_enabled ? {
    # README now templated via templatefile (see dotnet_service_template_files merge)
    "docs/index.md" = {
      source_file    = "${path.module}/templates/dotnet-service/docs/index.md"
      commit_message = "Sync .NET service template docs index"
    }
    "docs/template-usage.md" = {
      source_file    = "${path.module}/templates/dotnet-service/docs/template-usage.md"
      commit_message = "Sync .NET service template usage guide"
    }
    "mkdocs.yml" = {
      source_file    = "${path.module}/templates/dotnet-service/mkdocs.yml"
      commit_message = "Sync .NET service template mkdocs configuration"
    }
  } : {}

  # Combine skeleton regular + template-level regular files
  dotnet_service_files = local.dotnet_service_enabled ? merge(
    local.dotnet_service_skeleton_regular_map,
    local.dotnet_service_template_level_files
  ) : {}

  # Explicit non-.tpl skeleton files that still require template processing (none currently) + template-level templated files
  dotnet_service_template_files = local.dotnet_service_enabled ? merge(
    local.dotnet_service_skeleton_template_map,
    {
      # Backstage root catalog-info remains templated
      "catalog-info.yaml" = {
        source_file      = "${path.module}/templates/dotnet-service/catalog-info.yaml.tpl"
        commit_message   = "Add .NET service template catalog-info.yaml for Backstage"
        use_templatefile = true
        template_vars = {
          github_organization = var.github_organization
        }
      }

      "README.md" = {
        source_file      = "${path.module}/templates/dotnet-service/README.md"
        commit_message   = "Add .NET service template README"
        use_templatefile = false
        template_vars    = {}
      }
    }
  ) : {}
}

# Regular file resources (direct file content)
resource "github_repository_file" "dotnet_service_files" {
  for_each = local.dotnet_service_files

  repository          = github_repository.templates[local.dotnet_service_key].name
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
resource "github_repository_file" "dotnet_service_template_files" {
  for_each = local.dotnet_service_template_files

  repository = github_repository.templates[local.dotnet_service_key].name
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
