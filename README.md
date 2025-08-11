# 🏢 GHEC Organization as Code

This repository manages GitHub Enterprise Cloud (GHEC) teams and Backstage template repositories through Infrastructure as Code using Terraform.

## 🎯 Overview

This project automates the creation and management of:
- **Teams** with proper hierarchy and permissions
- **Template repositories** for Backstage with security and quality controls
- **Branch protection rules** and required status checks
- **Team permissions** for repository access

## 🏗️ Architecture

### Team Hierarchy
```
canary-trips (parent)
├── platform-team (maintainers of infrastructure)
├── template-approvers (review template changes)
├── security (security reviews)
└── read-only (auditing access)
```

### Template Repositories
- `backstage-template-node-service` - Node.js services
- `backstage-template-fastapi-service` - FastAPI/Python services
- `backstage-template-dotnet-service` - .NET services
- `backstage-template-gateway` - API Gateway
- `backstage-template-ai-assistant` - AI Assistant services
- `backstage-template-astro-frontend` - Astro frontend applications
- `backstage-template-helm-base` - Helm charts
- `backstage-template-env-live` - Environment configurations

## 🚀 Getting Started

### Prerequisites

1. **Terraform CLI** ≥ 1.6:
   ```bash
   wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
   unzip terraform_1.7.5_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
   terraform version
   ```

2. **GitHub App** with organization admin permissions:
   - Create a GitHub App in your organization settings
   - Generate a private key (PEM file)
   - Install the app in your organization
   - Note the App ID and Installation ID

3. **Required GitHub App Permissions**:
   - Repository permissions: Admin
   - Organization permissions: Members (read), Administration (write)
   - Account permissions: Team discussions (write)

### Configuration

1. **Copy the example variables file**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. **Edit `terraform.tfvars`** with your organization details:
   ```hcl
   github_organization = "your-github-org"
   github_app_id = "123456"
   github_app_installation_id = "123456789"
   github_app_pem_file = "path/to/your/github-app-private-key.pem"
   
   # Configure team members
   platform_team_maintainers = ["platform-lead"]
   platform_team_members = ["engineer1", "engineer2"]
   # ... other team configurations
   ```

3. **Configure backend** (recommended for production):
   
   Edit `terraform.tf` and uncomment the appropriate backend configuration:
   
   ```hcl
   # For Terraform Cloud
   cloud {
     organization = "your-org"
     workspaces {
       name = "ghec-org-as-code"
     }
   }
   
   # OR for S3 backend
   backend "s3" {
     bucket         = "your-terraform-state-bucket"
     key            = "ghec-org-as-code/terraform.tfstate"
     region         = "us-east-1"
     dynamodb_table = "terraform-locks"
     encrypt        = true
   }
   ```

### Deployment

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Format and validate**:
   ```bash
   terraform fmt
   terraform validate
   ```

3. **Plan changes**:
   ```bash
   terraform plan
   ```

4. **Apply changes**:
   ```bash
   terraform apply
   ```

## 🔧 Usage

### Adding a New Team

1. Edit `teams.tf`
2. Add the new team resource
3. Configure team memberships
4. Run `terraform plan` and `terraform apply`

### Adding a New Template Repository

1. Edit `variables.tf` to add the repository to `template_repositories`
2. Or override in `terraform.tfvars`:
   ```hcl
   template_repositories = {
     "backstage-template-custom-service" = {
       description = "Custom service template"
       topics      = ["backstage", "template", "custom"]
     }
   }
   ```

### Modifying Team Members

1. Update the relevant variables in `terraform.tfvars`
2. Run `terraform plan` to review changes
3. Run `terraform apply` to update memberships

## 🔄 CI/CD Pipeline

The repository includes a GitHub Actions workflow that:

- **On Pull Request**: Runs `terraform fmt`, `validate`, and `plan`
- **On Main Branch**: Runs `terraform apply` in production environment
- **Security Scanning**: Runs `tfsec` for security analysis

### Required Secrets

Configure these secrets in your repository settings:

- `GITHUB_APP_ID` - Your GitHub App ID
- `GITHUB_APP_INSTALLATION_ID` - Installation ID for your organization
- `GITHUB_APP_PEM_FILE` - Private key content (PEM format)
- `GITHUB_ORGANIZATION` - Your GitHub organization name

## 🛡️ Security Features

### Repository Security
- Private repositories by default
- Secret scanning enabled
- Advanced security features
- Vulnerability alerts

### Branch Protection
- Required pull request reviews (≥1)
- Required status checks: `ci-template`, `lint`, `docs-build`, `codeql`
- Dismiss stale reviews
- Restrict force pushes
- CODEOWNERS enforcement

### Team Permissions
- **platform-team**: Admin access to all repositories
- **template-approvers**: Maintain access for template reviews
- **security**: Pull access for security reviews
- **read-only**: Pull access for auditing

## 🔍 Monitoring and Maintenance

### Drift Detection
Run `terraform plan` regularly to detect manual changes:
```bash
terraform plan -detailed-exitcode
```

### State Management
- Use remote state backend for production
- Enable state locking
- Regular state backups

### Dependency Updates
- Dependabot automatically updates Terraform providers
- GitHub Actions versions are updated weekly
- Review and approve dependency updates

## 🆘 Troubleshooting

### Common Issues

1. **Authentication Error**:
   - Verify GitHub App permissions
   - Check PEM file path and format
   - Ensure App is installed in organization

2. **State Lock**:
   ```bash
   terraform force-unlock <lock-id>
   ```

3. **Resource Already Exists**:
   ```bash
   terraform import github_team.example team-name
   ```

### Debug Mode
```bash
TF_LOG=DEBUG terraform plan
```

## 📚 Resources

- [Terraform GitHub Provider Documentation](https://registry.terraform.io/providers/integrations/github/latest/docs)
- [GitHub App Authentication](https://registry.terraform.io/providers/integrations/github/latest/docs#github-app-installation)
- [Terraform Best Practices](https://developer.hashicorp.com/terraform/plugin/best-practices)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run `terraform fmt` and `terraform validate`
5. Test your changes
6. Submit a pull request

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Projects

- [Backstage](https://backstage.io/) - Developer portal platform
- [Terraform](https://terraform.io/) - Infrastructure as Code
- [GitHub Enterprise Cloud](https://github.com/enterprise) - Enterprise GitHub platform