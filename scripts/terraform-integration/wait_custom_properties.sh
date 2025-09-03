#!/usr/bin/env bash
# Wait until required organization custom properties are visible
# Exits 0 when all properties exist, 1 on timeout or error.
# Env vars: ORG_NAME, REQUIRED_PROPERTIES (comma-separated list) or defaults to service-tier,team-owner
#           APP_ID, INSTALLATION_ID, PEM_FILE for token (unless GITHUB_TOKEN preset)
# Optional: TIMEOUT_SECONDS (default 30), SLEEP_SECONDS (default 2), LOG_FILE
set -euo pipefail
REQUIRED_PROPERTIES=${REQUIRED_PROPERTIES:-service-tier,team-owner}
TIMEOUT_SECONDS=${TIMEOUT_SECONDS:-30}
SLEEP_SECONDS=${SLEEP_SECONDS:-2}
LOG_FILE=${LOG_FILE:-/tmp/wait-custom-properties.log}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log(){ echo "$(date -Is) $*" | tee -a "$LOG_FILE" >&2; }

if [ -z "${GITHUB_TOKEN:-}" ]; then
  log "acquire-token"
  GITHUB_TOKEN=$(APP_ID="$APP_ID" INSTALLATION_ID="$INSTALLATION_ID" PEM_FILE="$PEM_FILE" LOG_FILE="$LOG_FILE" "$SCRIPT_DIR/github_app_token.sh") || {
    log "ERROR token acquisition failed"; exit 1; }
fi

IFS=',' read -r -a props <<<"$REQUIRED_PROPERTIES"
start=$(date +%s)
while true; do
  all_found=true
  for p in "${props[@]}"; do
    status=$(curl -s -o /dev/null -w '%{http_code}' -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GITHUB_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/orgs/$ORG_NAME/properties/schema/$p" || echo 000)
    if [ "$status" != "200" ]; then
      log "property $p not yet ready (status=$status)"
      all_found=false
    fi
  done
  if $all_found; then
    log "all properties present"; exit 0; fi
  now=$(date +%s); elapsed=$(( now - start ))
  if [ $elapsed -ge $TIMEOUT_SECONDS ]; then
    log "TIMEOUT after ${elapsed}s waiting for properties: $REQUIRED_PROPERTIES"; exit 1; fi
  sleep "$SLEEP_SECONDS"
 done
