# MCP Server Node.js Template Repository Files
# This file contains all file resources specific to the MCP Server (Node.js) template

locals {
  # Template-specific configuration
  mcp_server_node_key     = "backstage-template-mcp-server-node"
  mcp_server_node_enabled = contains(keys(var.template_repositories), local.mcp_server_node_key)

  # Dynamically list all skeleton files (fileset returns files only)
  mcp_server_node_skeleton_all = local.mcp_server_node_enabled ? fileset(path.module, "software_templates/mcp-server-node/skeleton/**") : []

  # Exclude unwanted directories to avoid committing generated artifacts or dependencies (node_modules, coverage, dist)
  mcp_server_node_skeleton_all_filtered = [
    for f in local.mcp_server_node_skeleton_all : f
    if length(regexall("/node_modules/", f)) == 0
    && length(regexall("/coverage/", f)) == 0
    && length(regexall("/dist/", f)) == 0
  ]

  # Separate template (.tpl) files vs regular files (after filtering)
  mcp_server_node_skeleton_template_raw = [for f in local.mcp_server_node_skeleton_all_filtered : f if endswith(f, ".tpl")]
  mcp_server_node_skeleton_regular_raw  = [for f in local.mcp_server_node_skeleton_all_filtered : f if !endswith(f, ".tpl")]

  # Map for regular skeleton files (destination keeps skeleton/ prefix)
  mcp_server_node_skeleton_regular_map = { for f in local.mcp_server_node_skeleton_regular_raw :
    replace(f, "software_templates/mcp-server-node/", "") => {
      source_file    = "${path.module}/${f}"
      commit_message = "Sync MCP Server Node skeleton file ${replace(f, "software_templates/mcp-server-node/", "")}"
    }
  }

  # Map for templated skeleton files (.tpl) removing extension in destination (none currently, but keep logic for future)
  mcp_server_node_skeleton_template_map = { for f in local.mcp_server_node_skeleton_template_raw :
    replace(replace(f, "software_templates/mcp-server-node/", ""), ".tpl", "") => {
      source_file      = "${path.module}/${f}"
      commit_message   = "Add templated MCP Server Node skeleton file ${replace(replace(f, "software_templates/mcp-server-node/", ""), ".tpl", "")}"
      use_templatefile = true
      template_vars = {
        github_organization = var.github_organization
      }
    }
  }

  # Explicit template-level (non-skeleton) regular files
  mcp_server_node_template_level_files = local.mcp_server_node_enabled ? merge({
    # Top-level README for the template (documentation)
    "README.md" = {
      source_file    = "${path.module}/software_templates/mcp-server-node/README.md"
      commit_message = "Add MCP Server Node.js template README"
    }
    }, {
    for f in fileset(path.module, "software_templates/mcp-server-node/docs/**") :
    replace(f, "software_templates/mcp-server-node/", "") => {
      source_file    = "${path.module}/${f}"
      commit_message = "Add MCP Server Node.js template docs file ${replace(f, "software_templates/mcp-server-node/", "")}"
    }
  }) : {}

  # Combine skeleton regular + template-level regular files
  mcp_server_node_files = local.mcp_server_node_enabled ? merge(
    local.mcp_server_node_skeleton_regular_map,
    local.mcp_server_node_template_level_files
  ) : {}

  # Template-level templated files
  mcp_server_node_template_files = local.mcp_server_node_enabled ? merge(
    local.mcp_server_node_skeleton_template_map,
    {
      # Backstage root catalog-info remains templated
      # Note: source filename in template folder is intentionally "catelog-info.yaml.tpl" (typo retained in source path)
      "catalog-info.yaml" = {
        source_file      = "${path.module}/software_templates/mcp-server-node/catelog-info.yaml.tpl"
        commit_message   = "Add MCP Server Node.js template catalog-info.yaml for Backstage"
        use_templatefile = true
        template_vars = {
          github_organization = var.github_organization
          github_repository   = local.mcp_server_node_key
        }
      }
    }
  ) : {}
}

# Regular file resources (direct file content)
resource "github_repository_file" "mcp_server_node_files" {
  for_each = local.mcp_server_node_files

  repository          = github_repository.templates[local.mcp_server_node_key].name
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
resource "github_repository_file" "mcp_server_node_template_files" {
  for_each = local.mcp_server_node_template_files

  repository = github_repository.templates[local.mcp_server_node_key].name
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
