# 🔧 Guía de Configuración Completa

Esta guía te ayudará a configurar el repositorio GHEC Org as Code desde cero.

## 🚀 Configuración Automática (Recomendado)

```bash
# Ejecutar script de configuración
./scripts/setup.sh
```

El script automáticamente:
- ✅ Verifica dependencias
- ✅ Crea archivo .env desde .env.sample
- ✅ Te guía en la configuración de variables
- ✅ Valida la configuración completa

## 🔧 Configuración Manual

### 1. Prerrequisitos

**Software requerido**:
```bash
# Verificar Terraform
terraform version  # >= 1.6

# Verificar herramientas auxiliares
curl --version
jq --version

# Opcional para desarrollo Python
black --version
```

**GitHub App**:
- GitHub App creada en tu organización
- Clave privada (.pem) descargada
- App instalada en la organización
- Permisos correctos configurados

### 2. Variables de Entorno

```bash
# 1. Copiar archivo de ejemplo
cp .env.sample .env

# 2. Editar con tus valores reales
nano .env
```

**Variables requeridas en .env**:

```bash
# Información de tu organización
GITHUB_ORGANIZATION=tu-organizacion

# Credenciales de GitHub App
GITHUB_APP_ID=123456
GITHUB_APP_INSTALLATION_ID=12345678
GITHUB_APP_PEM_FILE=tu-github-app.pem

# Configuración opcional
CUSTOM_PROPERTIES_NON_FATAL_404=false
LOG_LEVEL=INFO
```

### 3. Configuración de GitHub App

#### Crear GitHub App

1. **Ir a configuración de organización**:
   ```
   https://github.com/organizations/TU-ORG/settings/apps
   ```

2. **Crear nueva app**: "New GitHub App"

3. **Configuración básica**:
   - Name: "GHEC Org as Code"
   - Description: "Terraform automation for org management"
   - Homepage URL: URL de este repo

#### Permisos Requeridos

**Organization permissions**:
- Administration: Read and write
- Members: Read
- Codespaces: Read and write
- Custom properties: Read and write

**Repository permissions**:
- Administration: Read and write
- Contents: Read and write
- Metadata: Read

**Account permissions**:
- Organization projects: Read (opcional)

#### Post-configuración

1. **Generar clave privada**:
   - En la página de la app > "Private keys"
   - "Generate a private key"
   - Descargar archivo .pem

2. **Instalar en organización**:
   - "Install App" > Seleccionar tu organización
   - Elegir "All repositories" o repositorios específicos

3. **Obtener IDs**:
   - App ID: En la página principal de la app
   - Installation ID: En la URL después de instalar

### 4. Configuración de Archivos

#### Configurar archivo PEM

```bash
# Mover archivo PEM al directorio del proyecto
mv ~/Downloads/tu-app.pem ./tu-github-app.pem

# Configurar permisos seguros
chmod 600 tu-github-app.pem

# Verificar
ls -la *.pem
```

#### Validar configuración

```bash
# Cargar variables de entorno
source scripts/load-env.sh

# Verificar que todas las variables están configuradas
echo "Organización: $GITHUB_ORGANIZATION"
echo "App ID: $GITHUB_APP_ID"
echo "Installation ID: $GITHUB_APP_INSTALLATION_ID"
echo "PEM file: $GITHUB_APP_PEM_FILE"
```

### 5. Configuración de Terraform (Opcional)

Si prefieres usar `terraform.tfvars`:

```bash
# Copiar ejemplo
cp terraform.tfvars.example terraform.tfvars

# Editar con tus valores
nano terraform.tfvars
```

**Prioridad de variables**:
1. `terraform.tfvars` (mayor prioridad)
2. Variables TF_VAR_* desde .env
3. Variables por defecto

## 🧪 Verificación de Configuración

### Test Básico

```bash
# 1. Cargar variables
source scripts/load-env.sh

# 2. Verificar conectividad
./scripts/terraform-integration/github_app_token.sh

# 3. Inicializar Terraform
terraform init

# 4. Validar configuración
terraform validate

# 5. Ver plan
terraform plan
```

### Test de Scripts

```bash
# Verificar herramientas de desarrollo
./scripts/repo-tools/check-all.sh

# Test específico de formato Python
./scripts/repo-tools/check-python-format.sh
```

### Test de API

```bash
# Cargar variables
source .env

# Test de autenticación
TOKEN=$(./scripts/terraform-integration/github_app_token.sh)
echo "Token obtenido: ${TOKEN:0:10}..."

# Test de API organizacional
curl -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/orgs/$GITHUB_ORGANIZATION" | jq .login
```

## 🔐 Configuración de Seguridad

### Archivos Sensibles

Asegurar que estos archivos NO están en git:

```bash
# Verificar .gitignore
grep -E "(\.env|\.pem|terraform\.tfvars)" .gitignore

# Verificar estado de git
git status --ignored
```

### Permisos de Archivos

```bash
# PEM file debe ser 600
chmod 600 *.pem
ls -la *.pem

# .env puede ser 640
chmod 640 .env
```

### Rotación de Credenciales

**GitHub App**:
- Regenerar clave privada periódicamente
- Actualizar archivo .pem
- Verificar que los permisos siguen siendo correctos

**Variables de entorno**:
- Revisar y actualizar .env regularmente
- No compartir archivos .env entre entornos

## 🚨 Troubleshooting

### Errores Comunes

**"GitHub token is not valid"**:
```bash
# Verificar que el token se genera correctamente
./scripts/terraform-integration/github_app_token.sh

# Verificar permisos del archivo PEM
ls -la *.pem

# Verificar que la app está instalada
curl -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/app/installations"
```

**"Organization not found"**:
```bash
# Verificar nombre de organización
echo $GITHUB_ORGANIZATION

# Verificar que la app tiene acceso
curl -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/orgs/$GITHUB_ORGANIZATION"
```

**"Installation not found"**:
```bash
# Verificar Installation ID
echo $GITHUB_APP_INSTALLATION_ID

# Listar instalaciones
curl -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/app/installations"
```

### Logs de Debugging

```bash
# Ver logs de scripts
tail -f /tmp/custom-properties-*.log
tail -f /tmp/python-format-*.log

# Ver logs de Terraform
export TF_LOG=DEBUG
terraform plan
```

### Reset Completo

Si necesitas empezar desde cero:

```bash
# Limpiar configuración
rm -f .env terraform.tfvars

# Limpiar estado de Terraform
rm -rf .terraform/
rm -f terraform.tfstate*

# Limpiar logs
rm -f /tmp/*properties*.log /tmp/*python*.log

# Empezar de nuevo
./scripts/setup.sh
```

## 📚 Recursos Adicionales

- **[GitHub Apps Documentation](https://docs.github.com/en/developers/apps)**
- **[Terraform GitHub Provider](https://registry.terraform.io/providers/integrations/github/latest/docs)**
- **[AGENTS.md](../AGENTS.md)** - Documentación para agentes IA
- **[scripts/README.md](../scripts/README.md)** - Documentación de scripts

---

¿Necesitas ayuda? Revisa la documentación completa o consulta los logs para más detalles.
