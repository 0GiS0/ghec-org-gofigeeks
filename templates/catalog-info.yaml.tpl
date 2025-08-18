---
apiVersion: scaffolder.backstage.io/v1beta3
kind: Template
# some metadata about the template itself
metadata:
  name: ${template_name}
  title: ${template_title}
  description: ${template_description}
  annotations:
    backstage.io/techdocs-ref: dir:.
  tags:
%{ for tag in template_tags ~}
    - ${tag}
%{ endfor ~}
spec:
  owner: platform-team
  type: ${template_type}
  # these are the steps which are rendered in the frontend with the form input
  # https://backstage.io/docs/features/software-templates/input-examples
  parameters:
    - title: Complete the form to create a new ${template_title}
      required:
        - name
        - description
        - system
      properties:
        name:
          type: string
          title: Project Name
          description: The name of the project
          ui:autofocus: true
          ui:field: ValidateKebabCase # Custom field extension
        description:
          title: Description
          type: string
          description: A description for the component
        owner:
          title: Select in which group the component will be created
          type: string
          description: The group the component belongs to
          ui:field: MyGroupsPicker
        system:
          title: System
          type: string
          description: The system the component belongs to
          ui:field: EntityPicker
          ui:options:
            catalogFilter:
              kind: System
    - title: Choose a destination
      required:
        - repoUrl
      properties:
        repoUrl:
          title: Repository URL
          type: string
          description: The URL of the repository
          ui:field: RepoUrlPicker
          ui:options:
            allowedOwners:
              - ${organization}
            allowedHosts:
              - github.com
  # here's the steps that are executed in series in the scaffolder backend
  # You can see all actions you have registered here: http://localhost:3000/create/actions
  steps:
    - id: fetch-base
      name: Fetch Template
      action: fetch:template
      input:
        url: ./skeleton
        copyWithoutTemplating:
          - .github/workflows/*
        values:
          name: $${{ parameters.name }}
          owner: $${{ parameters.owner }}
          description: $${{ parameters.description }}
          destination: $${{ parameters.repoUrl | parseRepoUrl }}
          repoUrl: $${{ parameters.repoUrl }}
          system: $${{ parameters.system }}
    - id: publish
      name: Publish
      action: publish:github
      input:
        allowedHosts: ["github.com"]
        description: This is $${{ parameters.name }}
        repoUrl: $${{ parameters.repoUrl }}
        gitCommitMessage: Create scaffold from template
        topics: ["backstage-include", "${organization}"]
        defaultBranch: main
    - id: register
      name: Register
      action: catalog:register
      input:
        repoContentsUrl: $${{ steps['publish'].output.repoContentsUrl }}
        catalogInfoPath: "/catalog-info.yaml"

  # some outputs which are saved along with the job for use in the frontend
  output:
    links:
      - title: Repository
        url: $${{ steps['publish'].output.remoteUrl }}
      - title: Open in catalog
        icon: catalog
        entityRef: $${{ steps['register'].output.entityRef }}
