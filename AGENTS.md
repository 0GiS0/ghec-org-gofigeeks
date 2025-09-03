# AGENTS.md

## Descripción del proyecto

Este repositorio gestiona la configuración de una organización de GitHub Enterprise Cloud (GHEC) como código usando Terraform. Crea equipos, repositorios plantilla, protecciones de rama y configura el acceso a Codespaces de la organización.

## Comandos de configuración

- Inicializar Terraform: `terraform init`
- Formatear código: `terraform fmt`
- Validar configuración: `terraform validate`
- Planificar cambios: `terraform plan`
- Aplicar cambios: `terraform apply`
- Destruir recursos: `terraform destroy`

## Estructura del proyecto

- `main.tf` - Configuración principal de Terraform
- `variables.tf` - Definición de variables
- `outputs.tf` - Valores de salida
- `terraform.tf` - Configuración de providers y backend
- `repositories.tf` - Gestión de repositorios
- `teams.tf` - Gestión de equipos
- `codespaces.tf` - Configuración de Codespaces
- `custom_properties.tf` - Gestión de custom properties organizacionales
- `scripts/terraform-integration/` - Scripts para integraciones avanzadas con GitHub API
- `scripts/repo-tools/` - Herramientas de mantenimiento y validación del repositorio
- `templates/` - Plantillas para repositorios y workflows
- `terraform.tfvars.example` - Archivo de ejemplo para variables

## Estilo de código

- Usar Terraform >= 1.6
- Provider de GitHub >= 6.0
- Usar indentación de 2 espacios
- Comentarios en español para documentación
- Variables sensibles marcadas con `sensitive = true`
- Validaciones en variables cuando sea apropiado

### Código Python en plantillas

- Todo código Python en archivos `.py.tpl` debe seguir el formato estándar de **black**
- Ejecutar `./scripts/repo-tools/check-python-format.sh` para verificar el formato
- Ejecutar `./scripts/repo-tools/format-python.sh` para aplicar formato automáticamente
- La verificación de formato es **obligatoria** antes de cualquier commit que modifique archivos Python

## Integraciones mediante Scripts

### Patrón para funcionalidades no soportadas por Terraform

Para funcionalidades de GitHub que no están completamente soportadas por el provider de Terraform, implementamos un patrón estándar de integración mediante scripts bash.

#### Estructura del patrón

1. **Script bash** en `scripts/terraform-integration/` que interactúa con GitHub REST API
2. **Recurso `null_resource`** que ejecuta el script con variables de entorno
3. **Validación y logging** detallado para troubleshooting
4. **Manejo de errores** configurable

#### Implementación: Custom Properties

Las custom properties organizacionales requieren este patrón porque:
- El provider de Terraform no soporta crear definiciones organizacionales
- Solo permite asignar valores a repositorios (requiere definiciones previas)
- La API REST permite gestión completa de definiciones y valores

```bash
# scripts/terraform-integration/custom_property.sh
#!/usr/bin/env bash
set -eo pipefail

# Variables de entorno requeridas:
# ORG_NAME, PROPERTY_NAME, PROPERTY_PAYLOAD
# APP_ID, INSTALLATION_ID, PEM_FILE

# Obtener token de GitHub App
GITHUB_TOKEN=$(APP_ID="$APP_ID" INSTALLATION_ID="$INSTALLATION_ID" PEM_FILE="$PEM_FILE" ./scripts/terraform-integration/github_app_token.sh)

# Usar PUT para crear/actualizar propiedad individual
curl -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/orgs/$ORG_NAME/properties/schema/$PROPERTY_NAME" \
  -d "$PROPERTY_DEF"
```

#### Configuración en Terraform

```hcl
resource "null_resource" "org_custom_properties" {
  for_each = var.enable_custom_properties ? var.organization_custom_properties : {}

  triggers = {
    org      = var.github_organization
    payload  = local.custom_properties_payloads[each.key]
    property = each.key
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "scripts/terraform-integration/custom_property.sh"
    environment = {
      ORG_NAME         = var.github_organization
      PROPERTY_NAME    = each.key
      PROPERTY_PAYLOAD = local.custom_properties_payloads[each.key]
      APP_ID           = var.github_app_id
      INSTALLATION_ID  = var.github_app_installation_id
      PEM_FILE         = abspath(var.github_app_pem_file)
      LOG_FILE         = "/tmp/custom-properties-${each.key}.log"
      NON_FATAL_404    = var.custom_properties_non_fatal_404 ? "true" : "false"
    }
  }
}
```

### Mejores prácticas para scripts

1. **Manejo de errores robusto**
   ```bash
   set -eo pipefail  # Salir en cualquier error
   ```

2. **Logging detallado**
   ```bash
   LOG_FILE="${LOG_FILE:-/tmp/script-${PROPERTY_NAME}.log}"
   echo "$(date -Is) STEP operation-name" >> "$LOG_FILE"
   ```

3. **Validación de entrada**
   ```bash
   if [ -z "${ORG_NAME:-}" ]; then
     echo "ERROR: ORG_NAME es requerido" >&2
     exit 1
   fi
   ```

4. **Tokens seguros**
   ```bash
   # Usar GitHub App en lugar de PAT
   GITHUB_TOKEN=$(./scripts/terraform-integration/github_app_token.sh)
   ```

5. **Payload processing**
   ```bash
   # Extraer solo campos necesarios del JSON
   PROPERTY_DEF=$(echo "$PAYLOAD" | jq 'del(.property_name)')
   ```

### Scripts de formato de código Python

El proyecto incluye scripts automatizados para mantener la calidad del código Python:

#### `scripts/repo-tools/check-python-format.sh`
Verifica que todos los archivos `.py.tpl` sigan el formato estándar de black.

```bash
# Uso básico
./scripts/repo-tools/check-python-format.sh

# Con log personalizado
LOG_FILE="/tmp/mi-verificacion.log" ./scripts/repo-tools/check-python-format.sh
```

**Características:**
- Detecta automáticamente todos los archivos `.py.tpl` en `templates/`
- Genera logs detallados con timestamps
- Código de salida 0 si todo está correcto, 1 si hay errores
- Proporciona comandos para corregir errores

#### `scripts/repo-tools/format-python.sh`
Aplica automáticamente el formato black a todos los archivos `.py.tpl`.

```bash
# Aplicar formato a todos los archivos
./scripts/repo-tools/format-python.sh

# Con log personalizado
LOG_FILE="/tmp/mi-formato.log" ./scripts/repo-tools/format-python.sh
```

**Características:**
- Modifica directamente los archivos para aplicar el formato
- Preserva los placeholders de Backstage y Terraform
- Genera logs de cada archivo procesado
- Operación idempotente (seguro ejecutar múltiples veces)

**Flujo de trabajo recomendado:**
```bash
# 1. Verificar estado actual
./scripts/repo-tools/check-python-format.sh

# 2. Si hay errores, aplicar formato
./scripts/repo-tools/format-python.sh

# 3. Verificar que todo esté correcto
./scripts/repo-tools/check-python-format.sh
```

#### Testing de scripts

```bash
# Test manual del script
cd /workspaces/ghec-org-as-code

# Cargar variables de entorno
source .env

ORG_NAME="$GITHUB_ORGANIZATION" \
PROPERTY_NAME="service-tier" \
PROPERTY_PAYLOAD='{"property_name":"service-tier","value_type":"single_select","required":true,"default_value":"tier-1","allowed_values":["tier-1","tier-2","tier-3"]}' \
APP_ID="$GITHUB_APP_ID" \
INSTALLATION_ID="$GITHUB_APP_INSTALLATION_ID" \
PEM_FILE="$GITHUB_APP_PEM_FILE" \
NON_FATAL_404="false" \
./scripts/terraform-integration/custom_property.sh
```

#### Validación post-ejecución

```bash
   # Verificar resultado via API
   curl -H "Authorization: Bearer $TOKEN" \
     "https://api.github.com/orgs/$GITHUB_ORGANIZATION/properties/schema" | jq .# Revisar logs
cat /tmp/custom-properties-service-tier.log
```

---

## Instrucciones de testing

### Testing general
- Ejecutar `terraform fmt -check` para verificar formato
- Ejecutar `terraform validate` para validar sintaxis
- Ejecutar `terraform plan` antes de aplicar cambios
- Verificar que el archivo PEM de la GitHub App existe y es legible
- Confirmar que los usuarios listados en las variables son miembros de la organización

### Testing de código Python

**OBLIGATORIO** antes de cualquier commit que modifique archivos `.py.tpl`:

1. **Verificar formato con black**
   ```bash
   ./scripts/repo-tools/check-python-format.sh
   ```

2. **Aplicar formato automáticamente (si es necesario)**
   ```bash
   ./scripts/repo-tools/format-python.sh
   ```

3. **Verificar nuevamente el formato**
   ```bash
   ./scripts/repo-tools/check-python-format.sh
   ```

Los archivos Python verificados incluyen:
- `templates/skeletons/ai-assistant/src/main.py.tpl`
- `templates/skeletons/fastapi-service/app/**/*.py.tpl`
- `templates/skeletons/fastapi-service/tests/**/*.py.tpl`
- `templates/skeletons/env-live/validate_config.py.tpl`

**Nota**: Los scripts automáticamente detectan todos los archivos `.py.tpl` en el directorio `templates/`

### Testing de Custom Properties

1. **Verificar API organizacional**
   ```bash
   # Cargar variables de entorno
   source .env
   
   # Listar propiedades existentes
   curl -H "Authorization: Bearer $TOKEN" \
     "https://api.github.com/orgs/$GITHUB_ORGANIZATION/properties/schema" | jq .
   ```

2. **Verificar aplicación a repositorios**
   ```bash
   # Listar valores aplicados a repositorios
   curl -H "Authorization: Bearer $TOKEN" \
     "https://api.github.com/orgs/$GITHUB_ORGANIZATION/properties/values" | jq .
   ```

3. **Testing de scripts individuales**
   ```bash
   # Test de creación de propiedad
   source .env
   ORG_NAME="$GITHUB_ORGANIZATION" \
   PROPERTY_NAME="test-property" \
   PROPERTY_PAYLOAD='{"value_type":"string","required":false,"description":"Test property"}' \
   ./scripts/terraform-integration/custom_property.sh
   ```

4. **Validación de logs**
   ```bash
   # Revisar logs de ejecución
   tail -f /tmp/custom-properties-*.log
   ```

### Testing de integración completa

```bash
# 1. Plan para ver cambios
terraform plan -target=null_resource.org_custom_properties

# 2. Apply solo custom properties
terraform apply -target=null_resource.org_custom_properties -auto-approve

# 3. Verificar en GitHub API
source .env
curl -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/orgs/$GITHUB_ORGANIZATION/properties/schema"

# 4. Apply propiedades a repositorios
terraform apply -auto-approve

# 5. Verificar aplicación final
curl -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/orgs/$GITHUB_ORGANIZATION/properties/values"
```

## Configuración de desarrollo

### Variables de entorno

1. **Copiar archivo de configuración de ejemplo**:
   ```bash
   cp .env.sample .env
   ```

2. **Editar .env con tus credenciales**:
   ```bash
   nano .env
   ```

3. **Configurar las variables requeridas**:
   - `GITHUB_ORGANIZATION` - Nombre de tu organización GitHub
   - `GITHUB_APP_ID` - ID de tu GitHub App
   - `GITHUB_APP_INSTALLATION_ID` - ID de instalación de la app
   - `GITHUB_APP_PEM_FILE` - Ruta al archivo PEM de la GitHub App

4. **Cargar variables de entorno**:
   ```bash
   source scripts/load-env.sh
   ```

### Terraform

1. Las variables se pueden cargar automáticamente desde .env usando el prefijo `TF_VAR_`
2. Alternativamente, usar `terraform.tfvars` para configuración específica
3. Asegurar que el archivo PEM tenga permisos 600
4. Verificar que la GitHub App tenga los permisos necesarios

## Consideraciones de seguridad

- El archivo PEM debe tener permisos restrictivos (600)
- Usar rutas absolutas para el archivo PEM
- Las variables sensibles están marcadas como `sensitive = true`
- La GitHub App debe tener permisos mínimos necesarios
- No commitear archivos `terraform.tfvars` con datos reales

## Solución de problemas

- Error "Resource not accessible by integration": Verificar permisos de la GitHub App
- Error de Codespaces: Revisar `/tmp/codespaces-org-access.log`
- Error de archivo PEM: Verificar que existe y es legible
- Error 422 EMU: Los usuarios deben ser miembros de la organización antes de ser asignados a equipos

## Instrucciones de PR

- Título: `[GHEC] <Descripción del cambio>`
- Siempre ejecutar `terraform fmt` y `terraform validate` antes de commitear
- **OBLIGATORIO**: Si se modifican archivos `.py.tpl`, ejecutar `./scripts/repo-tools/check-python-format.sh`
- Incluir descripción detallada de los cambios en el PR
- Verificar que no se incluyan archivos sensibles en el commit
- Actualizar documentación si se añaden nuevas variables o funcionalidades

### Checklist de PR para cambios en código Python

Al modificar archivos `.py.tpl`, verificar:

- [ ] `./scripts/repo-tools/check-python-format.sh` ejecutado sin errores
- [ ] Si había errores de formato, ejecutado `./scripts/repo-tools/format-python.sh`
- [ ] Verificación final con `./scripts/repo-tools/check-python-format.sh` exitosa
- [ ] Todos los archivos Python siguen el formato estándar de black

## Gestión de estado

- Configurar backend remoto en `terraform.tf` para entornos de producción
- Usar workspaces de Terraform para diferentes entornos si es necesario
- Hacer backup del estado antes de cambios importantes
- No modificar manualmente el archivo de estado

## Plantillas y workflows

- Las plantillas están en `templates/` y se usan para crear repositorios
- Los workflows de CI/CD se generan automáticamente
- Modificar plantillas requiere actualizar la configuración de repositorios
- Verificar que `manage_workflow_files` esté configurado correctamente

### Plantillas para Backstage

Las plantillas en el directorio `templates/` están diseñadas para ser utilizadas por **Backstage** como templates de software. Backstage es una plataforma de desarrollador que permite crear nuevos proyectos desde plantillas predefinidas.

#### Manejo de placeholders mixtos (Terraform + Backstage)

Cuando un archivo necesita placeholders tanto para Terraform como para Backstage, se debe usar la siguiente estrategia:

##### Archivos procesados por Terraform (`templatefile()`)

Para archivos como `catalog-info.yaml.tpl` que son procesados por Terraform:

- **Placeholders de Terraform**: `${variable_name}` (una sola $)
- **Placeholders de Backstage**: `$${{parameters.nombreVariable}}` (doble $)
  - Terraform convierte `$$` en `$` literal
  - El resultado final será `${{parameters.nombreVariable}}` que Backstage puede procesar

```yaml
# En catalog-info.yaml.tpl (procesado por Terraform)
metadata:
  name: ${template_name}                    # Terraform placeholder
  title: ${template_title}                  # Terraform placeholder
  description: ${template_description}      # Terraform placeholder
  values:
    name: $${{parameters.name}}             # Backstage placeholder (doble $)
    owner: $${{parameters.owner}}           # Backstage placeholder (doble $)
```

##### Archivos copiados directamente (`file()`)

Para archivos en `skeletons/` que se copian tal cual:

- **Placeholders de Backstage**: `${{values.nombreVariable}}` (una sola $)
- **No hay placeholders de Terraform** en estos archivos

```json
// En package.json.tpl (copiado con file())
{
  "name": "${{values.name}}",              // Backstage placeholder (una $)
  "description": "${{values.description}}" // Backstage placeholder (una $)
}
```

#### Formato correcto de placeholders

- **Terraform**: `${variable_name}`
- **Backstage en archivos procesados por Terraform**: `$${{parameters.nombreVariable}}`
- **Backstage en archivos copiados directamente**: `${{values.nombreVariable}}`

#### Ejemplo de uso en Backstage

```yaml
# En el template.yaml de Backstage
parameters:
  - name: projectName
    type: string
    description: Nombre del proyecto
  - name: description
    type: string
    description: Descripción del proyecto
```

```markdown
<!-- En un archivo README.md de la plantilla (skeleton) -->
# ${{values.projectName}}

${{values.description}}

Este proyecto fue creado desde la plantilla de Backstage.
```
