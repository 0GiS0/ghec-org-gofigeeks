# Domain Template

<!-- Badges -->
<p align="left">
   <a href="https://github.com/0GiS0/backstage-template-domain/actions/workflows/ci.yml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/0GiS0/backstage-template-domain/ci.yml?branch=main&label=CI&logo=github" /></a>
   <a href="https://github.com/0GiS0/backstage-template-domain/security/code-scanning"><img alt="CodeQL" src="https://img.shields.io/github/actions/workflow/status/0GiS0/backstage-template-domain/codeql.yml?branch=main&label=CodeQL&logo=github" /></a>
   <a href="https://github.com/0GiS0/backstage-template-domain/issues"><img alt="Issues" src="https://img.shields.io/github/issues/0GiS0/backstage-template-domain?logo=github" /></a>
   <a href="https://github.com/0GiS0/backstage-template-domain/pulls"><img alt="PRs" src="https://img.shields.io/github/issues-pr/0GiS0/backstage-template-domain?logo=github" /></a>
   <a href="https://github.com/0GiS0/backstage-template-domain/commits/main"><img alt="Last Commit" src="https://img.shields.io/github/last-commit/0GiS0/backstage-template-domain?logo=github" /></a>
   <a href="https://github.com/0GiS0/backstage-template-domain/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/0GiS0/backstage-template-domain" /></a>
   <a href="https://github.com/0GiS0/backstage-template-domain/network/dependencies"><img alt="Dependabot" src="https://img.shields.io/badge/Dependabot-enabled-success?logo=dependabot" /></a>
</p>

Este template permite crear una nueva entidad de tipo Domain en Backstage para agrupar sistemas y componentes relacionados por área de negocio.

## ¿Qué es un Domain en Backstage?

Un **Domain** es una entidad de alto nivel que representa un área de negocio, un dominio funcional o una responsabilidad organizacional. Los dominios ayudan a:

- **Organizar sistemas** por área de negocio
- **Establecer ownership** a nivel organizacional
- **Definir límites** de responsabilidad claros
- **Facilitar la governanza** y compliance

## ¿Cuándo usar este template?

### Casos de uso ideales:
- **Áreas de negocio** claramente definidas
- **Dominios funcionales** independientes
- **Organizaciones** o equipos grandes
- **Compliance** y governanza por dominio

### Ejemplos según Domain-Driven Design:
- `user-experience` - Frontend, UX, personalizaciones
- `sales` - CRM, facturación, contratos, comisiones  
- `fulfillment` - Inventario, logística, entregas
- `customer-support` - Tickets, chat, knowledge base
- `platform` - Infrastructure, monitoring, deployment
- `security` - Authentication, authorization, audit

## ¿Qué incluye este template?

### Estructura generada
- **catalog-info.yaml** - Definición de la entidad Domain
- **README.md** - Documentación del dominio
- **docs/** - Documentación de negocio y técnica
- **.github/** - Configuración de workflows básicos

### Configuración de repositorio
- **Visibilidad**: Privada por defecto
- **Branch protection**: main protegida con revisiones  
- **Custom properties**: service-tier (tier-2), team-owner
- **Topics**: backstage-include, domain, catalog

## Uso

1. Utiliza este template desde Backstage
2. Completa el formulario con:
   - **Nombre del dominio** (en kebab-case)
   - **Descripción** del área de negocio o responsabilidad
   - **Equipo propietario** responsable del dominio

3. El template creará:
   - Repositorio con la entidad Domain definida
   - Configuración de protección de rama
   - Documentación inicial
   - Registro automático en el catálogo

## Estructura generada

```
my-domain/
├── catalog-info.yaml     # Definición de la entidad Domain
├── README.md            # Documentación del dominio
├── docs/
│   ├── index.md        # Documentación principal
│   ├── business.md     # Descripción de negocio
│   ├── systems.md      # Sistemas incluidos
│   └── governance.md   # Políticas y governanza
├── .github/
│   └── workflows/
│       └── docs.yml    # CI para documentación
└── mkdocs.yml          # Configuración de MkDocs
```

## Mejores prácticas

### Naming Convention
- Usa **kebab-case**: `user-experience`, `customer-support`
- Nombres **descriptivos** del área de negocio
- Evita sufijos técnicos (no `user-domain`)
- Mantén **consistencia** con la organización

### Descripción
- **Área de negocio** que representa
- **Responsabilidades** principales
- **Stakeholders** y equipos involucrados
- **Objetivos** de negocio del dominio

### Organizacion por dominio
- **Agrupa sistemas** relacionados por negocio
- **Define boundaries** claros entre dominios
- **Establece policies** específicas del dominio
- **Documenta relaciones** entre dominios

## Relaciones en Backstage

### Un Domain puede incluir:
- **Systems** - Colecciones de componentes relacionados
- **Components** - Servicios específicos del dominio
- **APIs** - Interfaces expuestas por el dominio

### Ejemplo de jerarquía completa:
```
Domain: Sales
├── System: customer-relationship-system
│   ├── Component: crm-service
│   ├── Component: lead-tracker
│   └── API: customers-api
├── System: billing-system
│   ├── Component: invoice-service
│   ├── Component: payment-processor
│   └── API: billing-api
└── System: commission-system
    ├── Component: calculator-service
    └── API: commission-api
```

## Patterns por tipo de organización

### Por Funcionalidad de Negocio
```
- user-experience     # UX, Frontend, Personalization
- sales              # CRM, Billing, Contracts
- fulfillment        # Inventory, Logistics
- customer-support   # Tickets, Chat, KB
```

### Por Capabilities (DDD)
```
- identity           # Users, Auth, Permissions  
- catalog           # Products, Inventory
- ordering          # Cart, Checkout, Orders
- payment           # Billing, Transactions
```

### Por Layers Técnicos
```
- platform          # Infrastructure, Core Services
- integration       # APIs, ETL, Messaging
- presentation      # Web, Mobile, APIs
- analytics         # BI, Reporting, ML
```

## Configuración post-creación

### 1. Definir boundaries del dominio
- Establecer **responsabilidades** claras
- Documentar **interfaces** con otros dominios
- Definir **policies** específicas

### 2. Organizar systems y components
- Mover systems existentes al dominio
- Actualizar catalog-info.yaml de systems con `domain:`
- Crear nuevos systems si es necesario

### 3. Governance y compliance
- Establecer **SLAs** a nivel de dominio
- Definir **security policies**
- Configurar **monitoring** agregado

## Domain-Driven Design (DDD)

### Core Concepts aplicables:
- **Bounded Context** = Domain boundary
- **Ubiquitous Language** = Terminology consistente
- **Domain Services** = Components del domain
- **Anti-corruption Layer** = APIs entre domains

### Ejemplo práctico:
```yaml
# Domain: sales
systems:
  - customer-relationship-system
  - billing-system
  - commission-system

# Cada system mantiene su bounded context
# APIs definen contratos entre domains
```

## Soporte

- **Documentación**: Consulta la documentación generada en `docs/`
- **Issues**: Reporta problemas en el repositorio del template  
- **Slack**: Canal #platform-team para soporte
- **DDD Resources**: [Domain-Driven Design](https://martinfowler.com/bliki/DomainDrivenDesign.html)
- **Backstage Docs**: [Domains in Backstage](https://backstage.io/docs/features/software-catalog/system-model)
