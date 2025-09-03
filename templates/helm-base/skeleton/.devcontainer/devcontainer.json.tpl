{
  "name": "${{values.name}}-devcontainer",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/devcontainers/features/kubectl-helm-minikube:1": {
      "version": "latest",
      "helm": "latest",
      "minikube": "latest"
    },
    "ghcr.io/devcontainers/features/github-cli:1": {}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "redhat.vscode-yaml",
        "ms-kubernetes-tools.vscode-kubernetes-tools",
        "redhat.vscode-xml",
        "github.copilot",
        "github.copilot-chat"
      ],
      "settings": {
        "yaml.schemas": {
          "https://json.schemastore.org/chart.json": "Chart.yaml",
          "https://json.schemastore.org/helmfile.json": "**/helmfile.yaml"
        }
      }
    }
  },
  "postCreateCommand": "helm version && kubectl version --client",
  "remoteUser": "vscode"
}