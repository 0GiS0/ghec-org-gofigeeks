###############################################
# Organization Codespaces Access (optional)
# Managed via GitHub REST API using curl
# Requires a token with org codespaces settings: write (or classic PAT with admin:org)
###############################################

locals {
  _codespaces_payload_data = {
    visibility         = var.codespaces_visibility
    selected_usernames = var.codespaces_visibility == "selected_members" ? var.codespaces_selected_usernames : []
  }
  codespaces_payload = jsonencode(local._codespaces_payload_data)
}

resource "null_resource" "org_codespaces_access" {
  count = var.enable_codespaces_org_access ? 1 : 0

  triggers = {
    org     = var.github_organization
    payload = local.codespaces_payload
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "scripts/terraform-integration/codespaces_access.sh"
    environment = {
      ORG_NAME        = var.github_organization
      PAYLOAD_JSON    = local.codespaces_payload
      DESIRED_VIS     = var.codespaces_visibility
      APP_ID          = var.github_app_id
      INSTALLATION_ID = var.github_app_installation_id
      PEM_FILE        = abspath(var.github_app_pem_file)
      LOG_FILE        = "/tmp/codespaces-org-access.log"
    }
  }
}
