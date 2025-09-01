{
  "name": "${{values.name}}-devcontainer",
  "image": "mcr.microsoft.com/devcontainers/python:3.11",
  "features": {
    "ghcr.io/devcontainers/features/github-cli:1": {}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "redhat.vscode-yaml",
        "ms-python.python",
        "github.copilot",
        "github.copilot-chat"
      ]
    }
  },
  "postCreateCommand": "pip install pyyaml jsonschema",
  "remoteUser": "vscode"
}