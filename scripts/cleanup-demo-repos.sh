#!/bin/bash

#################################################################
# Demo Repository Cleanup Script
# 
# This script identifies and optionally deletes repositories 
# that have the 'demo' custom property set to 'yes'
#################################################################

set -euo pipefail

# Configuration
ORG_NAME="${ORG_NAME:-}"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"
DRY_RUN="${DRY_RUN:-true}"
CONFIRM_DELETE="${CONFIRM_DELETE:-false}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

usage() {
    cat << EOF
Usage: $0 [OPTIONS]

This script identifies and optionally deletes GitHub repositories that have 
the 'demo' custom property set to 'yes'.

OPTIONS:
    -o, --org         GitHub organization name (required)
    -t, --token       GitHub token with repo:delete permissions (required)
    -d, --delete      Actually delete repositories (default: dry run)
    -c, --confirm     Skip interactive confirmation (dangerous!)
    -h, --help        Show this help message

ENVIRONMENT VARIABLES:
    ORG_NAME          GitHub organization name
    GITHUB_TOKEN      GitHub token
    DRY_RUN           Set to 'false' to enable deletion (default: true)
    CONFIRM_DELETE    Set to 'true' to skip confirmation prompts (default: false)

EXAMPLES:
    # Dry run (list demo repos without deleting)
    $0 --org myorg --token ghp_xxxx

    # Delete demo repos with confirmation prompts
    $0 --org myorg --token ghp_xxxx --delete

    # Delete demo repos without prompts (be careful!)
    $0 --org myorg --token ghp_xxxx --delete --confirm

    # Using environment variables
    ORG_NAME=myorg GITHUB_TOKEN=ghp_xxxx DRY_RUN=false $0

EOF
}

log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING:${NC} $1"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR:${NC} $1" >&2
}

success() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] SUCCESS:${NC} $1"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -o|--org)
            ORG_NAME="$2"
            shift 2
            ;;
        -t|--token)
            GITHUB_TOKEN="$2"
            shift 2
            ;;
        -d|--delete)
            DRY_RUN="false"
            shift
            ;;
        -c|--confirm)
            CONFIRM_DELETE="true"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            error "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Validate required parameters
if [[ -z "$ORG_NAME" ]]; then
    error "Organization name is required. Use -o/--org or set ORG_NAME environment variable."
    exit 1
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
    error "GitHub token is required. Use -t/--token or set GITHUB_TOKEN environment variable."
    exit 1
fi

# Function to make GitHub API calls
github_api() {
    local endpoint="$1"
    local method="${2:-GET}"
    
    curl -s \
        -X "$method" \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com$endpoint"
}

# Function to get repositories with demo=yes
get_demo_repos() {
    log "Fetching repositories in organization '$ORG_NAME'..."
    
    local page=1
    local per_page=100
    local demo_repos=()
    
    while true; do
        local repos
        repos=$(github_api "/orgs/$ORG_NAME/repos?page=$page&per_page=$per_page&sort=updated&direction=desc")
        
        if [[ $(echo "$repos" | jq length) -eq 0 ]]; then
            break
        fi
        
        # Check each repository for demo custom property
        while read -r repo_name; do
            if [[ -n "$repo_name" && "$repo_name" != "null" ]]; then
                log "Checking custom properties for repository: $repo_name"
                
                local properties
                properties=$(github_api "/repos/$ORG_NAME/$repo_name/properties/values" 2>/dev/null || echo "[]")
                
                # Check if demo property exists and equals "yes"
                local demo_value
                demo_value=$(echo "$properties" | jq -r '.[] | select(.property_name == "demo") | .value // empty')
                
                if [[ "$demo_value" == "yes" ]]; then
                    demo_repos+=("$repo_name")
                    success "Found demo repository: $repo_name"
                fi
            fi
        done < <(echo "$repos" | jq -r '.[].name')
        
        ((page++))
    done
    
    echo "${demo_repos[@]}"
}

# Function to delete a repository
delete_repo() {
    local repo_name="$1"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        warn "DRY RUN: Would delete repository '$repo_name'"
        return 0
    fi
    
    if [[ "$CONFIRM_DELETE" != "true" ]]; then
        echo -n "Are you sure you want to delete repository '$repo_name'? [y/N]: "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            warn "Skipping deletion of '$repo_name'"
            return 0
        fi
    fi
    
    log "Deleting repository: $repo_name"
    local result
    result=$(github_api "/repos/$ORG_NAME/$repo_name" "DELETE")
    
    if [[ -z "$result" ]]; then
        success "Successfully deleted repository: $repo_name"
    else
        error "Failed to delete repository '$repo_name': $result"
        return 1
    fi
}

# Main execution
main() {
    log "Starting demo repository cleanup for organization: $ORG_NAME"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        warn "Running in DRY RUN mode. No repositories will be deleted."
        warn "Use --delete flag to actually delete repositories."
    else
        warn "DELETION MODE ENABLED. Repositories will be permanently deleted!"
    fi
    
    # Get demo repositories
    local demo_repos
    demo_repos=($(get_demo_repos))
    
    if [[ ${#demo_repos[@]} -eq 0 ]]; then
        log "No repositories found with demo property set to 'yes'"
        exit 0
    fi
    
    log "Found ${#demo_repos[@]} demo repositories:"
    for repo in "${demo_repos[@]}"; do
        echo "  - $repo"
    done
    
    if [[ "$DRY_RUN" != "true" && "$CONFIRM_DELETE" != "true" ]]; then
        echo -n "Do you want to proceed with deleting these ${#demo_repos[@]} repositories? [y/N]: "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            warn "Operation cancelled by user"
            exit 0
        fi
    fi
    
    # Process each repository
    local success_count=0
    local failure_count=0
    
    for repo in "${demo_repos[@]}"; do
        if delete_repo "$repo"; then
            ((success_count++))
        else
            ((failure_count++))
        fi
    done
    
    # Summary
    log "Cleanup completed:"
    if [[ "$DRY_RUN" == "true" ]]; then
        log "  - Found: ${#demo_repos[@]} demo repositories"
        log "  - Would delete: ${#demo_repos[@]} repositories"
    else
        log "  - Processed: ${#demo_repos[@]} repositories"
        log "  - Successfully deleted: $success_count"
        log "  - Failed: $failure_count"
    fi
}

# Run main function
main "$@"