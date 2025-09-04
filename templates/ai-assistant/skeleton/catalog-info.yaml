apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: ${{values.name}}
  description: ${{values.description}}
  annotations:
    github.com/project-slug: ${{values.owner}}/${{values.name}}
    backstage.io/techdocs-ref: dir:.
  tags:
    - python
    - ai
    - assistant
    - fastapi
    - microservice
spec:
  type: service
  lifecycle: production
  owner: ${{values.teamOwner}}
  system: ${{values.system}}
  providesApis:
    - ai-assistant-api
  dependsOn:
    - resource:llm-service
---
apiVersion: backstage.io/v1alpha1
kind: API
metadata:
  name: ai-assistant-api
  description: API for AI Assistant interactions
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
      title: AI Assistant API
      version: 1.0.0
      description: API for AI-powered assistant interactions
    paths:
      /api/chat:
        post:
          summary: Send message to AI assistant
          responses:
            '200':
              description: AI response
      /api/health:
        get:
          summary: Health check endpoint
          responses:
            '200':
              description: Service is healthy
