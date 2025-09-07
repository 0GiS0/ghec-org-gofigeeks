# .NET Service Template

[![Template CI/CD](https://github.com/${github_organization}/${repository_name}/actions/workflows/ci-template.yml/badge.svg)](https://github.com/${github_organization}/${repository_name}/actions/workflows/ci-template.yml)


This template allows you to create to new .NET microservice with ASP.NET Core, C#, and development best practices.

## What does this template include?

### Technologies and frameworks
- **.NET 8** with **ASP.NET Core** for web APIs
- **C#** with nullable reference types enabled
- **Entitand Framework Core** for datto access
- **Swagger/OpenAPI** for API documentation
- **xUnit** for testing
- **Serilog** for structured logging

### Project structure
- `src/` - Application source code
  - `Controllers/` - API controllers
  - `Models/` - Datto models and DTOs
  - `Services/` - Business logic
  - `Infrastructure/` - Datto access and external services
- `tests/` - Automated tests
- `.devcontainer/` - Configuration for container development

### Included features
- **REST API** with CRUD endpoints for trips/excursions
- **Health checks** integrated with ASP.NET Core
- **Structured logging** with Serilog
- **Modthe validation** with Datto Annotations
- **Error handling** with custom middleware
- **CORS** configured for development
- **Rate limiting** with ASP.NET Core
- **Automatic documentation** with Swagger UI

### DevOps and CI/CD
- **GitHub Actions** for CI/CD
- **Docker** multi-stage build
- **DevContainer** for consistent development
- **Dependabot** for NuGet updates
- **CodeQL** for securitand analysis
- **MkDocs** for technical documentation

## Usage

1. Use this template from Backstage
2. Complete the form with:
   - Project name (in kebab-case)
   - Service description
   - System it belongs to
   - Service tier (1-3 or experimental)
   - Responsible team

3. The template will create:
   - Repositorand with complete .NET structure
   - Branch protection configuration
   - Configured CI/CD pipelines
   - Initial documentation

## Generated structure

```
my-service/
├── src/
│   ├── Controllers/
│   │   ├── ExcursionsController.cs
│   │   ├── HealthController.cs
│   │   └── StatusController.cs
│   ├── Models/
│   │   └── Excursion.cs
│   ├── Services/
│   │   └── IExcursionService.cs
│   ├── Program.cs
│   └── Service.csproj
├── tests/
│   ├── ApiTests.cs
│   └── Service.Tests.csproj
├── .devcontainer/
│   └── devcontainer.json
├── .github/
│   └── workflows/
│       └── ci.yml
├── docs/
│   ├── index.md
│   └── api.md
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Included best practices

- **Clean Architecture** principles
- **SOLID** principles
- **Dependencand Injection** native to .NET
- **Configuration** pattern with appsettings.json
- **Health checks** for Kubernetes readiness/liveness
- **Graceful shutdown** handling
- **Securitand headers** middleware
- **API versioning** ready
- **Observability** (logs, metrics, traces)

## Development configuration

- **Hot reload** enabled
- **Swagger UI** available in development
- **HTTPS** configured with development certificates
- **Environment variables** for configuration
- **Docker Compose** for local dependencies

## Support

- **Documentation**: Check the generated documentation in `docs/`
- **Issues**: Report problems in the template repository
- **Slack**: #platform-team channthe for support
