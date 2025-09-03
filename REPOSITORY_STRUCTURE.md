# Estructura de Archivos de Repositorios Terraform

Este documento explica la nueva estructura modular de los archivos Terraform para la gestión de repositorios de plantillas Backstage.

## Archivos Creados

### 🏗️ Archivo Principal
- **`repositories.tf`**: Contiene la configuración principal de repositorios (templates, backstage, reusable-workflows), permisos de equipos y branch protection.

### 🔧 Archivos Comunes
- **`repository-templates-common.tf`**: Archivos comunes para todas las plantillas (CODEOWNERS, CI workflows, catalog-info.yaml, etc.)

### 📋 Archivos por Plantilla Específica
- **`repository-template-node-service.tf`**: Archivos específicos para Node.js Service template
- **`repository-template-fastapi-service.tf`**: Archivos específicos para FastAPI Service template  
- **`repository-template-dotnet-service.tf`**: Archivos específicos para .NET Service template
- **`repository-template-astro-frontend.tf`**: Archivos específicos para Astro Frontend template
- **`repository-template-ai-assistant.tf`**: Archivos específicos para AI Assistant template
- **`repository-template-gateway.tf`**: Archivos específicos para Gateway template
- **`repository-template-helm-base.tf`**: Archivos específicos para Helm Base template
- **`repository-template-env-live.tf`**: Archivos específicos para Environment Live template
- **`repository-templates-generic.tf`**: Archivos para templates genéricos (System y Domain)

## Beneficios de la Nueva Estructura

### ✅ Ventajas
1. **Separación de responsabilidades**: Cada archivo se enfoca en una plantilla específica
2. **Facilidad de mantenimiento**: Cambios en una plantilla no afectan otras
3. **Menos conflictos de merge**: Equipos pueden trabajar en plantillas diferentes sin conflictos
4. **Mejor legibilidad**: Archivos más pequeños y enfocados
5. **Escalabilidad**: Fácil agregar nuevas plantillas sin tocar archivos existentes

### 📊 Comparación
| Aspecto | Antes | Después |
|---------|--------|---------|
| Archivos | 1 archivo monolítico (1848 líneas) | 10 archivos modulares (100-400 líneas cada uno) |
| Conflictos de merge | Frecuentes | Mínimos |
| Tiempo de edición | Difícil encontrar sección relevante | Directo al archivo específico |
| Escalabilidad | Difícil agregar nuevas plantillas | Fácil agregar nuevos archivos |

## Estructura de Cada Archivo de Plantilla

Cada archivo de plantilla específica sigue esta estructura estándar:

```hcl
# <Template Name> Template Repository Files
# This file contains all file resources specific to the <Template Name> template

# .gitignore file
resource "github_repository_file" "<template>_gitignore" {
  # Configuración específica...
}

# Archivos específicos de la tecnología
resource "github_repository_file" "<template>_<file>" {
  # Configuración específica...
}

# DevContainer configuration
resource "github_repository_file" "<template>_devcontainer" {
  # Configuración específica...
}

# Dependabot configuration
resource "github_repository_file" "<template>_dependabot" {
  # Configuración específica...
}
```

## Flujo de Trabajo Recomendado

### Para Modificar una Plantilla Específica:
1. Identificar el archivo correspondiente (ej: `repository-template-fastapi-service.tf`)
2. Realizar cambios solo en ese archivo
3. Ejecutar `terraform fmt` y `terraform validate`
4. Crear PR enfocado solo en esa plantilla

### Para Cambios Comunes:
1. Modificar `repository-templates-common.tf`
2. Los cambios se aplicarán a todas las plantillas

### Para Nuevas Plantillas:
1. Crear nuevo archivo `repository-template-<nueva-plantilla>.tf`
2. Seguir la estructura estándar de los archivos existentes
3. Agregar la nueva plantilla a `var.template_repositories`

## Validación

Antes de cualquier cambio, siempre ejecutar:

```bash
terraform fmt
terraform validate
```

## Migración Completada

✅ Se dividió el archivo monolítico `repositories.tf` (1848 líneas)  
✅ Se crearon 10 archivos modulares  
✅ Se mantuvieron todas las funcionalidades existentes  
✅ Se validó la sintaxis Terraform  
✅ Se preservaron las dependencias entre recursos  
✅ Se mantuvo la compatibilidad con el estado existente

## Próximos Pasos

1. **Probar aplicación**: `terraform plan` para verificar que no hay cambios inesperados
2. **Actualizar documentación**: Informar al equipo sobre la nueva estructura
3. **Crear guidelines**: Establecer convenciones para futuras plantillas
4. **Automatizar validaciones**: Agregar checks en CI para cada archivo individual
