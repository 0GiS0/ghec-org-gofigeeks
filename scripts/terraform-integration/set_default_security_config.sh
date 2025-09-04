#!/bin/bash

# Script to set a specific code security configuration as default for the organization
# This calls the GitHub REST API since this functionality is not available in Terraform provider
#
# Usage: 
#   set_default_security_config.sh [CONFIG_NAME] [SCOPE]
#   
# Parameters:
#   CONFIG_NAME: Name of the configuration to set as default (default: "GitHub recommended")
#   SCOPE: Scope for new repos - "public", "private", or "public_and_private" (default: "public_and_private")

set -euo pipefail

# Parse command line arguments
CONFIG_NAME="${1:-GitHub recommended}"
SCOPE="${2:-public_and_private}"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required environment variables are set for GitHub App authentication
if [ -z "${GITHUB_APP_ID:-}" ] || [ -z "${GITHUB_APP_INSTALLATION_ID:-}" ] || [ -z "${GITHUB_APP_PRIVATE_KEY:-}" ]; then
    print_error "GitHub App authentication variables are required:"
    echo "  - GITHUB_APP_ID"
    echo "  - GITHUB_APP_INSTALLATION_ID"
    echo "  - GITHUB_APP_PRIVATE_KEY"
    exit 1
fi

if [ -z "${GITHUB_ORGANIZATION:-}" ]; then
    print_error "GITHUB_ORGANIZATION environment variable is required"
    echo "Please set your GitHub organization:"
    echo "export GITHUB_ORGANIZATION='your_org_here'"
    exit 1
fi

print_info "Generating GitHub App token..."

# Generate GitHub App token using the existing script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Debug: Show what we're passing to the token script
print_info "Using GitHub App ID: ${GITHUB_APP_ID}"
print_info "Using Installation ID: ${GITHUB_APP_INSTALLATION_ID}"

GITHUB_TOKEN=$(APP_ID="$GITHUB_APP_ID" INSTALLATION_ID="$GITHUB_APP_INSTALLATION_ID" PEM_CONTENT="$GITHUB_APP_PRIVATE_KEY" "$SCRIPT_DIR/github_app_token.sh" 2>&1)

# Check if token generation failed
if [ $? -ne 0 ] || [ -z "$GITHUB_TOKEN" ] || [ "$GITHUB_TOKEN" = "null" ]; then
    print_error "Failed to generate GitHub App token"
    echo "Token script output: $GITHUB_TOKEN"
    exit 1
fi

print_info "GitHub App token generated successfully"

# GitHub API settings
API_VERSION="2022-11-28"
BASE_URL="https://api.github.com"
ORG="$GITHUB_ORGANIZATION"

# Validate scope parameter
if [[ ! "$SCOPE" =~ ^(all|none|public|private_and_internal)$ ]]; then
    print_error "Invalid scope: $SCOPE. Must be one of: all, none, public, private_and_internal"
    exit 1
fi

print_info "Setting up '$CONFIG_NAME' security configuration as default for organization: $ORG"
print_info "Scope: $SCOPE"

# Step 1: Get all available code security configurations
print_info "Fetching available code security configurations..."

CONFIGS_RESPONSE=$(curl -s \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: $API_VERSION" \
    "$BASE_URL/orgs/$ORG/code-security/configurations")

# Check if the API call was successful
if ! echo "$CONFIGS_RESPONSE" | jq . > /dev/null 2>&1; then
    print_error "Failed to fetch configurations or invalid JSON response"
    echo "Response: $CONFIGS_RESPONSE"
    exit 1
fi

# Step 2: Find the specified configuration ID
print_info "Looking for '$CONFIG_NAME' configuration..."

CONFIG_ID=$(echo "$CONFIGS_RESPONSE" | jq -r --arg name "$CONFIG_NAME" '.[] | select(.name == $name) | .id')

if [ -z "$CONFIG_ID" ] || [ "$CONFIG_ID" = "null" ]; then
    print_warning "'$CONFIG_NAME' configuration not found. Available configurations:"
    echo "$CONFIGS_RESPONSE" | jq -r '.[] | "\(.id): \(.name) (target_type: \(.target_type))"'
    
    # Try to find any configuration with the specified name (case insensitive)
    CONFIG_ID=$(echo "$CONFIGS_RESPONSE" | jq -r --arg name "$CONFIG_NAME" '.[] | select(.name | test($name; "i")) | .id' | head -1)
    
    if [ -n "$CONFIG_ID" ] && [ "$CONFIG_ID" != "null" ]; then
        FOUND_NAME=$(echo "$CONFIGS_RESPONSE" | jq -r ".[] | select(.id == $CONFIG_ID) | .name")
        print_warning "Using configuration: '$FOUND_NAME' (ID: $CONFIG_ID)"
    else
        print_error "Configuration '$CONFIG_NAME' not found"
        exit 1
    fi
else
    print_info "Found '$CONFIG_NAME' configuration with ID: $CONFIG_ID"
fi

# Step 3: Set the configuration as default for the organization
print_info "Setting '$CONFIG_NAME' as default for organization..."

DEFAULT_RESPONSE=$(curl -s -w "%{http_code}" \
    -X PUT \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: $API_VERSION" \
    -H "Content-Type: application/json" \
    "$BASE_URL/orgs/$ORG/code-security/configurations/$CONFIG_ID/defaults" \
    -d "{
        \"default_for_new_repos\": \"$SCOPE\"
    }")

# Extract HTTP status code (last 3 characters)
HTTP_STATUS="${DEFAULT_RESPONSE: -3}"
RESPONSE_BODY="${DEFAULT_RESPONSE%???}"

case $HTTP_STATUS in
    200)
        print_info "✅ Successfully set '$CONFIG_NAME' configuration as default!"
        print_info "Configuration will be applied to all new $SCOPE repositories."
        ;;
    204)
        print_info "✅ Successfully updated default security configuration!"
        ;;
    404)
        print_error "Configuration not found or organization doesn't exist"
        echo "Response: $RESPONSE_BODY"
        exit 1
        ;;
    403)
        print_error "Insufficient permissions. Token needs 'admin:org' scope"
        echo "Response: $RESPONSE_BODY"
        exit 1
        ;;
    422)
        print_error "Invalid request parameters"
        echo "Response: $RESPONSE_BODY"
        exit 1
        ;;
    *)
        print_error "Unexpected response (HTTP $HTTP_STATUS)"
        echo "Response: $RESPONSE_BODY"
        exit 1
        ;;
esac

# Step 4: Verify the configuration was set correctly
print_info "Verifying default configuration..."

VERIFY_RESPONSE=$(curl -s \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: $API_VERSION" \
    "$BASE_URL/orgs/$ORG/code-security/configurations/defaults")

if echo "$VERIFY_RESPONSE" | jq . > /dev/null 2>&1; then
    # Extract the configuration ID and scope from the verification response
    DEFAULT_CONFIG_ID=$(echo "$VERIFY_RESPONSE" | jq -r '.configuration.id // empty' 2>/dev/null || echo "")
    DEFAULT_SCOPE=$(echo "$VERIFY_RESPONSE" | jq -r '.default_for_new_repos // empty' 2>/dev/null || echo "")
    
    if [ -n "$DEFAULT_CONFIG_ID" ] && [ "$DEFAULT_CONFIG_ID" = "$CONFIG_ID" ]; then
        print_info "✅ Verification successful! Default configuration is set correctly."
        print_info "Configuration ID: $DEFAULT_CONFIG_ID"
        print_info "Applied scope: $DEFAULT_SCOPE"
    elif [ -n "$DEFAULT_CONFIG_ID" ]; then
        print_warning "Verification shows different configuration ID: $DEFAULT_CONFIG_ID (expected: $CONFIG_ID)"
        print_info "Applied scope: $DEFAULT_SCOPE"
    else
        print_warning "Could not extract configuration ID from verification response"
    fi
    
    # Show configuration details if available
    CONFIG_NAME=$(echo "$VERIFY_RESPONSE" | jq -r '.configuration.name // empty' 2>/dev/null || echo "")
    if [ -n "$CONFIG_NAME" ]; then
        print_info "Configuration name: $CONFIG_NAME"
    fi
else
    print_warning "Could not verify configuration (invalid JSON response or API error)"
fi

print_info "🎉 Default security configuration setup completed!"
echo
echo "This configuration will now be automatically applied to:"

case $SCOPE in
    "public")
        echo "  • All new public repositories"
        ;;
    "private") 
        echo "  • All new private repositories"
        ;;
    "public_and_private")
        echo "  • All new public repositories"
        echo "  • All new private repositories"
        ;;
esac

echo
echo "For existing repositories, you may want to apply the configuration manually through the GitHub UI or API."
