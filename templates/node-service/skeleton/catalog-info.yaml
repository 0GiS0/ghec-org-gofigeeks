apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: ${{values.name}}
  description: ${{values.description}}
  annotations:
    github.com/project-slug: ${{values.owner}}/${{values.name}}
    backstage.io/techdocs-ref: dir:.
  tags:
    - nodejs
    - typescript
    - express
    - microservice
spec:
  type: service
  lifecycle: production
  owner: ${{values.teamOwner}}
  system: ${{values.system}}
  providesApis:
    - excursions-api
  dependsOn:
    - resource:database
---
apiVersion: backstage.io/v1alpha1
kind: API
metadata:
  name: excursions-api
  description: API for managing excursions
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
      title: Excursions API
      version: 1.0.0
      description: API for managing excursions and travel experiences
    paths:
      /api/excursions:
        get:
          summary: List all excursions
          responses:
            '200':
              description: List of excursions
      /api/health:
        get:
          summary: Health check endpoint
          responses:
            '200':
              description: Service is healthy
