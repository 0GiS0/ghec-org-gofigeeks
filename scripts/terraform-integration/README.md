# Scripts de Integración con Terraform

Este directorio contiene scripts que extienden la funcionalidad de Terraform para trabajar con APIs de GitHub que no están completamente soportadas por el provider oficial.

## Scripts Disponibles

### `github_app_token.sh`
**Propósito**: Genera tokens de autenticación JWT usando credenciales de GitHub App.

**Uso**:
```bash
# Con variables de entorno
APP_ID="123456" \
INSTALLATION_ID="789012" \
PEM_FILE="/path/to/app.pem" \
./github_app_token.sh

# El token se imprime a stdout para usar en otros scripts
TOKEN=$(./github_app_token.sh)
```

**Variables de entorno requeridas**:
- `APP_ID`: ID de la GitHub App
- `INSTALLATION_ID`: ID de instalación de la app en la organización
- `PEM_FILE`: Ruta al archivo de clave privada (.pem)

**Dependencias**: `openssl`, `base64`, `curl`, `jq`

### `custom_property.sh`
**Propósito**: Gestiona custom properties organizacionales a través de la GitHub API REST.

**Uso**:
```bash
# Crear/actualizar una propiedad
ORG_NAME="mi-org" \
PROPERTY_NAME="service-tier" \
PROPERTY_PAYLOAD='{"property_name":"service-tier","value_type":"single_select","required":true}' \
APP_ID="123456" \
INSTALLATION_ID="789012" \
PEM_FILE="/path/to/app.pem" \
./custom_property.sh
```

**Variables de entorno requeridas**:
- `ORG_NAME`: Nombre de la organización GitHub
- `PROPERTY_NAME`: Nombre de la propiedad a crear/actualizar
- `PROPERTY_PAYLOAD`: JSON con la definición de la propiedad
- Credenciales de GitHub App: `APP_ID`, `INSTALLATION_ID`, `PEM_FILE`

**Variables opcionales**:
- `LOG_FILE`: Ubicación del log (default: `/tmp/custom-properties-{PROPERTY_NAME}.log`)
- `NON_FATAL_404`: Si "true", errores 404 no fallan el script

### `codespaces_access.sh`
**Propósito**: Configura el acceso a Codespaces a nivel organizacional.

**Uso**:
```bash
ORG_NAME="mi-org" \
CODESPACES_ACCESS_SETTING="selected" \
SELECTED_USERS='["user1","user2"]' \
APP_ID="123456" \
INSTALLATION_ID="789012" \
PEM_FILE="/path/to/app.pem" \
./codespaces_access.sh
```

**Variables de entorno requeridas**:
- `ORG_NAME`: Nombre de la organización
- `CODESPACES_ACCESS_SETTING`: "disabled", "enabled", o "selected"
- `SELECTED_USERS`: JSON array con usuarios (solo si access_setting="selected")
- Credenciales de GitHub App

### `wait_custom_properties.sh`
**Propósito**: Script de sincronización que espera a que las custom properties estén disponibles.

**Uso**:
```bash
ORG_NAME="mi-org" \
PROPERTIES_LIST='["prop1","prop2"]' \
APP_ID="123456" \
INSTALLATION_ID="789012" \
PEM_FILE="/path/to/app.pem" \
./wait_custom_properties.sh
```

**Características**:
- Implementa retry con backoff exponencial
- Timeout configurable
- Logging detallado del proceso de espera

## Integración con Terraform

Estos scripts se ejecutan mediante recursos `null_resource` en Terraform:

```hcl
resource "null_resource" "org_custom_properties" {
  for_each = var.organization_custom_properties

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
    }
  }
}
```

## Arquitectura y Diseño

### Patrón de Scripts de Integración

1. **Entrada**: Variables de entorno bien definidas
2. **Autenticación**: Via GitHub App (más seguro que PAT)
3. **Operación**: Llamada específica a GitHub REST API
4. **Logging**: Detallado con timestamps
5. **Salida**: Código de salida 0/1 para integración con Terraform

### Manejo de Errores

- `set -eo pipefail`: Falla rápido en cualquier error
- Logs detallados para debugging
- Códigos de salida consistentes
- Opción de errores no-fatales cuando sea apropiado

### Seguridad

- Tokens JWT temporales (no PATs estáticos)
- Validación de entrada
- No exposición de secretos en logs
- Permisos mínimos necesarios en GitHub App

## Testing

### Test Individual
```bash
# Test del script de custom properties
cd /workspaces/ghec-org-as-code

# Cargar variables de entorno
source .env

ORG_NAME="$GITHUB_ORGANIZATION" \
PROPERTY_NAME="test-property" \
PROPERTY_PAYLOAD='{"value_type":"string","required":false,"description":"Test"}' \
APP_ID="$GITHUB_APP_ID" \
INSTALLATION_ID="$GITHUB_APP_INSTALLATION_ID" \
PEM_FILE="$GITHUB_APP_PEM_FILE" \
NON_FATAL_404="false" \
./scripts/terraform-integration/custom_property.sh
```

### Test con Terraform
```bash
# Test a través de Terraform
terraform plan -target=null_resource.org_custom_properties
terraform apply -target=null_resource.org_custom_properties -auto-approve
```

### Verificación de Resultados
```bash
# Verificar custom properties en GitHub
source .env
curl -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/orgs/$GITHUB_ORGANIZATION/properties/schema" | jq .

# Revisar logs
tail -f /tmp/custom-properties-*.log
```

## Mantenimiento

### Logs
Los scripts generan logs en `/tmp/` con el patrón:
- Custom properties: `/tmp/custom-properties-{PROPERTY_NAME}.log`
- Codespaces: `/tmp/codespaces-org-access.log`

### Rotación de Logs
```bash
# Limpiar logs antiguos
find /tmp -name "*custom-properties*.log" -mtime +7 -delete
find /tmp -name "*codespaces*.log" -mtime +7 -delete
```

### Actualización de GitHub App
Si se cambian los permisos de la GitHub App:
1. Actualizar permisos en GitHub
2. Re-instalar la app en la organización
3. Verificar que INSTALLATION_ID no haya cambiado
4. Testar scripts individualmente
