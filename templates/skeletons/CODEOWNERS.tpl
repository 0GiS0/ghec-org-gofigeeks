# CODEOWNERS file for project protection
# This file defines who can approve changes to specific paths in the repository

# Global ownership - developers team can approve general changes
* @$${{ values.destination.owner }}/cosmic-devs

# Documentation requires approval from developers team
docs/ @$${{ values.destination.owner }}/cosmic-devs
*.md @$${{ values.destination.owner }}/cosmic-devs

# GitHub configuration requires admin approval (platform team)
.github/ @$${{ values.destination.owner }}/platform-team

# Security-sensitive files require approval from developers team
Dockerfile @$${{ values.destination.owner }}/cosmic-devs
docker-compose.yml @$${{ values.destination.owner }}/cosmic-devs

# Backstage catalog file requires approval from developers team
catalog-info.yaml @$${{ values.destination.owner }}/cosmic-devs