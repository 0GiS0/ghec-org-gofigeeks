version: 2

updates:
  # GitHub Actions dependencies only
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