# Template Usage Guide

This guide explains how to use the **${template_name}** template effectively to create new ${template_type} projects.

## Before You Start

### Prerequisites

- Access to your organization's Backstage instance
- Basic understanding of ${template_type} development
- Required permissions to create repositories in your organization

### Understanding This Template

**Template Type:** ${template_type}
**Primary Use Case:** ${template_description}
**Organization:** ${github_organization}

## Step-by-Step Usage

### 1. Access the Template

1. **Open Backstage:** Navigate to your organization's Backstage instance
2. **Create Component:** Click on "Create Component" or "Create" button
3. **Find Template:** Look for "${template_name}" in the available templates
4. **Start Creation:** Click "Choose" to begin using this template

### 2. Complete the Form

The template will prompt you for several required parameters:

#### **Project Name**
- **Format:** kebab-case (lowercase with hyphens)
- **Example:** `my-awesome-service`, `user-authentication-api`
- **Requirements:** Must be unique within your organization

#### **Description**
- **Purpose:** Brief description of what your project does
- **Example:** "Microservice for handling user authentication and authorization"
- **Best Practice:** Keep it concise but descriptive

#### **Owner**
- **Format:** Team or individual username
- **Example:** `platform-team`, `frontend-team`, `john.smith`
- **Recommendation:** Use team names rather than individual names when possible

#### **System**
- **Purpose:** Logical grouping of related components
- **Example:** `user-management`, `payment-processing`, `analytics`
- **Note:** Should align with your organization's system architecture

#### **Repository URL**
- **Format:** GitHub repository URL structure
- **Example:** `https://github.com/my-org/my-awesome-service`
- **Note:** Repository will be created at this location

### 3. Review and Create

1. **Review Configuration:** Double-check all parameters
2. **Submit:** Click "Create" to generate your project
3. **Wait for Completion:** Backstage will create the repository and scaffold the project
4. **Access Repository:** Once complete, you'll receive a link to your new repository

## Generated Project Structure

The template creates a complete, production-ready project structure:

### Core Files
```
my-new-project/
├── README.md              # Project overview and quick start
├── .env.example          # Environment variable template
├── .gitignore           # Git ignore patterns
├── catalog-info.yaml    # Backstage catalog registration
├── mkdocs.yml          # TechDocs configuration
└── docs/               # Complete documentation structure
```

### Documentation Structure
```
docs/
├── index.md           # Main documentation page
├── getting-started.md # Setup and installation
├── development.md     # Development guidelines
├── architecture.md    # Technical architecture
├── api-reference.md   # API documentation
├── deployment.md      # Deployment procedures
└── contributing.md    # Contribution guidelines
```

### Technology-Specific Files

The template also includes files specific to ${template_type} development:

%{ if template_type == "service" ~}
- Source code directory with example implementations
- Configuration files for the runtime environment
- Test files and testing framework setup
- CI/CD pipeline configuration
- Development environment setup (dev containers)
%{ endif ~}

%{ if template_type == "website" ~}
- Frontend application structure
- Build configuration and tooling
- Static asset management
- Development server configuration
%{ endif ~}

%{ if template_type == "resource" ~}
- Configuration templates and examples
- Validation scripts and tools
- Environment-specific configurations
- Documentation for configuration options
%{ endif ~}

## Post-Creation Steps

### Immediate Actions

1. **Clone Repository:**
   ```bash
   git clone [repository-url]
   cd [project-name]
   ```

2. **Set Up Environment:**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Install Dependencies:**
   Follow the instructions in the generated README.md

4. **Verify Setup:**
   Run the project locally to ensure everything works

### Configuration

#### Environment Variables
Review and configure the `.env` file with appropriate values for your environment.

#### Repository Settings
- **Add team members** with appropriate permissions
- **Configure branch protection** rules if needed
- **Set up required status checks** for CI/CD

#### Documentation
- **Customize the documentation** to reflect your specific implementation
- **Update API documentation** with your actual endpoints
- **Modify architecture diagrams** as needed

### Development Workflow

1. **Create Feature Branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Changes:**
   - Implement your feature
   - Add or update tests
   - Update documentation

3. **Submit Pull Request:**
   - Push your branch
   - Create PR for review
   - Address feedback

## Best Practices

### Naming Conventions

- **Use descriptive names** that clearly indicate the project's purpose
- **Follow kebab-case** for repository names
- **Be consistent** with your organization's naming patterns

### Project Organization

- **Start with the basics** and expand as needed
- **Keep documentation up-to-date** as the project evolves
- **Follow the established patterns** in the generated code
- **Use the provided tools** (linting, testing, etc.)

### Team Collaboration

- **Assign appropriate owners** (prefer teams over individuals)
- **Set up proper access controls** for the repository
- **Establish code review processes** early
- **Document decisions** in the architecture documentation

## Customization Options

### Template Modifications

If you need to modify the template itself:

1. **Fork the template repository**
2. **Make your changes** to the skeleton files
3. **Test thoroughly** in a development environment
4. **Submit pull request** for review

### Project-Specific Customization

After creating a project from the template:

- **Remove unused files** that don't apply to your use case
- **Add additional dependencies** as needed
- **Customize configurations** for your specific requirements
- **Extend documentation** with project-specific information

## Common Issues and Solutions

### Template Not Available

**Problem:** Template doesn't appear in Backstage
**Solution:** 
- Check with your platform team
- Verify template is properly registered in the catalog
- Ensure you have appropriate permissions

### Parameter Validation Errors

**Problem:** Form validation fails
**Solution:**
- Use kebab-case for project names
- Ensure all required fields are filled
- Check that repository URL follows the correct format

### Generated Project Issues

**Problem:** Generated project doesn't build or run
**Solution:**
- Check the project README for setup instructions
- Verify all dependencies are installed
- Review environment variable configuration
- Contact the project owner or platform team

### Repository Creation Fails

**Problem:** Repository is not created successfully
**Solution:**
- Verify you have permissions to create repositories
- Check that the repository name is unique
- Ensure the organization/namespace is correct

## Getting Help

### Support Channels

- **Template Issues:** Contact `@${github_organization}/template-approvers`
- **Backstage Problems:** Contact `@${github_organization}/platform-team`
- **Generated Project Help:** Contact the project owner
- **Security Concerns:** Contact `@${github_organization}/security`

### Documentation Resources

- **This Template Documentation:** Complete guide you're reading now
- **Backstage Documentation:** General Backstage usage and features
- **Organization Guidelines:** Your organization's development standards
- **Technology Documentation:** Specific to ${template_type} development

### Community

- **Internal Chat Channels:** Check for organization-specific chat rooms
- **Team Meetings:** Attend platform team meetings if available
- **Documentation Updates:** Contribute improvements to this documentation

## Advanced Usage

### Bulk Project Creation

For creating multiple similar projects:

1. **Plan the structure** for all projects
2. **Use consistent naming** patterns
3. **Document relationships** between projects
4. **Consider system boundaries** and ownership

### Integration with Existing Systems

- **Catalog Discovery:** Ensure projects are discoverable in Backstage
- **CI/CD Integration:** Connect with your organization's pipelines
- **Monitoring Setup:** Integrate with monitoring and alerting systems
- **Documentation Links:** Cross-reference related projects and systems

## Feedback and Improvements

### Providing Feedback

Your feedback helps improve this template:

- **Report Issues:** Use the template repository's issue tracker
- **Suggest Features:** Propose enhancements through pull requests
- **Share Success Stories:** Let us know how the template helped your project
- **Documentation Improvements:** Suggest clarifications or additions

### Contributing Improvements

- **Template Code:** Improve skeleton files and configurations
- **Documentation:** Enhance this usage guide and examples
- **Best Practices:** Share lessons learned from using the template
- **Examples:** Provide additional use case examples

Thank you for using **${template_name}**! This template is designed to help you get started quickly while following our organization's best practices and standards.