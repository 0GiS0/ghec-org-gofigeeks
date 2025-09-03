# Environment-specific configuration files
environments/*/secrets.yaml
environments/*/local.yaml
environments/*/override.yaml

# Generated configuration files
generated/
output/
rendered/

# Temporary files
tmp/
temp/
*.tmp

# Python cache (for validation scripts)
__pycache__/
*.py[cod]
*$py.class
.pytest_cache/

# Environment validation artifacts
validation_reports/
test_results/

# Terraform state files (if using Terraform for env provisioning)
*.tfstate
*.tfstate.*
.terraform/
terraform.tfvars

# Ansible artifacts (if using Ansible for configuration)
*.retry
.vault_pass

# IDE and editor files
.vscode/
.idea/
*.swp
*.swo
*~

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Log files
*.log
logs/

# Backup files
*.bak
backup/

# Archive files
*.zip
*.tar.gz
*.tar.bz2

# dotenv environment variable files
.env
.env.local
.env.development
.env.staging
.env.production