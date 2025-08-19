# CODEOWNERS file for project protection
# This file defines who can approve changes to specific paths in the repository

# Global ownership - developers team can approve general changes
* @$${{ values.destination.owner }}/${developers_team}

# Documentation requires approval from developers team
docs/ @$${{ values.destination.owner }}/${developers_team}
*.md @$${{ values.destination.owner }}/${developers_team}

# GitHub configuration requires admin approval (platform team)
.github/ @$${{ values.destination.owner }}/${platform_team}

# Security-sensitive files require approval from developers team
Dockerfile @$${{ values.destination.owner }}/${developers_team}
docker-compose.yml @$${{ values.destination.owner }}/${developers_team}

# Backstage catalog file requires approval from developers team
catalog-info.yaml @$${{ values.destination.owner }}/${developers_team}