#!/usr/bin/env bash
# Configure organization Codespaces access settings.
# Exits 0 on success, non-zero on failure.
# Env vars required:
#   ORG_NAME, PAYLOAD_JSON (JSON body with visibility & selected_usernames logic already prepared)
#   DESIRED_VIS (for logging only)
#   APP_ID / INSTALLATION_ID / PEM_CONTENT (or preset GITHUB_TOKEN) for auth
# Optional:
#   LOG_FILE (default /tmp/codespaces-org-access.log)
#   GITHUB_API_URL (override API base)
set -eo pipefail
LOG_FILE="${LOG_FILE:-/tmp/codespaces-org-access.log}"
mkdir -p "$(dirname "$LOG_FILE")" || true

log(){ echo "$(date -Is) $*" >>"$LOG_FILE"; }

if [ -z "${ORG_NAME:-}" ] || [ -z "${PAYLOAD_JSON:-}" ]; then
  echo "ERROR: ORG_NAME and PAYLOAD_JSON are required" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
log "START org=$ORG_NAME vis=${DESIRED_VIS:-unknown}" 

# Acquire token if not provided
if [ -z "${GITHUB_TOKEN:-}" ]; then
  log "STEP acquire-token"
  GITHUB_TOKEN=$(APP_ID="$APP_ID" INSTALLATION_ID="$INSTALLATION_ID" PEM_CONTENT="$PEM_CONTENT" LOG_FILE="$LOG_FILE" "$SCRIPT_DIR/github_app_token.sh") || {
    log "FATAL token-acquisition"
    echo "ERROR: Failed to acquire token" >&2
    exit 1
  }
fi

API_BASE="${GITHUB_API_URL:-https://api.github.com}"

log "STEP put-codespaces-access"
RESP_ALL=$(curl -sS -w "\n%{http_code}" -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "$API_BASE/orgs/$ORG_NAME/codespaces/access" \
  -d "$PAYLOAD_JSON")
STATUS=$(printf '%s' "$RESP_ALL" | tail -n1)
BODY=$(printf '%s' "$RESP_ALL" | sed '$d')
log "RESULT status=$STATUS"

if [ "$STATUS" != 204 ] && [ "$STATUS" != 200 ] && [ "$STATUS" != 304 ]; then
  SNIP=$(echo "$BODY" | head -c 400 | tr '\n' ' ')
  log "ERROR status=$STATUS body_snip=$SNIP"
  echo "ERROR: Failed to set Codespaces access (HTTP $STATUS)" >&2
  exit 1
fi

echo "Codespaces org access set to ${DESIRED_VIS:-unknown} for $ORG_NAME (HTTP $STATUS)"
exit 0
