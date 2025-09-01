# Dependabot Configuration for Template Repositories

This directory contains Dependabot configuration templates that are deployed to all Backstage template repositories.

## Template Files

### `npm.yml.tpl`
**Used by:** `backstage-template-node-service`, `backstage-template-astro-frontend`
**Monitors:**
- npm dependencies in `/skeleton` directory
- GitHub Actions in `/` directory

### `pip.yml.tpl`
**Used by:** `backstage-template-fastapi-service`, `backstage-template-ai-assistant`
**Monitors:**
- pip dependencies in `/skeleton` directory (requirements.txt files)
- GitHub Actions in `/` directory

### `nuget.yml.tpl`
**Used by:** `backstage-template-dotnet-service`
**Monitors:**
- NuGet dependencies in `/skeleton` directory (*.csproj files)
- GitHub Actions in `/` directory

### `docker.yml.tpl`
**Used by:** `backstage-template-gateway`
**Monitors:**
- Docker dependencies in `/skeleton` directory (Dockerfile)
- GitHub Actions in `/` directory

### `basic.yml.tpl`
**Used by:** `backstage-template-helm-base`, `backstage-template-env-live`
**Monitors:**
- GitHub Actions in `/` directory only

## Configuration Details

All Dependabot configurations:
- Run weekly on Mondays at 09:00 UTC
- Limit pull requests per ecosystem (3-5 PRs)
- Assign reviews to `@{organization}/template-approvers` team
- Use appropriate commit message prefixes and labels
- Target the main branch

## Deployment

These templates are deployed automatically via Terraform using the `github_repository_file` resources in `repositories.tf`. Each template repository gets the appropriate configuration based on its technology stack.