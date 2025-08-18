---
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: ${{ values.name }}
  title: ${{ values.name | title }}
  description: ${{ values.description }}
  annotations:
    backstage.io/techdocs-ref: dir:.
    github.com/project-slug: ${{ values.destination.owner }}/${{ values.name }}
  tags:
    - ${{ values.system }}
spec:
  type: ${template_type}
  lifecycle: experimental
  owner: ${{ values.owner }}
  system: ${{ values.system }}
