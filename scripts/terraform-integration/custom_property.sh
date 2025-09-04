#!/usr/bin/env bash
# Manage a single GitHub organization custom property (create or update)
# Exits 0 on success or tolerated (non-fatal) failure when NON_FATAL_404=true.
# Required env vars:
#   ORG_NAME, PROPERTY_NAME, PROPERTY_PAYLOAD (JSON body for creation/update)
#   APP_ID, INSTALLATION_ID, PEM_CONTENT (GitHub App creds) OR pre-set GITHUB_TOKEN
#   NON_FATAL_404 (true/false)
# Optional: LOG_FILE (defaults to /tmp/custom-properties-$PROPERTY_NAME.log)
#
# PROPERTY_PAYLOAD example json (single line):
# {"property_name":"team-owner","description":"Team owner","value_type":"string",...}
#
set -eo pipefail

LOG_FILE="${LOG_FILE:-/tmp/custom-properties-${PROPERTY_NAME}.log}"
mkdir -p "$(dirname "$LOG_FILE")" || true
{
  echo "$(date -Is) START property=$PROPERTY_NAME org=$ORG_NAME"
} >>"$LOG_FILE"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "$(date -Is) STEP acquire-token" >>"$LOG_FILE"
  GITHUB_TOKEN=$(APP_ID="$APP_ID" INSTALLATION_ID="$INSTALLATION_ID" PEM_CONTENT="$PEM_CONTENT" LOG_FILE="$LOG_FILE" "$SCRIPT_DIR/github_app_token.sh") || {
    echo "$(date -Is) ERROR token-acquisition" >>"$LOG_FILE"
    echo "ERROR: Failed to acquire token" >&2
    exit 1
  }
fi

API_BASE="https://api.github.com"; ORG="$ORG_NAME"; NAME="$PROPERTY_NAME"; PAYLOAD="$PROPERTY_PAYLOAD"

# Check existing
echo "$(date -Is) STEP check-existing" >>"$LOG_FILE"
CHECK_RESP=$(curl -sS -w "\n%{http_code}" -X GET \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "$API_BASE/orgs/$ORG/properties/schema/$NAME" 2>/dev/null || echo -e "\n404")
CHECK_STATUS=$(printf '%s' "$CHECK_RESP" | tail -n1)

if [ "$CHECK_STATUS" = "404" ] && [ "${NON_FATAL_404}" = "true" ]; then
  echo "$(date -Is) WARN feature-unavailable-404 skip property=$NAME" >>"$LOG_FILE"
  echo "WARNING: Skipping $NAME (org custom properties unsupported / permission missing)." >&2
  exit 0
fi

# Always use PUT method for individual property creation/update
METHOD="PUT"
URL="$API_BASE/orgs/$ORG/properties/schema/$NAME"

# Extract only the property definition fields from the payload (remove property_name)
PROPERTY_DEF=$(echo "$PAYLOAD" | jq 'del(.property_name)')
if [ $? -ne 0 ] || [ -z "$PROPERTY_DEF" ]; then
  echo "$(date -Is) ERROR invalid-json payload=$PAYLOAD" >>"$LOG_FILE"
  echo "ERROR: Invalid JSON payload for property $NAME" >&2
  exit 1
fi

echo "$(date -Is) STEP $METHOD request url=$URL" >>"$LOG_FILE"
RESP_ALL=$(curl -sS -w "\n%{http_code}" -X "$METHOD" \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -H "User-Agent: terraform-custom-properties-script" \
  "$URL" \
  -d "$PROPERTY_DEF")
STATUS=$(printf '%s' "$RESP_ALL" | tail -n1)
BODY=$(printf '%s' "$RESP_ALL" | sed '$d')

echo "$(date -Is) RESULT status=$STATUS method=$METHOD property=$NAME" >>"$LOG_FILE"

if [ "$STATUS" != 200 ] && [ "$STATUS" != 201 ]; then
  if [ "${NON_FATAL_404}" = "true" ]; then
    echo "$(date -Is) WARN non-fatal-skip status=$STATUS snippet=$(echo "$BODY" | head -c 120 | tr '\n' ' ')" >>"$LOG_FILE"
    echo "WARNING: Skipping $NAME (HTTP $STATUS non-fatal)." >&2
    exit 0
  fi
  echo "$(date -Is) ERROR body: $BODY" >>"$LOG_FILE"
  echo "ERROR: Failed $METHOD for property $NAME (HTTP $STATUS)" >&2
  exit 1
fi

echo "Custom property $NAME configured (HTTP $STATUS)"; exit 0
