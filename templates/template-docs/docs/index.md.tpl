# ${template_name}

${template_description}

This is a Backstage software template that helps developers quickly create new ${template_type} projects following our organization's standards and best practices.

## Overview

**Template Type:** ${template_type}
**Organization:** ${github_organization}
**Repository:** [${github_organization}/${template_name}](https://github.com/${github_organization}/${template_name})

This template generates projects with:

- Pre-configured project structure
- Essential dependencies and tooling
- Standard configuration files
- Complete documentation structure with TechDocs
- CI/CD pipeline configuration
- Development environment setup

## Quick Start

### Using this Template in Backstage

1. **Navigate to Backstage:** Open your Backstage instance
2. **Create Component:** Click "Create Component" 
3. **Select Template:** Choose "${template_name}"
4. **Fill Form:** Complete the required information
5. **Create:** Click "Create" to generate your new project

### Template Parameters

When using this template, you'll be prompted for:

| Parameter | Description | Required |
|-----------|-------------|----------|
| **Name** | Project name (kebab-case) | ✅ |
| **Description** | Project description | ✅ |
| **Owner** | Project owner (team or user) | ✅ |
| **System** | System this component belongs to | ✅ |
| **Repository URL** | GitHub repository location | ✅ |

## Generated Project Structure

The template creates a complete project with:

```
my-new-project/
├── README.md                 # Project documentation
├── .env.example             # Environment variable template
├── .gitignore              # Git ignore patterns
├── catalog-info.yaml       # Backstage catalog registration
├── mkdocs.yml              # TechDocs configuration
├── docs/                   # Project documentation
│   ├── index.md           # Main documentation page
│   ├── getting-started.md # Setup and installation guide
│   ├── development.md     # Development guidelines
│   ├── architecture.md    # Technical architecture
│   ├── api-reference.md   # API documentation
│   ├── deployment.md      # Deployment guide
│   └── contributing.md    # Contribution guidelines
├── .github/
│   └── workflows/         # CI/CD pipelines
├── src/                   # Source code
└── tests/                 # Test files
```

## Features

### 📚 TechDocs Integration

Every project generated from this template includes:

- **MkDocs configuration** for documentation generation
- **Comprehensive documentation structure** with multiple sections
- **Material theme** for professional documentation appearance
- **Search functionality** and navigation features
- **Automatic integration** with Backstage TechDocs

### 🔧 Development Environment

- **Dev Container** configuration for consistent development environments
- **Environment variables** template with example values
- **Linting and formatting** tools pre-configured
- **Testing framework** setup and example tests

### 🚀 CI/CD Pipeline

- **GitHub Actions** workflows for automated testing and deployment
- **Code quality checks** including linting and testing
- **Security scanning** with CodeQL and secret detection
- **Automated deployments** for different environments

### 🛡️ Security

- **Dependabot** configuration for dependency updates
- **Security policies** and vulnerability scanning
- **Branch protection** rules and required checks
- **CODEOWNERS** file for code review requirements

## Template Development

### Modifying the Template

This template is managed through Infrastructure as Code using Terraform. To modify:

1. **Update skeleton files** in the `skeleton/` directory
2. **Modify template.yaml** for parameter changes
3. **Test locally** using Backstage development environment
4. **Submit pull request** for review and deployment

### Skeleton Files

The `skeleton/` directory contains the template files that are used to generate new projects:

- `**/*.tpl` files are processed as templates with parameter substitution
- Regular files are copied as-is to the new project
- Directory structure is preserved in the generated project

### Testing the Template

Before deploying changes:

1. **Local testing:** Use Backstage development instance
2. **Parameter validation:** Test all parameter combinations
3. **Generated project:** Verify the generated project works correctly
4. **Documentation:** Ensure all documentation is accurate

## Examples

### Example Generated Project

Here's what a project generated from this template looks like:

**Project Name:** `my-awesome-service`
**Description:** `A microservice for handling user authentication`
**Owner:** `platform-team`
**System:** `user-management`

The generated project will have:
- Repository: `github.com/my-org/my-awesome-service`
- Documentation: Available in Backstage TechDocs
- CI/CD: Automated pipelines for testing and deployment
- Development: Ready-to-use development environment

### Common Use Cases

This template is ideal for:

- **${template_type} applications** following our standards
- **Microservices** that need rapid development setup
- **Prototypes** that may evolve into production services
- **Learning projects** for new team members

## Best Practices

### Template Usage

- **Use descriptive names** for your projects (kebab-case)
- **Choose appropriate owners** (teams rather than individuals when possible)
- **Select correct systems** to ensure proper organization
- **Follow naming conventions** established by your organization

### After Project Creation

1. **Review generated files** and customize as needed
2. **Update documentation** to reflect your specific implementation
3. **Configure environment variables** for your use case
4. **Set up monitoring and alerting** for production services
5. **Add team members** and configure repository permissions

## Support

### Getting Help

- **Template Issues:** Contact `@${github_organization}/template-approvers`
- **Backstage Issues:** Contact `@${github_organization}/platform-team`
- **Generated Project Issues:** Contact the project owner
- **Security Concerns:** Contact `@${github_organization}/security`

### Common Issues

#### Template Not Appearing in Backstage

**Cause:** Template not registered in catalog
**Solution:** Ensure `template.yaml` is valid and repository is accessible

#### Parameter Validation Errors

**Cause:** Invalid parameter values
**Solution:** Check parameter format requirements (e.g., kebab-case for names)

#### Generated Project Build Failures

**Cause:** Missing dependencies or configuration issues
**Solution:** Check the project's README.md for setup instructions

## Contributing

We welcome contributions to improve this template:

1. **Fork the repository**
2. **Create a feature branch**
3. **Make your changes** to skeleton files or template configuration
4. **Test thoroughly** with local Backstage instance
5. **Submit pull request** with detailed description

### Contribution Guidelines

- **Follow existing patterns** in skeleton files
- **Update documentation** for any changes
- **Test with multiple parameter combinations**
- **Consider backward compatibility** for existing projects

## Changelog

### Version History

Track changes and improvements to this template:

- **v1.0.0:** Initial template release
- **v1.1.0:** Added TechDocs integration
- **v1.2.0:** Enhanced CI/CD pipeline

## Related Templates

Other templates available in our organization:

%{ for template_name in related_templates ~}
- **${template_name}:** ${template_descriptions[template_name]}
%{ endfor ~}

## Resources

- [Backstage Software Templates Documentation](https://backstage.io/docs/features/software-templates/)
- [TechDocs Documentation](https://backstage.io/docs/features/techdocs/)
- [Organization Development Guidelines](../organization-guidelines.md)
- [Template Development Guide](../template-development.md)