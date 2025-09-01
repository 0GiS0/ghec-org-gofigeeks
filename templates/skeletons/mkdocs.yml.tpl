---
site_name: $${parameters.name}
site_description: $${parameters.description}
site_url: $${parameters.repoUrl}

repo_name: $${parameters.destination.owner}/$${parameters.name}
repo_url: $${parameters.repoUrl}

theme:
  name: material
  palette:
    # Palette toggle for automatic mode
    - media: "(prefers-color-scheme)"
      toggle:
        icon: material/brightness-auto
        name: Switch to light mode

    # Palette toggle for light mode
    - media: "(prefers-color-scheme: light)"
      scheme: default
      primary: blue
      accent: blue
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode

    # Palette toggle for dark mode
    - media: "(prefers-color-scheme: dark)"
      scheme: slate
      primary: blue
      accent: blue
      toggle:
        icon: material/brightness-4
        name: Switch to system preference

  features:
    - navigation.tabs
    - navigation.sections
    - navigation.expand
    - navigation.path
    - navigation.top
    - search.highlight
    - search.share
    - toc.follow

markdown_extensions:
  - admonition
  - pymdownx.details
  - pymdownx.superfences
  - pymdownx.highlight:
      anchor_linenums: true
  - pymdownx.inlinehilite
  - pymdownx.snippets
  - pymdownx.tabbed:
      alternate_style: true
  - attr_list
  - md_in_html
  - tables
  - footnotes
  - pymdownx.critic
  - pymdownx.caret
  - pymdownx.keys
  - pymdownx.mark
  - pymdownx.tilde

nav:
  - Home: index.md
  - Getting Started: getting-started.md
  - Development: development.md
  - Architecture: architecture.md
  - API Reference: api-reference.md
  - Deployment: deployment.md
  - Contributing: contributing.md

plugins:
  - search
  - techdocs-core
