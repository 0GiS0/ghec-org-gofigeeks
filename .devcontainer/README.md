# Dev Container Configuration

This directory contains the configuration for a Visual Studio Code Dev Container that provides a pre-configured development environment for this Terraform project.

## What's Included

The Dev Container includes:

- **Terraform CLI v1.7.5** - The exact version specified in the project requirements
- **GitHub CLI** - For interacting with GitHub repositories and authentication
- **Git** - Version control system
- **VS Code Extensions**:
  - HashiCorp Terraform - Syntax highlighting, formatting, and validation
  - JSON and YAML support
  - GitHub Pull Request and Issues extension

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## How to Use

1. **Clone the repository** (if you haven't already):
   ```bash
   git clone https://github.com/0GiS0/ghec-org-as-code.git
   cd ghec-org-as-code
   ```

2. **Open in VS Code**:
   ```bash
   code .
   ```

3. **Reopen in Container**:
   - VS Code should automatically detect the Dev Container configuration
   - Click "Reopen in Container" when prompted, or
   - Use the Command Palette (Ctrl/Cmd+Shift+P) and select "Dev Containers: Reopen in Container"

4. **Wait for the container to build** - This may take a few minutes the first time

5. **Verify the setup** - The container will automatically run:
   ```bash
   terraform version && git --version && gh --version
   ```

## Environment Configuration

The Dev Container automatically sets:
- `TF_IN_AUTOMATION=1` - Indicates Terraform is running in an automated environment
- SSH key mounting from your local `~/.ssh` directory for Git authentication

## Authentication

You'll need to authenticate with GitHub for Terraform operations:

```bash
# Authenticate with GitHub CLI
gh auth login

# Or set up a GitHub token
export GITHUB_TOKEN="your_github_token_here"
```

## Working with Terraform

Once inside the Dev Container, you can use all standard Terraform commands:

```bash
# Initialize the project
terraform init

# Format code
terraform fmt

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes (with approval)
terraform apply
```

## Benefits

- **No local installation required** - Everything is containerized
- **Consistent environment** - Same tools and versions across all developers
- **Pre-configured extensions** - VS Code extensions for optimal Terraform development
- **Isolated environment** - No conflicts with other local tools or versions