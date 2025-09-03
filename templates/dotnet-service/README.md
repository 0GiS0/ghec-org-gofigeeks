# .NET Service Template

Este template permite crear un nuevo microservicio .NET con ASP.NET Core, C# y mejores prácticas de desarrollo.

## ¿Qué incluye este template?

### Tecnologías y frameworks
- **.NET 8** con **ASP.NET Core** para APIs web
- **C#** con nullable reference types habilitado
- **Entity Framework Core** para acceso a datos
- **Swagger/OpenAPI** para documentación de APIs
- **xUnit** para testing
- **Serilog** para logging estructurado

### Estructura del proyecto
- `src/` - Código fuente de la aplicación
  - `Controllers/` - Controladores de la API
  - `Models/` - Modelos de datos y DTOs
  - `Services/` - Lógica de negocio
  - `Infrastructure/` - Acceso a datos y servicios externos
- `tests/` - Tests automatizados
- `.devcontainer/` - Configuración para desarrollo en contenedores

### Funcionalidades incluidas
- **API REST** con endpoints CRUD para excursiones
- **Health checks** integrados con ASP.NET Core
- **Logging estructurado** con Serilog
- **Validación de modelos** con Data Annotations
- **Manejo de errores** con middleware personalizado
- **CORS** configurado para desarrollo
- **Rate limiting** con ASP.NET Core
- **Documentación automática** con Swagger UI

### DevOps y CI/CD
- **GitHub Actions** para CI/CD
- **Docker** multi-stage build
- **DevContainer** para desarrollo consistente
- **Dependabot** para actualizaciones de NuGet
- **CodeQL** para análisis de seguridad
- **MkDocs** para documentación técnica

## Uso

1. Utiliza este template desde Backstage
2. Completa el formulario con:
   - Nombre del proyecto (en kebab-case)
   - Descripción del servicio
   - Sistema al que pertenece
   - Tier de servicio (1-3 o experimental)
   - Equipo responsable

3. El template creará:
   - Repositorio con toda la estructura .NET
   - Configuración de protección de rama
   - Pipelines de CI/CD configurados
   - Documentación inicial

## Estructura generada

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

## Mejores prácticas incluidas

- **Clean Architecture** principles
- **SOLID** principles
- **Dependency Injection** nativo de .NET
- **Configuration** pattern con appsettings.json
- **Health checks** para Kubernetes readiness/liveness
- **Graceful shutdown** handling
- **Security headers** middleware
- **API versioning** preparado
- **Observability** (logs, métricas, traces)

## Configuración de desarrollo

- **Hot reload** habilitado
- **Swagger UI** disponible en desarrollo
- **HTTPS** configurado con certificados de desarrollo
- **Environment variables** para configuración
- **Docker Compose** para dependencias locales

## Soporte

- **Documentación**: Consulta la documentación generada en `docs/`
- **Issues**: Reporta problemas en el repositorio del template
- **Slack**: Canal #platform-team para soporte
