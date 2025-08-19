# CODEOWNERS file for project protection
# This file defines who can approve changes to specific paths in the repository

# Global ownership - project owner has admin access
* @$${{ values.destination.owner }}/$${{ values.owner }}

# Documentation requires approval from project owner
docs/ @$${{ values.destination.owner }}/$${{ values.owner }}
*.md @$${{ values.destination.owner }}/$${{ values.owner }}

# Configuration files require approval from project owner
.github/ @$${{ values.destination.owner }}/$${{ values.owner }}

# Security-sensitive files require approval from project owner
.github/workflows/ @$${{ values.destination.owner }}/$${{ values.owner }}
Dockerfile @$${{ values.destination.owner }}/$${{ values.owner }}
docker-compose.yml @$${{ values.destination.owner }}/$${{ values.owner }}

# Backstage catalog file requires approval from project owner
catalog-info.yaml @$${{ values.destination.owner }}/$${{ values.owner }}