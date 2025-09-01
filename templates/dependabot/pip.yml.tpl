---
version: 2

updates:
  # Python/pip dependencies
  - package-ecosystem: "pip"
    directory: "/skeleton"
    schedule:
      interval: "weekly"
      day: "monday"
      time: "09:00"
    open-pull-requests-limit: 5
    reviewers:
      - "${template_approvers}"
    assignees:
      - "${template_approvers}"
    commit-message:
      prefix: "pip"
      include: "scope"
    labels:
      - "dependencies"
      - "pip"
      - "python"
      - "template"

  # GitHub Actions dependencies
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
      time: "09:00"
    open-pull-requests-limit: 3
    reviewers:
      - "${template_approvers}"
    assignees:
      - "${template_approvers}"
    commit-message:
      prefix: "github-actions"
      include: "scope"
    labels:
      - "dependencies"
      - "github-actions"
      - "template"
