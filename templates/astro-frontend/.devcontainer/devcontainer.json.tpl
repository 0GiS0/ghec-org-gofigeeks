{
  "name": "${{values.name}}-devcontainer",
  "image": "mcr.microsoft.com/devcontainers/javascript-node:18",
  "features": {
    "ghcr.io/devcontainers/features/github-cli:1": {}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "astro-build.astro-vscode",
        "ms-vscode.vscode-typescript-next",
        "esbenp.prettier-vscode",
        "bradlc.vscode-tailwindcss",
        "github.copilot",
        "github.copilot-chat",
        "humao.rest-client"
      ],
      "settings": {
        "editor.formatOnSave": true,
        "editor.defaultFormatter": "esbenp.prettier-vscode"
      }
    }
  },
  "postCreateCommand": "npm install",
  "remoteUser": "node",
  "forwardPorts": [4321],
  "portsAttributes": {
    "4321": {
      "label": "${{values.name}} Frontend",
      "onAutoForward": "notify"
    }
  }
}