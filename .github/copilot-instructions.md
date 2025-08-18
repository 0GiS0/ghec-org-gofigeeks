# GHEC Organization as Code - GitHub Copilot Instructions

This repository manages GitHub Enterprise Cloud (GHEC) teams and Backstage template repositories through Infrastructure as Code using Terraform.

**Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

## Working Effectively

### Prerequisites and Setup
- Download and install Terraform CLI ≥ 1.6:
  ```bash
  wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
  unzip terraform_1.7.5_linux_amd64.zip
  sudo mv terraform /usr/local/bin/
  terraform version
  ```
- Verify Git is available: `git --version`
- GitHub token/app credentials required for Terraform GitHub provider (organization admin permissions needed)

### Initial Repository Setup
- **CURRENT STATE**: Repository is in early development stage with only PRD.md and LICENSE
- **EXPECTED STATE**: Will contain Terraform configurations for teams and template repositories

### Core Terraform Workflow
**NEVER CANCEL** any of these operations. Always set timeouts of 60+ minutes for safety:

1. **Initialize project** (takes ~3 seconds, NEVER CANCEL - set timeout 60+ minutes):
   ```bash
   terraform init
   ```

2. **Format and validate** (takes <1 second each, NEVER CANCEL - set timeout 1 minute):
   ```bash
   terraform fmt
   terraform validate
   ```

3. **Plan changes** (takes ~1-2 seconds, NEVER CANCEL - set timeout 60+ minutes):
   ```bash
   terraform plan -out=tfplan
   ```

**NEVER CANCEL** any of these operations. Set timeouts of 5-10 minutes for safety:

1. **Initialize project** (takes ~3 seconds, NEVER CANCEL - set timeout 5 minutes):
   ```bash
   terraform init
   ```bash
   terraform apply tfplan
   ```

### Repository Structure (When Implemented)
```
.
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Input variables
├── outputs.tf             # Output values
├── terraform.tf           # Provider and backend configuration
├── teams.tf               # Team definitions
├── repositories.tf        # Template repository definitions
├── .terraform.lock.hcl    # Provider version lock file
├── terraform.tfvars.example # Example variables file
├── .github/
│   └── workflows/
│       └── terraform.yml   # CI/CD pipeline
├── PRD.md                 # Product Requirements Document
└── README.md              # Usage documentation
```

## Validation and Testing

### Manual Validation Requirements
**ALWAYS** perform these validations after making changes:

1. **Terraform validation**:
   ```bash
   terraform fmt -check
   terraform validate
   terraform plan
   ```

2. **Team verification** (when teams are created):
   - Check GHEC organization teams page
   - Verify team hierarchy (canary-trips as parent)
   - Confirm team members and maintainers
   - Validate team privacy settings (closed)

3. **Repository verification** (when template repos are created):
   - Check template repositories exist and are private
   - Verify repository topics and descriptions
   - Confirm team permissions are correctly assigned
   - Validate branch protection rules on main branch
   - Check CODEOWNERS file requirements

### Validation Scenarios
**CRITICAL**: Always test these complete scenarios after changes:

1. **Team Management Scenario**:
   - Create or modify a team configuration
   - Run terraform plan to preview changes
   - Apply changes
   - Verify team appears correctly in GHEC organization
   - Check team membership and permissions

2. **Template Repository Scenario**:
   - Add or modify a template repository configuration
   - Run terraform plan to preview changes
   - Apply changes
   - Verify repository is created with correct settings
   - Check repository permissions for teams
   - Validate branch protection rules

### Build and Deployment Pipeline
**NEVER CANCEL**: CI/CD operations may take 15+ minutes. Set timeout to 30+ minutes minimum.

The GitHub Actions workflow (when implemented) will:
- **On Pull Request**: Run `terraform fmt`, `validate`, and `plan` (takes ~2-5 minutes)
- **On Merge to Main**: Run `terraform apply` in protected environment (takes ~5-15 minutes)

Always run these locally before pushing:
```bash
terraform fmt
terraform validate
terraform plan
```

## Common Tasks and Reference

### Adding a New Team
1. Edit `teams.tf` (when file exists)
2. Add team resource following existing patterns
3. Run `terraform plan` to preview
4. **VALIDATION**: Verify plan output shows only intended changes
5. Create PR for review
6. After merge, verify team in GHEC organization

### Adding a New Template Repository
1. Edit `repositories.tf` (when file exists)
2. Add repository resource with required configuration
3. Include team permissions assignment
4. Run `terraform plan` to preview
5. **VALIDATION**: Verify plan shows correct repository settings
6. Create PR for review
7. After merge, verify repository in GHEC organization

### Team Hierarchy (Target State)
```
canary-trips (parent)
├── platform-team (maintainers of infrastructure)
├── template-approvers (review template changes)
├── security (security reviews)
└── read-only (auditing access)
```

### Template Repositories (Target State)
- `backstage-template-node-service`
- `backstage-template-fastapi-service`
- `backstage-template-dotnet-service`
- `backstage-template-gateway`
- `backstage-template-ai-assistant`
- `backstage-template-astro-frontend`
- `backstage-template-helm-base`
- `backstage-template-env-live`

### Required Repository Settings
- **Visibility**: Private
- **Auto-init**: true
- **Branch Protection**: main branch with ≥1 review required
- **Required Checks**: ci-template, lint, docs-build, codeql
- **CODEOWNERS**: Required for skeleton/ and template.yaml
- **Force Push**: Blocked

## Troubleshooting

### Common Issues
1. **Authentication Error**: Ensure GitHub token has organization admin permissions
2. **State Lock**: Use `terraform force-unlock` if state is stuck
3. **Provider Version**: Ensure GitHub provider ≥ 6.0 is used
4. **Drift Detection**: Run `terraform plan` regularly to detect manual changes

### State Management
- **Backend**: Remote state required (Terraform Cloud or S3+DynamoDB)
- **State File**: Never edit manually
- **State Lock**: Automatic during operations

### Emergency Procedures
- **Rollback**: Use `terraform apply` with previous state
- **Manual Override**: Only for critical production issues
- **State Recovery**: Contact platform team for assistance

## Development Workflow

### PR Process
1. Create feature branch
2. Make Terraform changes
3. Run local validation:
   ```bash
   terraform fmt
   terraform validate
   terraform plan
   ```
4. Commit changes
5. Create PR
6. Wait for CI validation (terraform plan)
7. Get review from platform-team
8. Merge to main
9. Automatic terraform apply in production

### Code Standards
- Use consistent resource naming
- Include descriptions for all resources
- Follow HCL formatting standards
- Document complex configurations
- Use variables for reusable values

## Security and Compliance

### Access Control
- **Platform Team**: Full administrative access
- **Template Approvers**: Review template repository changes
- **Security Team**: Security reviews and compliance
- **Read-only**: Audit and monitoring access

### Compliance Requirements
- All changes via Pull Request
- Required reviews for sensitive changes
- Audit trail through git history
- State file encryption in backend

---

**CRITICAL REMINDERS**:
- **NEVER CANCEL** Terraform operations - always wait for completion
- **Set timeouts of 60+ minutes** for init/plan/apply operations
- **Validate manually** after every change by checking GHEC organization
- **Always run local validation** before creating PRs
- **Test complete scenarios** not just individual commands

## GitHub Well-Architected Framework 🔧

All changes must align with the best practices in the GitHub Well-Architected Framework. Official reference: https://wellarchitected.github.com

Pillars and expectations applicable to this organization and the Terraform-managed templates:

- Identity and Access
   - Enforce SSO/SAML (if applicable) and mandatory 2FA for members and outside collaborators
   - Default repository visibility: Private; restrict repository creation to authorized teams/roles
   - Use teams for permissions (least privilege); avoid direct collaborators where possible
- Repositories and Branch Protection
   - Protect the main branch: required PRs, ≥1 review, required checks (ci-template, lint, docs-build, codeql)
   - Block force-push and deletion of protected branches; optional: linear history and commit message guidelines
   - CODEOWNERS required for skeleton/ and template.yaml
- Secure SDLC
   - Enable Dependabot alerts and updates; Secret Scanning and Push Protection enabled
   - Code Scanning with CodeQL by default in templates
   - Require signed/verified commits when possible
- GitHub Actions and Automation
   - Restrict Actions to verified marketplace or pinned SHAs; policy for reusable workflows
   - Runners: group by trust level; use OIDC for cloud secrets (avoid static credentials)
   - Define artifact and retention policies
- Governance and Compliance
   - Audit log streaming (to SIEM/storage) at Enterprise/Org level
   - Enterprise/Org policies to standardize defaults (visibility, forking, actions, members can create repos)
   - Required PRs/reviews for sensitive changes; traceability via git and IaC
- Operations and Reliability
   - Remote state backend with locking; provider versions pinned (>.terraform.lock.hcl)
   - Periodic drift detection (terraform plan); documented rollback processes

Operational checklist (validate on every change/PR):

1) Organization
    - [ ] Default repo visibility: Private
    - [ ] 2FA and (if applicable) SSO/SAML enforced
    - [ ] Audit log streaming configured
    - [ ] Actions and repository policies (creation/restrictions) defined
2) Teams and Permissions
    - [ ] Team structure matches target hierarchy; team-based permissions, not direct users
    - [ ] Least privilege applied
3) Templates and Repos
    - [ ] Branch protection on main with required checks: ci-template, lint, docs-build, codeql
    - [ ] CODEOWNERS present and validated for skeleton/ and template.yaml
    - [ ] Secret scanning, push protection, Dependabot and CodeQL enabled
    - [ ] Force-push blocked
4) Actions
    - [ ] Use verified/pinned actions; runners and secrets managed securely (OIDC)
5) IaC/Terraform
    - [ ] Remote state and locking enabled; providers versioned and pinned
    - [ ] terraform fmt/validate/plan executed; drift reviewed
6) Compliance
    - [ ] PRs and reviews required; audit and retention per policy

Note: When a recommendation doesn’t apply (due to policy or licensing), document the exception in the PR and apply the closest compensating control.