{
  "name": "$${parameters.name}-devcontainer",
  "image": "mcr.microsoft.com/devcontainers/javascript-node:18",
  "features": {
    "ghcr.io/devcontainers/features/github-cli:1": {}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-vscode.vscode-json",
        "esbenp.prettier-vscode",
        "dbaeumer.vscode-eslint",
        "ms-vscode.vscode-typescript-next",
        "bradlc.vscode-tailwindcss",
        "github.copilot",
        "github.copilot-chat"
      ],
      "settings": {
        "editor.formatOnSave": true,
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.codeActionsOnSave": {
          "source.fixAll.eslint": true
        }
      }
    }
  },
  "postCreateCommand": "npm install",
  "remoteUser": "node",
  "forwardPorts": [3000],
  "portsAttributes": {
    "3000": {
      "label": "$${parameters.name} API",
      "onAutoForward": "notify"
    }
  }
}