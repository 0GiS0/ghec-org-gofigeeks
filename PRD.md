# PRD — Gestión de Equipos y Repos de Plantillas Backstage en GHEC

## 1. Propósito
Definir los requisitos para un repositorio que gestione mediante **Infrastructure as Code**:
1. La **creación y configuración de equipos** en la organización de GitHub Enterprise Cloud (GHEC).
2. La **creación y configuración de repositorios de plantillas** para Backstage.

Este repositorio permitirá que la configuración de equipos y plantillas sea **trazable, auditable y replicable**, eliminando cambios manuales y manteniendo un estado coherente con el diseño de la plataforma.

## 2. Alcance
### In Scope
- Creación y gestión de equipos y jerarquías en GHEC.
- Creación y configuración de repositorios de plantillas para Backstage:
  - Configuración inicial (descripción, temas, visibilidad, branch principal).
  - Reglas de calidad (branch protection, checks obligatorios, CODEOWNERS).
  - Asignación de permisos por equipo.
- Gestión de permisos **Team → Repo** para las plantillas.
- Checks obligatorios en cada plantilla (CI, lint, build de docs, CodeQL).

### Out of Scope
- Creación de repositorios de servicios/producto (se harán on-demand mediante el IDP de Backstage).
- Gestión de políticas globales de la organización (p. ej., allowed actions, default repo permissions), que se tratarán en otro repositorio.
- Gestión de usuarios fuera del ámbito de asignación a equipos.

## 3. Stakeholders
- **Platform Team**: propietarios del repositorio, definición de estándares y aprobación de cambios.
- **Template Approvers**: responsables de validar cambios en las plantillas.
- **Security Team**: revisores de reglas y alertas de seguridad.
- **Read-only Users**: acceso de lectura para revisión o auditoría.

## 4. Objetivos y Motivación
- **Estandarizar** la creación y mantenimiento de equipos y plantillas.
- **Automatizar** la configuración para reducir errores humanos.
- **Controlar calidad** con reglas y checks predefinidos.
- **Facilitar el onboarding** de nuevos equipos y plantillas en Backstage.

## 5. Funcionalidades Requeridas
1. **Gestión de equipos**:
   - Creación de equipos core:
     - `canary-trips` (padre)
     - `platform-team`
     - `template-approvers`
     - `security`
     - `read-only`
   - Definición de jerarquía (`parent_team`).
   - Asignación de maintainers y miembros.

2. **Gestión de repositorios de plantillas**:
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

3. **Trazabilidad y cambios controlados**:
   - Todo cambio se hará mediante Pull Request.
   - Validación automática con Terraform Plan en PR.
   - Aplicación automática tras merge a `main` (entorno protegido `prod`).

## 6. Criterios de Aceptación
- **Equipos creados** en GHEC según el listado de core teams con jerarquía definida.
- **Repos de plantillas creados** con configuración y permisos correctos.
- Rulesets y checks aplicados en todos los repos de plantillas.
- CI/CD de Terraform configurado para planificar en PR y aplicar en merge.
- Documentación de uso en `README.md`.

## 7. Restricciones
- Uso de Terraform CLI ≥ 1.6 y provider GitHub ≥ 6.0.
- Backend de estado remoto (Terraform Cloud o S3+DynamoDB).
- Visibilidad de repos: **privada** por defecto.
- Mantenimiento de sincronía entre código y estado real (evitar cambios manuales).

## 8. Dependencias
- Organización GitHub Enterprise Cloud configurada y con permisos de API para el token/APP usado por Terraform.
- Repositorio de Backstage configurado para consumir las plantillas creadas.
- Equipos core existentes o gestionados por este mismo repo.

## 9. Métricas de Éxito
- 100% de equipos core gestionados por Terraform.
- 100% de repos de plantillas gestionados por Terraform.
- Creación/modificación de un repo de plantilla o equipo lista en <5 minutos tras merge a `main`.
- Cero cambios manuales detectados fuera de Terraform en auditorías mensuales.

## 10. Riesgos y Mitigaciones
- **Drift** entre código y estado → mitigado con ejecución periódica de `terraform plan` y alertas.
- **Permisos incorrectos** → revisiones obligatorias por `platform-team` y `security`.
- **Fallo en apply** → usar entornos protegidos y rollback a última versión estable.

---

## 11. Historias de Usuario

### HU1 — Crear equipo padre "canary-trips"
**Como** miembro del platform team  
**Quiero** crear un equipo padre `canary-trips`  
**Para** agrupar bajo él todos los equipos relacionados con la plataforma.

**Criterios de aceptación:**
- El equipo `canary-trips` existe en GHEC.
- Es de tipo privado (`privacy=closed`).
- Tiene como mínimo un maintainer asignado.

---

### HU2 — Crear equipos core bajo el padre
**Como** miembro del platform team  
**Quiero** crear los equipos `platform-team`, `template-approvers`, `security`, `read-only` bajo `canary-trips`  
**Para** estructurar responsabilidades y permisos.

**Criterios de aceptación:**
- Equipos creados con `parent_team=canary-trips`.
- Mantainers y miembros asignados según especificaciones.
- Visibilidad `closed`.

---

### HU3 — Crear repos de plantillas de Backstage
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

### HU4 — Añadir plantillas para .NET y Astro
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

### HU5 — Pipeline de Terraform con validación y despliegue
**Como** administrador del repositorio  
**Quiero** que exista un workflow de GitHub Actions para `terraform plan` y `terraform apply`  
**Para** validar cambios en PR y aplicarlos automáticamente tras merge.

**Criterios de aceptación:**
- Workflow ejecuta `terraform fmt`, `validate` y `plan` en PR.
- Workflow ejecuta `apply` solo en `main` y en entorno protegido.
- Logs y artefactos de `plan` accesibles desde el PR.

---

### HU6 — Documentación de uso
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

## 12. Backlog en formato tabla

| ID   | Título                                                   | Como...                           | Quiero...                                                                                       | Para...                                                              | Criterios de aceptación                                                                                                                                                                                                                                                                                                                                                                                                                 | Prioridad | Esfuerzo estimado | Etiquetas                      |
|------|----------------------------------------------------------|------------------------------------|-------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|-------------------|---------------------------------|
| HU1  | Crear equipo padre "canary-trips"                         | miembro del platform team          | crear un equipo padre `canary-trips`                                                            | agrupar bajo él todos los equipos relacionados con la plataforma     | - El equipo `canary-trips` existe en GHEC.<br>- Es de tipo privado (`privacy=closed`).<br>- Tiene como mínimo un maintainer asignado.                                                                                                                                                                                                                                                                                                  | Alta      | 2                 | equipos, terraform, ghec        |
| HU2  | Crear equipos core bajo el padre                         | miembro del platform team          | crear los equipos `platform-team`, `template-approvers`, `security`, `read-only` bajo `canary-trips` | estructurar responsabilidades y permisos                             | - Equipos creados con `parent_team=canary-trips`.<br>- Mantainers y miembros asignados según especificaciones.<br>- Visibilidad `closed`.                                                                                                                                                                                                                                                                                               | Alta      | 3                 | equipos, terraform, ghec        |
| HU3  | Crear repos de plantillas de Backstage                   | miembro del platform team          | tener repos preconfigurados para las plantillas de Backstage                                    | que los desarrolladores puedan generar nuevos servicios desde el IDP | - Repos creados en privado con `auto_init=true`.<br>- Descripción y topics configurados.<br>- Asignación de permisos correcta para equipos.<br>- Ruleset en `main` con:<br>  • 1 review mínima.<br>  • CODEOWNERS en `skeleton/` y `template.yaml`.<br>  • Checks `ci-template`, `lint`, `docs-build`, `codeql`.<br>  • `block_force_pushes=true`.                                                                                                | Alta      | 5                 | repos, plantillas, backstage    |
| HU4  | Añadir plantillas para .NET y Astro                      | miembro del platform team          | que existan plantillas `backstage-template-dotnet-service` y `backstage-template-astro-frontend` | dar soporte a servicios en .NET y frontends Astro                     | - Repos creados y configurados igual que otras plantillas.<br>- Cada skeleton incluye:<br>  • `template.yaml`<br>  • Código base del stack correspondiente.<br>  • `catalog-info.yaml`, `docs/`, `.github/copilot-instructions.md`.<br>  • `.vscode/prompts/` con prompts específicos por stack.<br>- CI configurado para lint, test y build de cada stack.                                                                                                                       | Alta      | 5                 | repos, plantillas, dotnet, astro|
| HU5  | Pipeline de Terraform con validación y despliegue        | administrador del repositorio      | que exista un workflow de GitHub Actions para `terraform plan` y `terraform apply`               | validar cambios en PR y aplicarlos automáticamente tras merge        | - Workflow ejecuta `terraform fmt`, `validate` y `plan` en PR.<br>- Workflow ejecuta `apply` solo en `main` y en entorno protegido.<br>- Logs y artefactos de `plan` accesibles desde el PR.                                                                                                                                                                                                                                               | Alta      | 3                 | terraform, cicd, github-actions |
| HU6  | Documentación de uso                                     | usuario de la plataforma           | tener un README claro en el repo                                                                | entender cómo añadir/editar equipos o repos de plantillas             | - `README.md` explica:<br>  • Estructura del repo.<br>  • Cómo añadir un equipo.<br>  • Cómo añadir un repo de plantilla.<br>  • Cómo ejecutar Terraform localmente.<br>  • Flujo de PR y apply.                                                                                                                                                                                                                                           | Media     | 2                 | documentación, onboarding       |
