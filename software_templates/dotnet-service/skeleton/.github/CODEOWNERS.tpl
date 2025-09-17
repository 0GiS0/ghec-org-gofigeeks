# CODEOWNERS for generated service repository
# This file is templated during Backstage scaffolding.
# Ownership model:
# - Platform team: elevated / protected areas
# - Template approvers: template structural files
# - (Optional) Developers team can be added via Backstage parameters extension later

# Global ownership (allow platform team as fallback)
* $${{ values.destination.owner }}/${platform_team}

# Template / scaffolding structural files
skeleton/ $${{ values.destination.owner }}/${template_approvers}
template.yaml $${{ values.destination.owner }}/${template_approvers}

# Backstage catalog metadata
catalog-info.yaml $${{ values.destination.owner }}/${template_approvers}

# Documentation
/docs/ $${{ values.destination.owner }}/${template_approvers}
*.md  $${{ values.destination.owner }}/${template_approvers}

# GitHub configuration
.github/ $${{ values.destination.owner }}/${platform_team}
.github/workflows/ $${{ values.destination.owner }}/${platform_team}

# Security-sensitive / deployment related
Dockerfile $${{ values.destination.owner }}/${platform_team}
docker-compose.yml $${{ values.destination.owner }}/${platform_team}
