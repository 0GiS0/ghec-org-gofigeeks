# Node.js Service Template

[![Template CI/CD](https://github.com/${github_organization}/${repository_name}/actions/workflows/ci-template.yml/badge.svg)](https://github.com/${github_organization}/${repository_name}/actions/workflows/ci-template.yml)

Este template permite crear un nuevo microservicio Node.js con TypeScript, Express y mejores prácticas de desarrollo.

## ¿Qué incluye este template?

### Tecnologías y frameworks
- **Node.js** con **TypeScript** para tipado estático
- **Express.js** como framework web
- **ESLint** y **Prettier** para calidad de código
- **Jest** para testing
- **Supertest** para testing de APIs
- **Swagger/OpenAPI** para documentación de APIs

### Estructura del proyecto
- `src/` - Código fuente de la aplicación
  - `controllers/` - Controladores de la API
  - `models/` - Modelos de datos
  - `routes/` - Definición de rutas
  - `middleware/` - Middlewares personalizados
- `tests/` - Tests automatizados
- `.devcontainer/` - Configuración para desarrollo en contenedores
- `.github/workflows/` - Pipelines de CI/CD

### Funcionalidades incluidas
- **API REST** con endpoints CRUD para excursiones
- **Health checks** para monitoreo
- **Logging estructurado** con Winston
- **Validación de datos** con Joi
- **Manejo de errores** centralizado
- **Rate limiting** para protección
- **CORS** configurado
- **Documentación automática** con Swagger

### DevOps y CI/CD
- **GitHub Actions** para CI/CD
- **Docker** y **DevContainer** para desarrollo
- **Dependabot** para actualizaciones automáticas
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
   - Repositorio con toda la estructura
   - Configuración de protección de rama
   - Pipelines de CI/CD configurados
   - Documentación inicial

## Estructura generada

```
my-service/
├── src/
│   ├── controllers/
│   │   └── ExcursionController.js
│   ├── models/
│   │   └── Excursion.js
│   ├── routes/
│   │   └── excursions.js
│   └── index.js
├── tests/
│   └── api.test.js
├── .devcontainer/
│   └── devcontainer.json
├── .github/
│   └── workflows/
│       └── ci.yml
├── docs/
│   ├── index.md
│   └── api.md
├── package.json
├── tsconfig.json
├── .eslintrc.js
├── .prettierrc
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Mejores prácticas incluidas

- **12 Factor App** principles
- **RESTful API** design
- **Error handling** patterns
- **Security headers** y middlewares
- **Environment configuration**
- **Graceful shutdown**
- **Health checks** para Kubernetes
- **Observability** (logs, métricas)

## Soporte

- **Documentación**: Consulta la documentación generada en `docs/`
- **Issues**: Reporta problemas en el repositorio del template
- **Slack**: Canal #platform-team para soporte

### Static Badges Regeneration

El workflow `Generate Badges` actualiza los SVG en `badges/` cuando:

- Se hace push a `main`
- Se crea/edita/cierra/reabre/elimina un issue
- Finaliza el workflow de CI `Template CI/CD`
- Se ejecuta manualmente (workflow_dispatch)

Si añades nuevos badges:
1. Edita `.github/workflows/generate_badges.yml` y genera un nuevo archivo SVG (ej: `coverage.svg`).
2. Añade la referencia en este README: `![Coverage](./badges/coverage.svg)`.
3. Dispara el workflow manualmente para generarlo.

Los badges existentes:
- `ci-status.svg`: Última conclusión del workflow CI (success, failure, running...)
- `issues-open.svg`: Número actual de issues abiertos (colores por umbrales)

> Consejo: Evita enlazar a Shields.io directamente en repos privados; las peticiones externas pueden exponer metadatos o fallar tras autenticación.
