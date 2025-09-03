# FastAPI Service Template

Este template permite crear un nuevo microservicio FastAPI con Python, soporte asíncrono y mejores prácticas de desarrollo.

## ¿Qué incluye este template?

### Tecnologías y frameworks
- **FastAPI** para APIs web de alto rendimiento
- **Python 3.11+** con type hints
- **Pydantic** para validación de datos
- **SQLAlchemy** para ORM asíncrono
- **Pytest** para testing
- **Uvicorn** como servidor ASGI
- **Poetry** para gestión de dependencias

### Estructura del proyecto
- `app/` - Código fuente de la aplicación
  - `routers/` - Rutas y endpoints de la API
  - `models/` - Modelos de datos SQLAlchemy
  - `schemas/` - Esquemas Pydantic para validación
  - `services/` - Lógica de negocio
  - `core/` - Configuración y utilidades
- `tests/` - Tests automatizados
- `docs/` - Documentación técnica con MkDocs
- `.devcontainer/` - Configuración para desarrollo en contenedores

### Funcionalidades incluidas
- **API REST** con endpoints CRUD para excursiones
- **OpenAPI/Swagger** documentación automática
- **Health checks** con FastAPI
- **Logging estructurado** con Loguru
- **Validación automática** con Pydantic
- **Manejo de errores** con exception handlers
- **CORS** configurado para desarrollo
- **Rate limiting** con slowapi
- **Database migrations** con Alembic

### DevOps y CI/CD
- **GitHub Actions** para CI/CD
- **Docker** multi-stage build optimizado
- **DevContainer** para desarrollo consistente
- **Dependabot** para actualizaciones de dependencias
- **CodeQL** para análisis de seguridad
- **MkDocs** para documentación técnica
- **Poetry** para gestión reproducible de dependencias

## Uso

1. Utiliza este template desde Backstage
2. Completa el formulario con:
   - Nombre del proyecto (en kebab-case)
   - Descripción del servicio
   - Sistema al que pertenece
   - Tier de servicio (1-3 o experimental)
   - Equipo responsable

3. El template creará:
   - Repositorio con toda la estructura FastAPI
   - Configuración de protección de rama
   - Pipelines de CI/CD configurados
   - Documentación inicial

## Estructura generada

```
my-service/
├── app/
│   ├── routers/
│   │   └── excursions.py
│   ├── models/
│   │   └── excursion.py
│   ├── schemas/
│   │   └── excursion.py
│   ├── core/
│   │   ├── config.py
│   │   └── database.py
│   └── main.py
├── tests/
│   ├── test_api.py
│   └── conftest.py
├── docs/
│   ├── index.md
│   └── getting-started.md
├── .devcontainer/
│   └── devcontainer.json
├── .github/
│   └── workflows/
│       └── ci.yml
├── pyproject.toml
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Mejores prácticas incluidas

- **Async/await** patterns para alta concurrencia
- **Dependency injection** con FastAPI
- **Database connection pooling**
- **Request/Response models** con Pydantic
- **Error handling** centralizado
- **Security** con OAuth2/JWT preparado
- **API versioning** estructura preparada
- **Observability** (logs, métricas, traces)
- **12 Factor App** principles

## Configuración de desarrollo

- **Hot reload** con Uvicorn
- **Interactive API docs** en `/docs` y `/redoc`
- **Database migrations** con Alembic
- **Environment variables** para configuración
- **Docker Compose** para dependencias locales
- **Linting** con Ruff y Black
- **Type checking** con mypy

## Testing

- **Pytest** con fixtures async
- **Test client** de FastAPI
- **Database testing** con SQLite in-memory
- **Coverage** reporting incluido

## Soporte

- **Documentación**: Consulta la documentación generada en `docs/`
- **Issues**: Reporta problemas en el repositorio del template
- **Slack**: Canal #platform-team para soporte
