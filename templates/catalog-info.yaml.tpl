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
%{ if length(template_tags) > 0 ~}
%{ for tag in template_tags ~}
    - ${tag}
%{ endfor ~}
%{ else ~}
    []
%{ endif ~}
spec:
  owner: platform-team
  type: ${template_type}
  # these are the steps which are rendered in the frontend with the form input
  # https://backstage.io/docs/features/software-templates/input-examples
  parameters:
%{ if template_type != "system" && template_type != "domain" ~}
    - title: Complete the form to create a new ${template_title}
      required:
        - name
        - description
        - system
        - serviceTier
        - teamOwner
      properties:
        name:
          type: string
          title: Project Name
          description: The name of the project
          ui:autofocus: true
          ui:field: ValidateKebabCase  # Custom field extension
        description:
          title: Description
          type: string
          description: A description for the component
          minLength: 1
          maxLength: 340
          pattern: "^.*\\S.*$"
          ui:help: "Required field. Max 340 characters (GitHub has a 350-byte limit, accented characters count as multiple bytes). Excess whitespace will be normalized automatically."
          ui:options:
            inputProps:
              maxLength: 340
              placeholder: "Enter a clear, concise description of this component..."
          ui:widget: textarea
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
        serviceTier:
          title: Service Tier
          type: string
          description: Service tier classification for operational support
          default: tier-3
          enum:
            - tier-1
            - tier-2
            - tier-3
            - experimental
          enumNames:
            - "Tier 1 (Critical)"
            - "Tier 2 (Important)"
            - "Tier 3 (Standard)"
            - "Experimental"
        teamOwner:
          title: Team Owner
          type: string
          description: Team responsible for maintaining this repository
          default: platform-team
          ui:field: MyGroupsPicker
        demo:
          title: Demo Repository
          type: string
          description: Mark this repository as a demonstration/test repository
          default: "yes"
          enum:
            - "yes"
            - "no"
          enumNames:
            - "Yes - This is a demo/test repository"
            - "No - This is a production repository"
%{ else ~}
    - title: Complete the form to create a new ${template_title}
      required:
        - name
        - description
%{ if template_type == "system" ~}
        - domain
%{ endif ~}
        - serviceTier
        - teamOwner
      properties:
        name:
          type: string
%{ if template_type == "system" ~}
          title: System Name
          description: The name of the system
%{ else ~}
          title: Domain Name
          description: The name of the domain
%{ endif ~}
          ui:autofocus: true
          ui:field: ValidateKebabCase # Custom field extension
        description:
          title: Description
          type: string
%{ if template_type == "system" ~}
          description: A description for the system
%{ else ~}
          description: A description for the domain
%{ endif ~}
          minLength: 1
          maxLength: 340
          pattern: "^.*\\S.*$"
          ui:help: "Required field. Max 340 characters (GitHub has a 350-byte limit, accented characters count as multiple bytes). Excess whitespace will be normalized automatically."
          ui:options:
            inputProps:
              maxLength: 340
%{ if template_type == "system" ~}
              placeholder: "Enter a clear, concise description of this system..."
%{ else ~}
              placeholder: "Enter a clear, concise description of this domain..."
%{ endif ~}
          ui:widget: textarea
        owner:
%{ if template_type == "system" ~}
          title: Select the owner group for this system
%{ else ~}
          title: Select the owner group for this domain
%{ endif ~}
          type: string
          description: The group that owns the system
          ui:field: MyGroupsPicker
%{ if template_type == "system" ~}
        domain:
          title: Domain
          type: string
          description: The domain this system belongs to
          ui:field: EntityPicker
          ui:options:
            catalogFilter:
              kind: Domain
%{ endif ~}
        serviceTier:
          title: Service Tier
          type: string
          description: Service tier classification for operational support
%{ if template_type == "system" ~}
          default: tier-2
%{ else ~}
          default: tier-2
%{ endif ~}
          enum:
            - tier-1
            - tier-2
            - tier-3
            - experimental
          enumNames:
            - "Tier 1 (Critical)"
            - "Tier 2 (Important)"
            - "Tier 3 (Standard)"
            - "Experimental"
        teamOwner:
          title: Team Owner
          type: string
          description: Team responsible for maintaining this repository
          default: platform-team
          ui:field: MyGroupsPicker
        demo:
          title: Demo Repository
          type: string
          description: Mark this repository as a demonstration/test repository
          default: "yes"
          enum:
            - "yes"
            - "no"
          enumNames:
            - "Yes - This is a demo/test repository"
            - "No - This is a production repository"
%{ endif ~}
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
  # You can see all actions you have registered here:
  # http://localhost:3000/create/actions
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
          serviceTier: $${{ parameters.serviceTier }}
          teamOwner: $${{ parameters.teamOwner }}
%{ if template_type != "system" && template_type != "domain" ~}
          system: $${{ parameters.system }}
%{ endif ~}
%{ if template_type == "system" ~}
          domain: $${{ parameters.domain }}
%{ endif ~}
    
    - id: publish
      name: Publish to GitHub
      action: publish:github
      input:
        repoUrl: $${{ parameters.repoUrl }}
        description: $${{ parameters.description }}
        topics: ["backstage-include", "${organization}"]
        defaultBranch: main
        gitCommitMessage: Create scaffold from template       
        customProperties:
           service-tier: $${{ parameters.serviceTier }}
           team-owner: $${{ parameters.teamOwner }}
           demo: $${{ parameters.demo }}

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

