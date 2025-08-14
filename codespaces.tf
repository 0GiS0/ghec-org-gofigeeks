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

  # Re-run when org or payload changes
  triggers = {
    org     = var.github_organization
    payload = local.codespaces_payload
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      set -eo pipefail

      # Log file for diagnostics (initialize early)
        LOG_FILE="$${LOG_FILE:-/tmp/codespaces-org-access.log}"
      mkdir -p "$(dirname "$LOG_FILE")" || true
        # Capture stderr to log for troubleshooting
        exec 2>>"$LOG_FILE"
        echo "$(date -Is) START org=$ORG_NAME vis=$DESIRED_VIS" >> "$LOG_FILE"

      # Authenticate ONLY via GitHub App (no PAT/env token fallback)
      if [ -z "$APP_ID" ] || [ -z "$INSTALLATION_ID" ] || [ -z "$PEM_FILE" ] || [ ! -f "$PEM_FILE" ]; then
        echo "ERROR: Missing GitHub App credentials. Required env: APP_ID, INSTALLATION_ID, PEM_FILE (existing .pem)." >&2
          echo "$(date -Is) FATAL missing-app-creds app_id_set=$( [ -n \"$APP_ID\" ] && echo yes || echo no ) install_id_set=$( [ -n \"$INSTALLATION_ID\" ] && echo yes || echo no ) pem_file='$PEM_FILE' exists=$( [ -f \"$PEM_FILE\" ] && echo yes || echo no )" >> "$LOG_FILE"
        exit 1
      fi

      # Build a short-lived JWT for the App and exchange for an installation token
      b64url() { openssl base64 -A | tr '+/' '-_' | tr -d '='; }

      NOW=$(date -u +%s)
      IAT=$((NOW - 60))
      EXP=$((NOW + 600))

      HEADER=$(printf '{"alg":"RS256","typ":"JWT"}' | b64url)
      PAY=$(printf '{"iat":%s,"exp":%s,"iss":"%s"}' "$IAT" "$EXP" "$APP_ID" | b64url)
      SIG=$(printf '%s.%s' "$HEADER" "$PAY" | openssl dgst -binary -sha256 -sign "$PEM_FILE" | b64url)
      JWT="$HEADER.$PAY.$SIG"

        echo "$(date -Is) STEP request-installation-token" >> "$LOG_FILE"
        RESP_ALL=$(curl -sS -w "\n%%{http_code}" -X POST \
          -H "Accept: application/vnd.github+json" \
          -H "Authorization: Bearer $JWT" \
          -H "X-GitHub-Api-Version: 2022-11-28" \
          "https://api.github.com/app/installations/$INSTALLATION_ID/access_tokens")

        RESP_STATUS=$(printf '%s' "$RESP_ALL" | tail -n1)
        RESP_BODY=$(printf '%s' "$RESP_ALL" | sed '$d')

        # Parse token safely without failing pipeline under pipefail
    GITHUB_TOKEN=$(printf '%s' "$RESP_BODY" | sed -n 's/.*"token":[[:space:]]*"\([^\"]*\)".*/\1/p' | head -1)
        if [ -z "$GITHUB_TOKEN" ]; then
          echo "ERROR: Failed to mint installation token via GitHub App (HTTP $RESP_STATUS)." >&2
          # Body should not contain token on failure; log snippet for diagnostics
          SNIP=$(printf '%s' "$RESP_BODY" | head -c 300 | tr '\n' ' ')
          echo "$(date -Is) FATAL token-mint-failed status=$RESP_STATUS body_snip=$SNIP" >> "$LOG_FILE"
          exit 1
        fi

        echo "$(date -Is) STEP token-minted" >> "$LOG_FILE"
      ORG="$ORG_NAME"
      PAYLOAD="$PAYLOAD_JSON"
      VIS="$DESIRED_VIS"

      # Capture both body and status
        echo "$(date -Is) STEP put-codespaces-access org=$ORG" >> "$LOG_FILE"
      RESP_ALL=$(curl -sS -w "\n%%{http_code}" -X PUT \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/orgs/$ORG/codespaces/access" \
        -d "$PAYLOAD")

      STATUS=$(printf '%s' "$RESP_ALL" | tail -n1)
      BODY=$(printf '%s' "$RESP_ALL" | sed '$d')

      echo "$(date -Is) PUT /orgs/$ORG/codespaces/access status=$STATUS visibility=$VIS" >> "$LOG_FILE"

      if [ "$STATUS" != "204" ] && [ "$STATUS" != "200" ]; then
        echo "$(date -Is) ERROR body: $BODY" >> "$LOG_FILE"
        echo "ERROR: Failed to set Codespaces access. HTTP $STATUS. See $(basename "$LOG_FILE") for details." >&2
        exit 1
      fi

      echo "Codespaces org access set to $VIS for $ORG (HTTP $STATUS)"
    EOT

    environment = {
      ORG_NAME     = var.github_organization
      PAYLOAD_JSON = local.codespaces_payload
      DESIRED_VIS  = var.codespaces_visibility
      # GitHub App token minting
      APP_ID          = var.github_app_id
      INSTALLATION_ID = var.github_app_installation_id
      PEM_FILE        = abspath(var.github_app_pem_file)
      LOG_FILE        = "/tmp/codespaces-org-access.log"
    }
  }
}
