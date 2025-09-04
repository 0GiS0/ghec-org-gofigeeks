apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: ${{values.name}}
  description: ${{values.description}}
  annotations:
    github.com/project-slug: ${{values.owner}}/${{values.name}}
    backstage.io/techdocs-ref: dir:.
  tags:
    - astro
    - typescript
    - frontend
    - static-site
    - web
spec:
  type: website
  lifecycle: production
  owner: ${{values.teamOwner}}
  system: ${{values.system}}
  consumesApis:
    - backend-api
  dependsOn:
    - resource:cdn
---
apiVersion: backstage.io/v1alpha1
kind: API
metadata:
  name: frontend-api
  description: Frontend API interface definitions
  annotations:
    github.com/project-slug: ${{values.owner}}/${{values.name}}
spec:
  type: openapi
  lifecycle: production
  owner: ${{values.teamOwner}}
  system: ${{values.system}}
  definition: |
    openapi: 3.0.0
    info:
      title: Frontend API Interface
      version: 1.0.0
      description: API interface definitions used by the frontend
    paths:
      /api/data:
        get:
          summary: Get application data
          responses:
            '200':
              description: Application data
      /api/config:
        get:
          summary: Get application configuration
          responses:
            '200':
              description: Configuration data
