# Reusable Workflows

This repository contains centralized GitHub Actions workflows that can be reused across multiple repositories in the ${organization} organization.

## Available Workflows

### CI Template Workflow

**Location**: `.github/workflows/ci-template.yml`

**Purpose**: Validates Backstage template repositories by checking:
- `template.yaml` file exists and is valid YAML
- `skeleton/` directory exists and contains files
- `catalog-info.yaml` file exists and is valid YAML (recommended)
- YAML files pass linting with yamllint
- Documentation files exist

**Usage**: 

```yaml
name: Template CI/CD

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

permissions:
  contents: read
  pull-requests: read

jobs:
  call-reusable-workflow:
    uses: ${organization}/reusable-workflows/.github/workflows/ci-template.yml@main
```

## Repository Purpose

This repository centralizes workflow maintenance, making it easier to:
- Update workflows in one place
- Ensure consistency across all template repositories
- Reduce duplication and maintenance overhead
- Improve security by managing workflows centrally

## Permissions

- **Platform Team**: Full administrative access
- **Template Approvers**: Maintain access for workflow updates
- **Security Team**: Pull access for security reviews
- **Read-only Team**: Pull access for auditing

## Branch Protection

The `main` branch is protected with:
- Required pull request reviews
- Required status checks
- Restrictions on force pushes
- CODEOWNERS enforcement

## Contributing

1. Create a feature branch
2. Make your workflow changes
3. Test the workflow in a template repository
4. Create a pull request
5. Get approval from platform team or template approvers
6. Merge to main

## Security Considerations

- All workflows follow principle of least privilege
- Sensitive operations require explicit permissions
- Workflows are regularly reviewed for security issues
- Dependencies are kept up to date via Dependabot