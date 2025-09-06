# AI Assistant Template

<!-- Badges (templated) -->
<p align="left">
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/actions/workflows/ci.yml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/${{values.github_organization}}/${{values.repo_name}}/ci.yml?branch=main&label=CI&logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/security/code-scanning"><img alt="CodeQL" src="https://img.shields.io/github/actions/workflow/status/${{values.github_organization}}/${{values.repo_name}}/codeql.yml?branch=main&label=CodeQL&logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/issues"><img alt="Issues" src="https://img.shields.io/github/issues/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/pulls"><img alt="PRs" src="https://img.shields.io/github/issues-pr/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/commits/main"><img alt="Last Commit" src="https://img.shields.io/github/last-commit/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/${{values.github_organization}}/${{values.repo_name}}" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/network/dependencies"><img alt="Dependabot" src="https://img.shields.io/badge/Dependabot-enabled-success?logo=dependabot" /></a>
</p>

Este template permite crear un nuevo servicio de asistente de IA con Python, FastAPI y mejores prácticas de desarrollo.

## ¿Qué incluye este template?

### Tecnologías y frameworks
- **Python 3.11+** con **FastAPI** para APIs web
- **OpenAI API** integración para capacidades de IA
- **Pydantic** para validación de datos
- **uvicorn** como servidor ASGI
- **pytest** para testing
- **black** y **isort** para formateo de código

### Estructura del proyecto
- `src/` - Código fuente de la aplicación
  - `main.py` - Archivo principal de la aplicación
  - `models/` - Modelos de datos y DTOs
  - `services/` - Lógica de negocio y servicios IA
  - `api/` - Endpoints de la API
- `tests/` - Tests automatizados
- `.devcontainer/` - Configuración para desarrollo en contenedores

### Funcionalidades incluidas
- **API REST** con endpoints para interacción con IA
- **Chat interface** para conversaciones
- **Health checks** integrados con FastAPI
- **Logging estructurado** con Python logging
- **Validación de modelos** con Pydantic
- **Manejo de errores** personalizado
- **CORS** configurado para desarrollo
- **Rate limiting** para protección de APIs
- **Documentación automática** con Swagger UI

### DevOps y CI/CD
- **GitHub Actions** para CI/CD
- **Docker** multi-stage build
- **DevContainer** para desarrollo consistente
- **Dependabot** para actualizaciones de pip
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
   - Repositorio con toda la estructura Python
   - Configuración de protección de rama
   - Pipelines de CI/CD configurados
   - Documentación inicial

## Estructura generada

```
my-ai-assistant/
├── src/
│   ├── main.py
│   ├── models/
│   │   └── chat.py
│   ├── services/
│   │   └── ai_service.py
│   └── api/
│       └── chat.py
├── tests/
│   ├── test_api.py
│   └── test_services.py
├── .devcontainer/
│   └── devcontainer.json
├── .github/
│   └── workflows/
│       └── ci.yml
├── docs/
│   ├── index.md
│   └── api.md
├── requirements.txt
├── requirements-dev.txt
├── Dockerfile
└── README.md
```

## Mejores prácticas incluidas

- **Clean Architecture** principles
- **Async/await** para operaciones concurrentes
- **Environment variables** para configuración
- **Error handling** robusto
- **API key management** seguro
- **Response caching** para optimización
- **Input validation** exhaustiva
- **Logging** estructurado
- **Health checks** para Kubernetes

## Configuración de desarrollo

- **Hot reload** con uvicorn
- **Interactive API docs** en `/docs`
- **Environment variables** para configuración local
- **Docker Compose** para servicios dependientes
- **Pre-commit hooks** para calidad de código

## Soporte

- **Documentación**: Consulta la documentación generada en `docs/`
- **Issues**: Reporta problemas en el repositorio del template
- **Slack**: Canal #platform-team para soporte
