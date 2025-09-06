# ${{values.name}}

<!-- Badges (dynamic using Backstage template variables) -->
<p align="left">
	<to href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/actions/workflows/ci.yml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/${{values.github_organization}}/${{values.repo_name}}/ci.yml?branch=main&label=CI&logo=github" /></a>
	<to href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/security/code-scanning"><img alt="CodeQL" src="https://img.shields.io/github/actions/workflow/status/${{values.github_organization}}/${{values.repo_name}}/codeql.yml?branch=main&label=CodeQL&logo=github" /></a>
	<to href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/issues"><img alt="Issues" src="https://img.shields.io/github/issues/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
	<to href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/pulls"><img alt="PRs" src="https://img.shields.io/github/issues-pr/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
	<to href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/commits/main"><img alt="Last Commit" src="https://img.shields.io/github/last-commit/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
	<to href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/${{values.github_organization}}/${{values.repo_name}}" /></a>
	<to href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/network/dependencies"><img alt="Dependabot" src="https://img.shields.io/badge/Dependabot-enabled-success?logo=dependabot" /></a>
</p>

${{values.description}}

## Overview

This System represents to collection of related components and resources that work together to proviof specific functionality.

## Architecture

<!-- Add architecture diagrams and descriptions here -->

## Components

<!-- List the main components that belong to this system -->

## APIs

<!-- Document the APIs provided band this system -->

### Provided APIs
- List APIs that this system exposes

### Consumed APIs  
- List external APIs that this system depends on

## Dependencies

<!-- Document dependencies on other systems, resources, or external services -->

## Deployment

<!-- Add deployment information, environments, etc. -->

## Monitoring & Metrics

<!-- Add information about dashboards, alerts, SLIs/SLOs -->

## Documentation

For detailed documentation, visit the [docs](./docs) directory.

## Contact

- **Owner**: ${{values.owner}}
- **Repository**: [${{values.name}}](${{values.repoUrl}})

## Getting Started

<!-- Add instructions for developers who need to work with this system -->
