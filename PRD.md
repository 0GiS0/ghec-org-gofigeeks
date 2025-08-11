# 📋 PRD — Gestión de Equipos y Repos de Plantillas Backstage en GHEC

## 🎯 1. Propósito
Definir los requisitos para un repositorio que gestione mediante **Infrastructure as Code**:
1. La **creación y configuración de equipos** en la organización de GitHub Enterprise Cloud (GHEC).
2. La **creación y configuración de repositorios de plantillas** para Backstage.

Este repositorio permitirá que la configuración de equipos y plantillas sea **trazable, auditable y replicable**, eliminando cambios manuales y manteniendo un estado coherente con el diseño de la plataforma.

## 🔍 2. Alcance
### ✅ In Scope
- **👥 Creación y gestión** de equipos y jerarquías en GHEC.
- **📦 Creación y configuración** de repositorios de plantillas para Backstage:
  - 🔧 Configuración inicial (descripción, temas, visibilidad, branch principal).
  - 🛡️ Reglas de calidad (branch protection, checks obligatorios, CODEOWNERS).
  - 🔐 Asignación de permisos por equipo.
- **🔗 Gestión de permisos** Team → Repo para las plantillas.
- **✅ Checks obligatorios** en cada plantilla (CI, lint, build de docs, CodeQL).

### ❌ Out of Scope
- **🚫 Creación de repositorios de servicios/producto** (se harán on-demand mediante el IDP de Backstage).
- **🚫 Gestión de políticas globales** de la organización (p. ej., allowed actions, default repo permissions), que se tratarán en otro repositorio.
- **🚫 Gestión de usuarios** fuera del ámbito de asignación a equipos.

## 👥 3. Stakeholders
- **🛠️ Platform Team**: propietarios del repositorio, definición de estándares y aprobación de cambios.
- **✅ Template Approvers**: responsables de validar cambios en las plantillas.
- **🔒 Security Team**: revisores de reglas y alertas de seguridad.
- **👀 Read-only Users**: acceso de lectura para revisión o auditoría.

## 🚀 4. Objetivos y Motivación
- **📏 Estandarizar** la creación y mantenimiento de equipos y plantillas.
- **⚡ Automatizar** la configuración para reducir errores humanos.
- **✔️ Controlar calidad** con reglas y checks predefinidos.
- **🎁 Facilitar el onboarding** de nuevos equipos y plantillas en Backstage.

## ⚙️ 5. Funcionalidades Requeridas
1. **👥 Gestión de equipos**:
   - Creación de equipos core:
     - `canary-trips` (padre)
     - `platform-team`
     - `template-approvers`
     - `security`
     - `read-only`
   - Definición de jerarquía (`parent_team`).
   - Asignación de maintainers y miembros.

2. **📦 Gestión de repositorios de plantillas**:
   - Repos incluidos:
     - `backstage-template-node-service`
     - `backstage-template-fastapi-service`
     - `backstage-template-dotnet-service`
     - `backstage-template-gateway`
     - `backstage-template-ai-assistant`
     - `backstage-template-astro-frontend`
     - `backstage-template-helm-base`
     - `backstage-template-env-live`
   - Configuración inicial: descripción, topics, visibilidad privada, auto-init.
   - Asignación de permisos a equipos (`platform-team`, `template-approvers`, `security`, `read-only`).
   - Configuración de ruleset:
     - Revisión obligatoria (≥1).
     - CODEOWNERS para `skeleton/` y `template.yaml`.
     - Checks obligatorios: `ci-template`, `lint`, `docs-build`, `codeql`.
     - Bloqueo de force pushes.

3. **📊 Trazabilidad y cambios controlados**:
   - Todo cambio se hará mediante Pull Request.
   - Validación automática con Terraform Plan en PR.
   - Aplicación automática tras merge a `main` (entorno protegido `prod`).

## ✅ 6. Criterios de Aceptación
- **👥 Equipos creados** en GHEC según el listado de core teams con jerarquía definida.
- **📦 Repos de plantillas creados** con configuración y permisos correctos.
- **🛡️ Rulesets y checks aplicados** en todos los repos de plantillas.
- **🚀 CI/CD de Terraform configurado** para planificar en PR y aplicar en merge.
- **📚 Documentación de uso** completa en `README.md`.
- **🧪 Testing implementado** con cobertura ≥80% de recursos.
- **📊 Monitoreo activo** con alertas configuradas para drift detection.
- **🔒 Security scanning** integrado en el pipeline de CI/CD.
- **⚡ Performance**: Tiempo de apply <3 minutos para cambios incrementales.

## ⚠️ 7. Restricciones
- Uso de Terraform CLI ≥ 1.6 y provider GitHub ≥ 6.0.
- Backend de estado remoto (Terraform Cloud o S3+DynamoDB).
- Visibilidad de repos: **privada** por defecto.
- Mantenimiento de sincronía entre código y estado real (evitar cambios manuales).
- **🏗️ Arquitectura Well-Architected**: Seguir los principios del [HashiCorp Well-Architected Framework](https://developer.hashicorp.com/well-architected-framework).
- **📚 Best Practices**: Adherirse a las [buenas prácticas de Terraform](https://developer.hashicorp.com/terraform/plugin/best-practices/hashicorp-provider-design-principles).
- **📖 Provider Documentation**: Usar como referencia la [documentación oficial del provider de GitHub](https://registry.terraform.io/providers/integrations/github/latest/docs).

## 🧪 7.1. Estrategia de Testing
- **🔍 Testing Framework**: Implementar tests siguiendo la [guía de testing de Terraform](https://developer.hashicorp.com/terraform/plugin/testing).
- **✅ Unit Tests**: Tests unitarios para validar configuraciones individuales.
- **🔗 Integration Tests**: Tests de integración para validar la interacción entre recursos.
- **📊 Plan Tests**: Validación automática de `terraform plan` en PRs.
- **🔄 Drift Detection**: Tests periódicos para detectar cambios manuales no controlados.
- **🎯 Acceptance Tests**: Tests de aceptación para validar el comportamiento end-to-end.

## 🔗 8. Dependencias
- Organización GitHub Enterprise Cloud configurada y con permisos de API para el token/APP usado por Terraform.
- Repositorio de Backstage configurado para consumir las plantillas creadas.
- Equipos core existentes o gestionados por este mismo repo.

## 📈 9. Métricas de Éxito
- **🎯 100%** de equipos core gestionados por Terraform.
- **📦 100%** de repos de plantillas gestionados por Terraform.
- **⚡ <5 minutos**: Tiempo de creación/modificación tras merge a `main`.
- **🔍 Zero drift**: Cero cambios manuales detectados en auditorías mensuales.
- **📊 >95%** de uptime del pipeline de CI/CD.
- **🧪 >80%** de cobertura de tests para recursos Terraform.
- **🚀 <3 minutos**: Tiempo promedio de ejecución de `terraform apply`.
- **📝 100%** de PRs con plan de Terraform visible antes del merge.

## ⚡ 10. Riesgos y Mitigaciones
- **🔄 Drift** entre código y estado → mitigado con ejecución periódica de `terraform plan` y alertas.
- **🔐 Permisos incorrectos** → revisiones obligatorias por `platform-team` y `security`.
- **❌ Fallo en apply** → usar entornos protegidos y rollback a última versión estable.
- **🚨 Exposición de secretos** → usar variables de entorno y secrets de GitHub Actions.
- **📉 Performance degradation** → monitoreo de tiempo de ejecución de workflows.
- **🔒 Rate limiting de GitHub API** → implementar retry logic y manejo de errores.
- **🔧 Cambios breaking en provider** → versionado estricto y testing en entorno de desarrollo.

## 📊 10.1. Monitoreo y Observabilidad
- **🔍 Drift Detection**: Workflow diario para detectar cambios no controlados mediante `terraform plan`.
- **📈 Métricas de Performance**: Monitoreo de tiempo de ejecución de workflows y operaciones.
- **🚨 Alertas**: Notificaciones automáticas en caso de fallos o drift detectado.
- **📝 Logging**: Logs detallados de todas las operaciones de Terraform.
- **📊 Dashboards**: Panel de control para visualizar el estado de la infraestructura.
- **🔄 Health Checks**: Validaciones periódicas del estado de repos y equipos.

---

## 📖 11. Historias de Usuario

### 👑 HU1 — Crear equipo padre "canary-trips"
**Como** miembro del platform team  
**Quiero** crear un equipo padre `canary-trips`  
**Para** agrupar bajo él todos los equipos relacionados con la plataforma.

**Criterios de aceptación:**
- El equipo `canary-trips` existe en GHEC.
- Es de tipo privado (`privacy=closed`).
- Tiene como mínimo un maintainer asignado.

---

### 👥 HU2 — Crear equipos core bajo el padre
**Como** miembro del platform team  
**Quiero** crear los equipos `platform-team`, `template-approvers`, `security`, `read-only` bajo `canary-trips`  
**Para** estructurar responsabilidades y permisos.

**Criterios de aceptación:**
- Equipos creados con `parent_team=canary-trips`.
- Mantainers y miembros asignados según especificaciones.
- Visibilidad `closed`.

---

### 📦 HU3 — Crear repos de plantillas de Backstage
**Como** miembro del platform team  
**Quiero** tener repos preconfigurados para las plantillas de Backstage  
**Para** que los desarrolladores puedan generar nuevos servicios desde el IDP.

**Criterios de aceptación:**
- Repos creados en privado con `auto_init=true`.
- Descripción y topics configurados.
- Asignación de permisos correcta para equipos.
- Ruleset en `main` con:
  - 1 review mínima.
  - CODEOWNERS en `skeleton/` y `template.yaml`.
  - Checks `ci-template`, `lint`, `docs-build`, `codeql`.
  - `block_force_pushes=true`.

---

### 🆕 HU4 — Añadir plantillas para .NET y Astro
**Como** miembro del platform team  
**Quiero** que existan plantillas `backstage-template-dotnet-service` y `backstage-template-astro-frontend`  
**Para** dar soporte a servicios en .NET y frontends Astro.

**Criterios de aceptación:**
- Repos creados y configurados igual que otras plantillas.
- Cada skeleton incluye:
  - `template.yaml`
  - Código base del stack correspondiente.
  - `catalog-info.yaml`, `docs/`, `.github/copilot-instructions.md`.
  - `.vscode/prompts/` con prompts específicos por stack.
- CI configurado para lint, test y build de cada stack.

---

### 🚀 HU5 — Pipeline de Terraform con validación y despliegue
**Como** administrador del repositorio  
**Quiero** que exista un workflow de GitHub Actions para `terraform plan` y `terraform apply`  
**Para** validar cambios en PR y aplicarlos automáticamente tras merge.

**Criterios de aceptación:**
- Workflow ejecuta `terraform fmt`, `validate` y `plan` en PR.
- Workflow ejecuta `apply` solo en `main` y en entorno protegido.
- Logs y artefactos de `plan` accesibles desde el PR.
- **🔒 Security scanning**: Integración con herramientas de seguridad como `tfsec` o `checkov`.
- **📊 Cost estimation**: Estimación de costos cuando sea aplicable.
- **🔄 Rollback capability**: Capacidad de rollback en caso de fallos.
- **🎯 Terraform validation**: Validación de sintaxis y configuración.
- **📝 Plan summary**: Resumen claro de cambios en el PR como comentario.

---

### 📚 HU6 — Documentación de uso
**Como** usuario de la plataforma  
**Quiero** tener un README claro en el repo  
**Para** entender cómo añadir/editar equipos o repos de plantillas.

**Criterios de aceptación:**
- `README.md` explica:
  - Estructura del repo.
  - Cómo añadir un equipo.
  - Cómo añadir un repo de plantilla.
  - Cómo ejecutar Terraform localmente.
  - Flujo de PR y apply.

---

## 🛠️ 11.1. Troubleshooting y Resolución de Problemas

### 🚨 Problemas Comunes
- **💥 Terraform Plan Fails**: 
  - Verificar permisos del token de GitHub
  - Revisar sintaxis de configuración
  - Validar que los recursos no existan previamente
  
- **🔄 State Lock Issues**:
  - Verificar que no hay otra operación en curso
  - Liberar lock manualmente si es necesario: `terraform force-unlock`
  
- **📋 GitHub API Rate Limits**:
  - Implementar delays entre operaciones
  - Usar GitHub App en lugar de PAT para mayores límites
  
- **🔐 Permission Denied**:
  - Verificar scopes del token de GitHub
  - Confirmar permisos de organización
  
### 🩺 Comandos de Diagnóstico
```bash
# Verificar configuración
terraform validate

# Revisar plan sin aplicar
terraform plan -detailed-exitcode

# Debug mode para más información
TF_LOG=DEBUG terraform plan

# Verificar estado actual
terraform show

# Importar recursos existentes si es necesario
terraform import github_team.example team-name
```

---

## 📊 12. Backlog en formato tabla

| ID   | Título                                                   | Como...                           | Quiero...                                                                                       | Para...                                                              | Criterios de aceptación                                                                                                                                                                                                                                                                                                                                                                                                                 | Prioridad | Esfuerzo estimado | Etiquetas                      |
|------|----------------------------------------------------------|------------------------------------|-------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|-------------------|---------------------------------|
| HU1  | Crear equipo padre "canary-trips"                         | miembro del platform team          | crear un equipo padre `canary-trips`                                                            | agrupar bajo él todos los equipos relacionados con la plataforma     | - El equipo `canary-trips` existe en GHEC.<br>- Es de tipo privado (`privacy=closed`).<br>- Tiene como mínimo un maintainer asignado.                                                                                                                                                                                                                                                                                                  | Alta      | 2                 | equipos, terraform, ghec        |
| HU2  | Crear equipos core bajo el padre                         | miembro del platform team          | crear los equipos `platform-team`, `template-approvers`, `security`, `read-only` bajo `canary-trips` | estructurar responsabilidades y permisos                             | - Equipos creados con `parent_team=canary-trips`.<br>- Mantainers y miembros asignados según especificaciones.<br>- Visibilidad `closed`.                                                                                                                                                                                                                                                                                               | Alta      | 3                 | equipos, terraform, ghec        |
| HU3  | Crear repos de plantillas de Backstage                   | miembro del platform team          | tener repos preconfigurados para las plantillas de Backstage                                    | que los desarrolladores puedan generar nuevos servicios desde el IDP | - Repos creados en privado con `auto_init=true`.<br>- Descripción y topics configurados.<br>- Asignación de permisos correcta para equipos.<br>- Ruleset en `main` con:<br>  • 1 review mínima.<br>  • CODEOWNERS en `skeleton/` y `template.yaml`.<br>  • Checks `ci-template`, `lint`, `docs-build`, `codeql`.<br>  • `block_force_pushes=true`.                                                                                                | Alta      | 5                 | repos, plantillas, backstage    |
| HU4  | Añadir plantillas para .NET y Astro                      | miembro del platform team          | que existan plantillas `backstage-template-dotnet-service` y `backstage-template-astro-frontend` | dar soporte a servicios en .NET y frontends Astro                     | - Repos creados y configurados igual que otras plantillas.<br>- Cada skeleton incluye:<br>  • `template.yaml`<br>  • Código base del stack correspondiente.<br>  • `catalog-info.yaml`, `docs/`, `.github/copilot-instructions.md`.<br>  • `.vscode/prompts/` con prompts específicos por stack.<br>- CI configurado para lint, test y build de cada stack.                                                                                                                       | Alta      | 5                 | repos, plantillas, dotnet, astro|
| HU5  | Pipeline de Terraform con validación y despliegue        | administrador del repositorio      | que exista un workflow de GitHub Actions para `terraform plan` y `terraform apply`               | validar cambios en PR y aplicarlos automáticamente tras merge        | - Workflow ejecuta `terraform fmt`, `validate` y `plan` en PR.<br>- Workflow ejecuta `apply` solo en `main` y en entorno protegido.<br>- Logs y artefactos de `plan` accesibles desde el PR.                                                                                                                                                                                                                                               | Alta      | 3                 | terraform, cicd, github-actions |
| HU6  | Documentación de uso                                     | usuario de la plataforma           | tener un README claro en el repo                                                                | entender cómo añadir/editar equipos o repos de plantillas             | - `README.md` explica:<br>  • Estructura del repo.<br>  • Cómo añadir un equipo.<br>  • Cómo añadir un repo de plantilla.<br>  • Cómo ejecutar Terraform localmente.<br>  • Flujo de PR y apply.                                                                                                                                                                                                                                           | Media     | 2                 | documentación, onboarding       |

---

## 📚 13. Referencias y Recursos Adicionales

### 🔗 Enlaces Útiles
- **📖 [Documentación del Provider de GitHub](https://registry.terraform.io/providers/integrations/github/latest/docs)**: Referencia completa de recursos y data sources disponibles.
- **⚡ [Buenas Prácticas de Terraform](https://developer.hashicorp.com/terraform/plugin/best-practices/hashicorp-provider-design-principles)**: Principios de diseño y mejores prácticas.
- **🧪 [Testing en Terraform](https://developer.hashicorp.com/terraform/plugin/testing)**: Guía completa para implementar tests.
- **🏗️ [Well-Architected Framework](https://developer.hashicorp.com/well-architected-framework)**: Principios arquitectónicos de HashiCorp.

### 📖 Lecturas Recomendadas
- **🔐 Security Best Practices**: Configuración segura de tokens y permisos.
- **📊 State Management**: Mejores prácticas para manejo de estado remoto.
- **🔄 CI/CD Patterns**: Patrones comunes para pipelines de infraestructura.
- **🎯 GitHub Enterprise Best Practices**: Configuración óptima de organizaciones GHEC.

### 🛠️ Herramientas Complementarias
- **`tfsec`**: Análisis estático de seguridad para Terraform.
- **`checkov`**: Scanner de configuración para detectar problemas de seguridad.
- **`terraform-docs`**: Generación automática de documentación.
- **`pre-commit`**: Hooks para validación automática antes de commits.
