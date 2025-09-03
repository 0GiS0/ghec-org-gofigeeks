# Helm specific
charts/*.tgz
charts/*/charts/*.tgz

# Helm dependency charts
charts/*/charts/
requirements.lock

# Helm package output
*.tgz

# Helm Chart.lock file
Chart.lock

# Values files for different environments (keep templates)
values-dev.yaml
values-staging.yaml
values-prod.yaml
values-test.yaml

# Temporary Helm files
.helm/

# Generated manifests
manifests/
rendered/

# Kubernetes secrets
secrets.yaml
secret-*.yaml

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

# Temporary files
tmp/
temp/
*.tmp

# Log files
*.log
logs/

# Backup files
*.bak
backup/