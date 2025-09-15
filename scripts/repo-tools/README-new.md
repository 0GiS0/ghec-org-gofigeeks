# Herramientas de Mantenimiento del Repositorio

Este directorio contiene scripts para el mantenimiento, validación y limpieza del repositorio de código.

## Scripts Disponibles

### `check-python-format.sh`
**Propósito**: Verificar que todos los archivos Python (`.py.tpl`) en las plantillas sigan el formato estándar de black.

**Uso**:
```bash
# Verificación básica
./scripts/repo-tools/check-python-format.sh

# Con archivo de log personalizado
LOG_FILE="/tmp/mi-verificacion.log" ./scripts/repo-tools/check-python-format.sh
```

**Características**:
- Utiliza configuración personalizada con líneas de hasta 120 caracteres
- Detecta automáticamente todos los archivos `.py.tpl` en `templates/`
- Genera logs detallados con timestamps en `/tmp/python-format-check.log`
- Código de salida 0 si todo está correcto, 1 si hay errores
- Muestra diffs de los cambios necesarios
- Proporciona comando para corregir automáticamente

### `format-python.sh`
**Propósito**: Aplicar automáticamente el formato black a todos los archivos Python (`.py.tpl`) en las plantillas.

**Uso**:
```bash
# Formateo automático
./scripts/repo-tools/format-python.sh

# Con archivo de log personalizado
LOG_FILE="/tmp/mi-formato.log" ./scripts/repo-tools/format-python.sh
```

**Características**:
- Utiliza configuración personalizada con líneas de hasta 120 caracteres
- Modifica directamente los archivos para aplicar el formato correcto
- Preserva los placeholders de Backstage (`${{values.name}}`) y Terraform (`${variable}`)
- Genera logs de cada archivo procesado en `/tmp/python-format-apply.log`
- Operación idempotente (seguro ejecutar múltiples veces)
- Maneja temporalmente archivos sin extensión `.tpl` para que black los reconozca

### `check-rendered-templates.sh`
**Propósito**: Verificar que las plantillas Python renderizadas con valores largos pasen la verificación de Black.

**Uso**:
```bash
./scripts/repo-tools/check-rendered-templates.sh
```

**Características**:
- Simula el renderizado de Backstage con valores extremadamente largos
- Verifica que el código renderizado final pase `black --check`
- Previene problemas en GitHub Actions por líneas muy largas
- Utiliza configuración personalizada de 120 caracteres
- Muestra exactamente qué archivo falla si hay problemas

### `check-all.sh`
**Propósito**: Ejecutar todas las verificaciones de calidad del proyecto en una sola ejecución.

**Uso**:
```bash
./scripts/repo-tools/check-all.sh
```

**Verificaciones incluidas**:
1. Formato Terraform (`terraform fmt`)
2. Validación Terraform (`terraform validate`)
3. Formato Python (`check-python-format.sh`)
4. Plantillas renderizadas (`check-rendered-templates.sh`)

**Resumen**: Proporciona un resumen final indicando si todas las verificaciones pasaron o qué comandos ejecutar para corregir problemas.

### `cleanup-demo-repos.sh`
**Propósito**: Limpiar repositorios de demostración marcados con la propiedad personalizada `demo=yes`.

**Uso**:
```bash
# Verificar qué se eliminaría (modo dry-run)
./scripts/repo-tools/cleanup-demo-repos.sh --dry-run

# Eliminar repositorios demo
./scripts/repo-tools/cleanup-demo-repos.sh
```

**Características**:
- Busca repositorios con custom property `demo=yes`
- Modo dry-run para verificar antes de eliminar
- Registra todas las acciones en logs
- Requiere confirmación interactiva por defecto

## Configuración

### Black Configuration
Las plantillas Python utilizan una configuración personalizada definida en `software_templates/pyproject.toml`:

```toml
[tool.black]
line-length = 120
target-version = ['py311']
```

Esta configuración más permisiva evita problemas cuando Backstage renderiza placeholders largos como nombres de servicios o descripciones extensas.

## Archivos Verificados
Los scripts de Python procesan estos archivos:
- `templates/skeletons/ai-assistant/src/main.py.tpl`
- `templates/skeletons/fastapi-service/app/**/*.py.tpl`
- `templates/skeletons/fastapi-service/tests/**/*.py.tpl`
- `templates/skeletons/env-live/validate_config.py.tpl`

## Flujo de Trabajo Recomendado

### Antes de Commit
```bash
# Verificar todo
./scripts/repo-tools/check-all.sh

# Si hay problemas de formato Python
./scripts/repo-tools/format-python.sh

# Verificar nuevamente
./scripts/repo-tools/check-all.sh
```

### Al Modificar Plantillas Python
```bash
# Formatear específicamente
./scripts/repo-tools/format-python.sh

# Verificar renderizado
./scripts/repo-tools/check-rendered-templates.sh
```

### Desarrollo de Nuevas Plantillas
1. Crear archivos `.py.tpl` 
2. Usar constantes para placeholders largos:
   ```python
   # Service configuration
   SERVICE_NAME = "${{values.name}}"
   SERVICE_DESCRIPTION = "${{values.description}}"
   ```
3. Formatear: `./scripts/repo-tools/format-python.sh`
4. Verificar renderizado: `./scripts/repo-tools/check-rendered-templates.sh`

## Casos de Uso Específicos

### Pre-commit Hooks
```bash
#!/bin/bash
# .git/hooks/pre-commit
./scripts/repo-tools/check-all.sh
exit $?
```

### CI/CD Pipeline
```yaml
# GitHub Actions ejemplo
- name: Verificar calidad código
  run: ./scripts/repo-tools/check-all.sh

- name: Verificar plantillas renderizadas
  run: ./scripts/repo-tools/check-rendered-templates.sh
```

## Solución de Problemas

### Error: "would reformat file"
Este error indica que el código renderizado no cumple con Black. Causas comunes:
- Placeholders de Backstage generan líneas muy largas
- Estructura de código no compatible con Black

**Solución**:
- Usar constantes al principio del archivo
- Aplicar formato con configuración personalizada
- Verificar con `check-rendered-templates.sh`

### Error: "black command not found"
Asegurar que Black está instalado:
```bash
pip install black
```

### Logs Detallados
- Python format: `/tmp/python-format-check.log`
- Python formatting: `/tmp/python-format.log`
- Template rendering verification: salida en stdout

### Variables de Entorno
- `LOG_FILE`: Personalizar archivo de log para scripts de Python
- `DRY_RUN`: Activar modo simulación en scripts de limpieza

## GitHub Actions Integration

Estos scripts están diseñados para integrarse con GitHub Actions. El flujo típico:

1. `check-all.sh` en pre-commit hooks
2. `check-rendered-templates.sh` en CI para verificar compatibilidad
3. Fallos en CI si las plantillas generan código mal formateado

## Mantenimiento

- Revisar configuración de Black periódicamente
- Actualizar scripts si cambian los patrones de placeholders de Backstage
- Probar con nuevos tipos de plantillas cuando se añadan
- Verificar compatibilidad con nuevas versiones de Black

## Ejemplo de Uso Completo

```bash
# Desarrollo típico de una nueva plantilla
cd /workspaces/ghec-org-as-code

# 1. Crear nueva plantilla
echo 'print("${{values.name}}")' > software_templates/skeletons/new-service/main.py.tpl

# 2. Formatear
./scripts/repo-tools/format-python.sh

# 3. Verificar que funciona con valores largos
./scripts/repo-tools/check-rendered-templates.sh

# 4. Verificación completa
./scripts/repo-tools/check-all.sh

# 5. Commit si todo está bien
git add . && git commit -m "Add new service template"
```
