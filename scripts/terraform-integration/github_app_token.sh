#!/usr/bin/env bash
# Mint a GitHub App installation access token.
# Usage: source or run and capture output:
#   TOKEN=$(scripts/github_app_token.sh)   (expects env vars)
# Required env vars:
#   APP_ID            GitHub App ID
#   INSTALLATION_ID   Installation ID for the org
#   PEM_FILE          Path to private key (.pem)
# Optional env vars:
#   LOG_FILE          Append logs here
#   GITHUB_API_URL    Override API base (default https://api.github.com)
# Output: writes token to stdout; exits non-zero on error.
set -eo pipefail

API_BASE="${GITHUB_API_URL:-https://api.github.com}"
LOG_FILE="${LOG_FILE:-}"

log() { if [ -n "$LOG_FILE" ]; then echo "$(date -Is) $*" >>"$LOG_FILE"; fi }

if [ -n "${GITHUB_TOKEN:-}" ]; then
  # If a token already provided, just echo it (idempotent helper behavior)
  echo "$GITHUB_TOKEN"
  exit 0
fi

if [ -z "${APP_ID:-}" ] || [ -z "${INSTALLATION_ID:-}" ] || [ -z "${PEM_FILE:-}" ]; then
  echo "ERROR: APP_ID, INSTALLATION_ID, and PEM_FILE are required (or preset GITHUB_TOKEN)" >&2
  log "FATAL missing-env app_id='${APP_ID:-}' install_id='${INSTALLATION_ID:-}' pem='${PEM_FILE:-}'"
  exit 1
fi

if [ ! -f "$PEM_FILE" ]; then
  echo "ERROR: PEM_FILE '$PEM_FILE' not found" >&2
  log "FATAL missing-pem path='$PEM_FILE'"
  exit 1
fi

# Build JWT
NOW=$(date +%s); IAT=$((NOW-60)); EXP=$((NOW+600))
HEADER='{"alg":"RS256","typ":"JWT"}'
PAYLOAD_JWT='{"iat":'$IAT',"exp":'$EXP',"iss":"'$APP_ID'"}'

b64() { echo -n "$1" | base64 -w0 | tr -d '=' | tr '/+' '_-'; }
HEADER_B64=$(b64 "$HEADER")
PAYLOAD_B64=$(b64 "$PAYLOAD_JWT")
SIGNATURE=$(echo -n "$HEADER_B64.$PAYLOAD_B64" | openssl dgst -sha256 -sign "$PEM_FILE" | base64 -w0 | tr -d '=' | tr '/+' '_-')
JWT="$HEADER_B64.$PAYLOAD_B64.$SIGNATURE"

log "STEP request-installation-token install_id=$INSTALLATION_ID"
RESP=$(curl -sS -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $JWT" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "$API_BASE/app/installations/$INSTALLATION_ID/access_tokens" || true)

TOKEN=$(echo "$RESP" | sed -n 's/.*"token":[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
if [ -z "$TOKEN" ]; then
  SNIP=$(echo "$RESP" | head -c 200 | tr '\n' ' ')
  log "FATAL token-mint-failed resp_snip=$SNIP"
  echo "ERROR: Failed to mint installation token" >&2
  exit 1
fi
log "STEP token-minted"

echo "$TOKEN"
