# CODEOWNERS file for template repository protection
# This file defines who can approve changes to specific paths in the repository

# Global ownership - platform team has admin access
* ${platform_team}

# Template-specific files require approval from template approvers
skeleton/ ${template_approvers}
template.yaml ${template_approvers}
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