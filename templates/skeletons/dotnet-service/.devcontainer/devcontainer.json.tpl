{
  "name": "$${parameters.name}-devcontainer",
  "image": "mcr.microsoft.com/devcontainers/dotnet:8.0",
  "features": {
    "ghcr.io/devcontainers/features/github-cli:1": {}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-dotnettools.csharp",
        "ms-dotnettools.vscode-dotnet-runtime",
        "formulahendry.dotnet-test-explorer",
        "jchannon.csharpextensions",
        "github.copilot",
        "github.copilot-chat"
      ],
      "settings": {
        "dotnet.defaultSolution": "src/$${parameters.name}.csproj"
      }
    }
  },
  "postCreateCommand": "dotnet restore src/$${parameters.name}.csproj",
  "remoteUser": "vscode",
  "forwardPorts": [5000, 5001],
  "portsAttributes": {
    "5000": {
      "label": "$${parameters.name} API (HTTP)",
      "onAutoForward": "notify"
    },
    "5001": {
      "label": "$${parameters.name} API (HTTPS)",
      "onAutoForward": "notify"
    }
  }
}