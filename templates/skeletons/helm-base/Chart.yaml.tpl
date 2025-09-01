---
apiVersion: v2
name: ${{values.name}}
description: ${{values.description}}
type: application
version: 0.1.0
appVersion: "1.0.0"
keywords:
  - kubernetes
  - helm
home: ${{values.repoUrl}}
sources:
  - ${{values.repoUrl}}
maintainers:
  - name: ${{values.owner}}
    email: ${{values.owner}}@example.com
