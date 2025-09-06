# ${{values.name}}

<!-- Badges (dynamic using Backstage template variables) -->
<p align="left">
      <a href="https://github.com/0GiS0/${{values.name}}/actions/workflows/ci.yml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/0GiS0/${{values.name}}/ci.yml?branch=main&label=CI&logo=github" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/security/code-scanning"><img alt="CodeQL" src="https://img.shields.io/github/actions/workflow/status/0GiS0/${{values.name}}/codeql.yml?branch=main&label=CodeQL&logo=github" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/issues"><img alt="Issues" src="https://img.shields.io/github/issues/0GiS0/${{values.name}}?logo=github" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/pulls"><img alt="PRs" src="https://img.shields.io/github/issues-pr/0GiS0/${{values.name}}?logo=github" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/commits/main"><img alt="Last Commit" src="https://img.shields.io/github/last-commit/0GiS0/${{values.name}}?logo=github" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/0GiS0/${{values.name}}" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/network/dependencies"><img alt="Dependabot" src="https://img.shields.io/badge/Dependabot-enabled-success?logo=dependabot" /></a>
</p>

${{values.description}}

## 🚀 Quick Start

### Prerequisites

- .NET 8.0 SDK or higher

### Development

1. **Restore dependencies:**
   ```bash
   dotnet restore src/${{values.name | replace("-", "_")}}.csproj
   ```

2. **Build the project:**
   ```bash
   dotnet build src/${{values.name | replace("-", "_")}}.csproj
   ```

3. **Start development server:**
   ```bash
   dotnet run --project src/${{values.name | replace("-", "_")}}.csproj
   ```

4. **Run tests:**
   ```bash
   dotnet test
   ```

### API Documentation

- Swagger UI: https://localhost:5001/docs
- API: https://localhost:5001

### API Endpoints

- `GET /` - Root endpoint with service information
- `GET /health` - Health check endpoint
- `GET /api/hello` - Hello world endpoint
- `GET /api/status` - Service status endpoint

### Docker Development

This project includes a dev container configuration. Open in VS Code and use "Dev Containers: Reopen in Container".

### Production Deployment

```bash
dotnet publish src/${{values.name | replace("-", "_")}}.csproj -c Release -o ./publish
dotnet ./publish/${{values.name | replace("-", "_")}}.dll
```

## 📝 Architecture

This is an ASP.NET Core Web API with:

- ASP.NET Core 8.0
- Swagger/OpenAPI documentation
- Health checks
- CORS support
- Structured logging
- Minimal APIs and Controllers

## 🧪 Testing

Run the test suite:

```bash
dotnet test
```

Run with coverage:

```bash
dotnet test --collect:"XPlat Code Coverage"
```

## 📦 Dependencies

- **Microsoft.AspNetCore.OpenApi**: OpenAPI support
- **Swashbuckle.AspNetCore**: Swagger documentation
- **Microsoft.Extensions.Diagnostics.HealthChecks**: Health checks