{
  "name": "${{values.name}}-devcontainer",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": {},
    "ghcr.io/devcontainers/features/github-cli:1": {}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-vscode.vscode-json",
        "redhat.vscode-yaml",
        "ms-vscode.remote-containers",
        "github.copilot",
        "github.copilot-chat"
      ]
    }
  },
  "postCreateCommand": "docker --version && docker-compose --version",
  "remoteUser": "vscode",
  "forwardPorts": [8000, 8001],
  "portsAttributes": {
    "8000": {
      "label": "${{values.name}} Gateway",
      "onAutoForward": "notify"
    },
    "8001": {
      "label": "${{values.name}} Admin",
      "onAutoForward": "notify"
    }
  }
}