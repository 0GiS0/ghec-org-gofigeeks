# System Template

<!-- Badges -->
<p align="left">
   <a href="https://github.com/0GiS0/backstage-template-system/actions/workflows/ci.yml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/0GiS0/backstage-template-system/ci.yml?branch=main&label=CI&logo=github" /></a>
   <a href="https://github.com/0GiS0/backstage-template-system/security/code-scanning"><img alt="CodeQL" src="https://img.shields.io/github/actions/workflow/status/0GiS0/backstage-template-system/codeql.yml?branch=main&label=CodeQL&logo=github" /></a>
   <a href="https://github.com/0GiS0/backstage-template-system/issues"><img alt="Issues" src="https://img.shields.io/github/issues/0GiS0/backstage-template-system?logo=github" /></a>
   <a href="https://github.com/0GiS0/backstage-template-system/pulls"><img alt="PRs" src="https://img.shields.io/github/issues-pr/0GiS0/backstage-template-system?logo=github" /></a>
   <a href="https://github.com/0GiS0/backstage-template-system/commits/main"><img alt="Last Commit" src="https://img.shields.io/github/last-commit/0GiS0/backstage-template-system?logo=github" /></a>
   <a href="https://github.com/0GiS0/backstage-template-system/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/0GiS0/backstage-template-system" /></a>
   <a href="https://github.com/0GiS0/backstage-template-system/network/dependencies"><img alt="Dependabot" src="https://img.shields.io/badge/Dependabot-enabled-success?logo=dependabot" /></a>
</p>

Este template permite crear una nueva entidad de tipo System en Backstage para organizar componentes y recursos relacionados.

## ¿Qué es un System en Backstage?

Un **System** es una colección de entidades que cooperan para ofrecer una funcionalidad específica. Los sistemas ayudan a:

- **Organizar componentes** relacionados bajo una unidad lógica
- **Definir límites** claros entre diferentes partes de la arquitectura
- **Facilitar la navegación** del catálogo de servicios
- **Establecer ownership** y responsabilidades claras

## ¿Cuándo usar este template?

### Casos de uso ideales:
- **Microservicios relacionados** que forman una funcionalidad completa
- **Conjunto de APIs** que trabajan juntas
- **Plataforma o producto** que incluye múltiples componentes
- **Subsistemas** dentro de una arquitectura más grande

### Ejemplos:
- `user-management-system` - Agrupa servicios de autenticación, perfiles, preferencias
- `payment-system` - Incluye procesamiento, facturación, notificaciones
- `content-platform` - CMS, CDN, recomendaciones, búsqueda
- `analytics-system` - Ingesta, procesamiento, visualización de datos

## ¿Qué incluye este template?

### Estructura generada
- **catalog-info.yaml** - Definición de la entidad System
- **README.md** - Documentación del sistema
- **docs/** - Documentación técnica con MkDocs
- **.github/** - Configuración de workflows básicos

### Configuración de repositorio
- **Visibilidad**: Privada por defecto
- **Branch protection**: main protegida con revisiones
- **Custom properties**: service-tier (tier-2), team-owner
- **Topics**: backstage-include, system, catalog

## Uso

1. Utiliza este template desde Backstage
2. Completa el formulario con:
   - **Nombre del sistema** (en kebab-case)
   - **Descripción** clara del propósito del sistema
   - **Equipo propietario** responsable del sistema
   - **Dominio** (opcional) al que pertenece

3. El template creará:
   - Repositorio con la entidad System definida
   - Configuración de protección de rama
   - Documentación inicial
   - Registro automático en el catálogo

## Estructura generada

```
my-system/
├── catalog-info.yaml    # Definición de la entidad System
├── README.md           # Documentación del sistema
├── docs/
│   ├── index.md       # Documentación principal
│   ├── architecture.md # Arquitectura del sistema
│   └── components.md  # Componentes incluidos
├── .github/
│   └── workflows/
│       └── docs.yml   # CI para documentación
└── mkdocs.yml         # Configuración de MkDocs
```

## Mejores prácticas

### Naming Convention
- Usa **kebab-case**: `user-management-system`
- Incluye **-system** al final para claridad
- Mantén nombres **descriptivos** pero **concisos**

### Descripción
- **Funcionalidad principal** del sistema
- **Valor de negocio** que aporta
- **Límites** y responsabilidades claras
- **Tecnologías principales** utilizadas

### Organización
- **Agrupa componentes** relacionados funcionalmente
- **Define APIs** y contratos entre sistemas
- **Documenta dependencias** con otros sistemas
- **Establece métricas** y SLIs del sistema

## Relaciones en Backstage

### Un System puede incluir:
- **Components** (servicios, bibliotecas, websites)
- **APIs** que expone o consume
- **Resources** (bases de datos, colas, buckets)

### Un System puede pertenecer a:
- **Domain** - Área de negocio más amplia

### Ejemplo de jerarquía:
```
Domain: E-commerce
└── System: user-management-system
    ├── Component: auth-service
    ├── Component: profile-service
    ├── API: user-api
    └── Resource: users-database
```

## Configuración post-creación

### 1. Documentar arquitectura
- Añadir diagramas en `docs/architecture.md`
- Definir APIs y contratos
- Documentar patrones de comunicación

### 2. Conectar componentes
- Actualizar componentes existentes para referenciar el system
- Definir relaciones `providesApis` y `consumesApis`
- Establecer dependencias con `dependsOn`

### 3. Métricas y monitoring
- Definir SLIs y SLOs del sistema
- Configurar dashboards agregados
- Establecer alertas a nivel de sistema

## Soporte

- **Documentación**: Consulta la documentación generada en `docs/`
- **Issues**: Reporta problemas en el repositorio del template
- **Slack**: Canal #platform-team para soporte
- **Backstage Docs**: [Systems in Backstage](https://backstage.io/docs/features/software-catalog/system-model)
