apiVersion: v2
name: $${parameters.name}
description: $${parameters.description}
type: application
version: 0.1.0
appVersion: "1.0.0"
keywords:
  - kubernetes
  - helm
home: $${parameters.repoUrl}
sources:
  - $${parameters.repoUrl}
maintainers:
  - name: $${parameters.owner}
    email: $${parameters.owner}@example.com