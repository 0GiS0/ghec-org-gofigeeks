---
version: 2

updates:
  # Node.js/npm dependencies
  - package-ecosystem: "npm"
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
      prefix: "npm"
      include: "scope"
    labels:
      - "dependencies"
      - "npm"
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
