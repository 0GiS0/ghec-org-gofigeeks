# CODEOWNERS file for Backstage IDP repository protection
# This file defines who can approve changes to specific paths in the repository

# Global ownership - platform team has admin access
* ${platform_team}

# Backstage configuration files require approval from template approvers
app-config.yaml ${template_approvers}
app-config.*.yaml ${template_approvers}
catalog-info.yaml ${template_approvers}

# Documentation requires approval from template approvers
docs/ ${template_approvers}
*.md ${template_approvers}

# GitHub configuration files require platform team approval
.github/ ${platform_team}

# Security-sensitive files require platform team approval
.github/workflows/ ${platform_team}
Dockerfile ${platform_team}
docker-compose.yml ${platform_team}

# Package files and dependencies require platform team approval
package.json ${platform_team}
package-lock.json ${platform_team}
yarn.lock ${platform_team}

# Backstage plugins and packages require template approvers approval
packages/ ${template_approvers}
plugins/ ${template_approvers}