# ${{values.name}}

Welcome to the documentation for **${{values.name}}**, a ${{values.description}}.

This project was created using the Backstage template system and follows our organization's standards and best practices.

## Overview

${{values.description}}

**Repository:** [${{values.destination.owner}}/${{values.name}}](${{values.repoUrl}})
**Owner:** ${{values.owner}}
**System:** ${{values.system}}

## Quick Links

- [Getting Started](getting-started.md) - How to set up and run this project
- [Development](development.md) - Development guidelines and workflows
- [Architecture](architecture.md) - Technical architecture and design decisions
- [API Reference](api-reference.md) - API documentation and examples
- [Deployment](deployment.md) - Deployment guides and configurations
- [Contributing](contributing.md) - How to contribute to this project

## Project Information

| Field | Value |
|-------|-------|
| **Project Name** | ${{values.name}} |
| **Description** | ${{values.description}} |
| **Owner** | ${{values.owner}} |
| **System** | ${{values.system}} |
| **Repository** | [${{values.destination.owner}}/${{values.name}}](${{values.repoUrl}}) |
| **Created** | {{ now() | strftime('%Y-%m-%d') }} |

## Support

If you need help with this project:

1. **Check the documentation** - Start with the relevant sections in this documentation
2. **Contact the owner** - Reach out to ${{values.owner}} for project-specific questions
3. **Platform team** - Contact the platform team for infrastructure and tooling questions
4. **Security concerns** - Contact the security team for security-related issues

## License

This project is licensed under the terms specified in the repository's LICENSE file.