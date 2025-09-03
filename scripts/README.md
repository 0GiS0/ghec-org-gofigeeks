# Scripts de Automatización

Este directorio contiene scripts organizados en dos categorías principales:

## 📁 Estructura del Directorio

### `terraform-integration/`
Scripts que extienden la funcionalidad de Terraform para trabajar con APIs de GitHub que no están completamente soportadas por el provider oficial.

**Scripts incluidos**:
- `github_app_token.sh` - Genera tokens JWT para autenticación con GitHub App
- `custom_property.sh` - Gestiona custom properties organizacionales
- `codespaces_access.sh` - Configura acceso a Codespaces organizacional
- `wait_custom_properties.sh` - Sincronización de custom properties

**Uso**: Estos scripts son ejecutados automáticamente por Terraform mediante recursos `null_resource`.

### `repo-tools/`
Herramientas para el mantenimiento, validación y limpieza del repositorio de código.

**Scripts incluidos**:
- `check-python-format.sh` - Verificar formato Python con black
- `format-python.sh` - Aplicar formato Python automáticamente
- `check-all.sh` - Verificación completa pre-commit
- `cleanup-demo-repos.sh` - Limpieza de repositorios demo

**Uso**: Estos scripts se ejecutan manualmente durante el desarrollo para mantener la calidad del código.

## 🚀 Inicio Rápido

### Para Desarrollo Diario
```bash
# Verificar todo antes de commit
./scripts/repo-tools/check-all.sh

# Si hay errores de formato Python
./scripts/repo-tools/format-python.sh

# Si hay errores de formato Terraform
terraform fmt
```

### Para Debugging de Terraform
```bash
# Ver logs de custom properties
tail -f /tmp/custom-properties-*.log

# Ver logs de codespaces
tail -f /tmp/codespaces-org-access.log

# Test manual de script de integración
cd /workspaces/ghec-org-as-code
source .env
ORG_NAME="$GITHUB_ORGANIZATION" \
APP_ID="$GITHUB_APP_ID" \
INSTALLATION_ID="$GITHUB_APP_INSTALLATION_ID" \
PEM_FILE="$GITHUB_APP_PEM_FILE" \
./scripts/terraform-integration/github_app_token.sh
```

## 📋 Flujos de Trabajo Recomendados

### Pre-commit Checklist
1. **Verificación completa**:
   ```bash
   ./scripts/repo-tools/check-all.sh
   ```

2. **Si hay errores, corregir**:
   ```bash
   # Terraform
   terraform fmt
   
   # Python
   ./scripts/repo-tools/format-python.sh
   ```

3. **Verificar nuevamente**:
   ```bash
   ./scripts/repo-tools/check-all.sh
   ```

### Desarrollo de Plantillas Python
1. **Modificar archivos** `.py.tpl`
2. **Aplicar formato**: `./scripts/repo-tools/format-python.sh`
3. **Verificar**: `./scripts/repo-tools/check-python-format.sh`
4. **Commit** con confianza

### Debugging de Terraform
1. **Verificar logs** de integración
2. **Test individual** de scripts
3. **Aplicar cambios** específicos con `-target`

## 📚 Documentación Detallada

Para información específica sobre cada categoría de scripts:

- **[`terraform-integration/README.md`](terraform-integration/README.md)** - Scripts de integración con Terraform y GitHub API
- **[`repo-tools/README.md`](repo-tools/README.md)** - Herramientas de mantenimiento del repositorio

## 🔧 Dependencias

### Para scripts de integración Terraform
- `curl` - Llamadas HTTP a GitHub API
- `jq` - Procesamiento JSON
- `openssl` - Generación de tokens JWT
- `bash` 4.0+

### Para herramientas de repositorio
- `black` - Formato Python (`pip install black`)
- `terraform` - Validación y formato
- `bash` 4.0+

## 📊 Logs y Debugging

### Ubicaciones de Logs

**Scripts de integración**:
- Custom properties: `/tmp/custom-properties-{PROPERTY_NAME}.log`
- Codespaces: `/tmp/codespaces-org-access.log`

**Herramientas de repo**:
- Python format check: `/tmp/python-format-check.log`
- Python format apply: `/tmp/python-format-apply.log`

### Comandos de Debugging
```bash
# Ver logs en tiempo real
tail -f /tmp/custom-properties-*.log
tail -f /tmp/python-format-*.log

# Limpiar logs antiguos
rm -f /tmp/*custom-properties*.log
rm -f /tmp/*python-format*.log

# Ver todos los logs disponibles
ls -la /tmp/*properties*.log /tmp/*python*.log
```
