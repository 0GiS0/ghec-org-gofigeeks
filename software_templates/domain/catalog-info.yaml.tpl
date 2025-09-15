---
apiVersion: scaffolder.backstage.io/v1beta3
kind: Template
metadata:
  name: domain
  title: 🏗️ Domain Entity
  description: Create a new Domain entity for grouping related systems and components
  annotations:
    backstage.io/techdocs-ref: dir:.
  tags:
    - domain
    - catalog
    - organization
    - architecture
    - recommended
spec:
  owner: platform-team
  type: domain
  parameters:
    - title: 🏗️ Complete the form to create a new Domain
      required:
        - name
        - description
        - owner
      properties:
        name:
          type: string
          title: 🏗️ Domain Name
          description: The name of the domain (will be used as entity name)
          ui:autofocus: true
          ui:field: ValidateKebabCase
        description:
          title: 📝 Description
          type: string
          description: A description for the domain
          minLength: 1
          maxLength: 340
          pattern: "^.*\\S.*$"
          ui:help: "Required field. Max 340 characters. Describe the business area or functional scope of this domain."
          ui:options:
            inputProps:
              maxLength: 340
              placeholder: "Enter a clear, concise description of this domain..."
          ui:widget: textarea
        owner:
          title: 👥 Select the team that owns this domain
          type: string
          description: The team that owns and maintains this domain
          ui:field: MyGroupsPicker
    - title: 🎯 Choose a destination
      required:
        - repoUrl
      properties:
        repoUrl:
          title: 🔗 Repository URL
          type: string
          description: The URL of the repository
          ui:field: RepoUrlPicker
          ui:options:
            allowedOwners:
              - ${github_organization}
            allowedHosts:
              - github.com
  steps:
    - id: fetch-base
      name: 📥 Fetch Template
      action: fetch:template
      input:
        url: ./skeleton
        values:
          name: $${{ parameters.name }}
          owner: $${{ parameters.owner }}
          description: $${{ parameters.description }}
          destination: $${{ parameters.repoUrl | parseRepoUrl }}
          repoUrl: $${{ parameters.repoUrl }}

    - id: publish
      name: 🚀 Publish to GitHub
      action: publish:github
      input:
        repoUrl: $${{ parameters.repoUrl }}
        description: $${{ parameters.description }}
        topics:
          ["backstage-include", "${github_organization}", "domain", "catalog"]
        defaultBranch: main
        gitCommitMessage: Create Domain entity from template
        customProperties:
          service-tier: "tier-2"
          team-owner: $${{ parameters.owner }}
          demo: "no"

    - id: register
      name: 📋 Register
      action: catalog:register
      input:
        repoContentsUrl: $${{ steps["publish"].output.repoContentsUrl }}
        catalogInfoPath: "/catalog-info.yaml"

  output:
    links:
      - title: Repository
        url: $${{ steps["publish"].output.remoteUrl }}
      - title: Open in catalog
        icon: catalog
        entityRef: $${{ steps["register"].output.entityRef }}
