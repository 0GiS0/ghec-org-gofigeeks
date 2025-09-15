#!/usr/bin/env bash
set -eo pipefail

# Script para verificar el formato de código Python en plantillas usando black --check
# Este script verifica que todo el código Python siga el formato estándar de black

LOG_FILE="${LOG_FILE:-/tmp/python-format-check.log}"
EXIT_CODE=0

echo "$(date -Is) INICIO verificación formato Python" >> "$LOG_FILE"

# Función para procesar archivos .py.tpl
check_python_template() {
    local template_file="$1"
    local temp_file="/tmp/$(basename "$template_file" .tpl)"
    
    echo "$(date -Is) CHECKING $template_file" >> "$LOG_FILE"
    
    # Copiar el archivo sin la extensión .tpl para que black lo reconozca como Python
    cp "$template_file" "$temp_file"
    
    # Ejecutar black --check en el archivo temporal usando configuración personalizada
    if black --config software_templates/pyproject.toml --check --diff "$temp_file" >> "$LOG_FILE" 2>&1; then
        echo "$(date -Is) OK $template_file formato correcto" >> "$LOG_FILE"
    else
        echo "$(date -Is) ERROR $template_file formato incorrecto" >> "$LOG_FILE"
        echo "ERROR: $template_file no tiene el formato correcto de black" >&2
        EXIT_CODE=1
    fi
    
    # Limpiar archivo temporal
    rm -f "$temp_file"
}

# Verificar que black esté instalado
if ! command -v black >/dev/null 2>&1; then
    echo "ERROR: black no está instalado. Instalar con: pip install black" >&2
    echo "$(date -Is) ERROR black no encontrado" >> "$LOG_FILE"
    exit 1
fi

echo "Verificando formato de código Python en plantillas..."
echo "$(date -Is) INICIO búsqueda archivos .py.tpl" >> "$LOG_FILE"

# Buscar y verificar todos los archivos .py.tpl
while IFS= read -r -d '' file; do
    check_python_template "$file"
done < <(find software_templates/ -name "*.py.tpl" -type f -print0 2>/dev/null || true)

# Verificar si encontramos archivos
PYTHON_FILES_COUNT=$(find software_templates/ -name "*.py.tpl" -type f | wc -l)
echo "$(date -Is) ENCONTRADOS $PYTHON_FILES_COUNT archivos Python" >> "$LOG_FILE"

if [ "$PYTHON_FILES_COUNT" -eq 0 ]; then
    echo "No se encontraron archivos Python (.py.tpl) en software_templates/"
    echo "$(date -Is) WARNING no hay archivos Python para verificar" >> "$LOG_FILE"
else
    echo "Verificados $PYTHON_FILES_COUNT archivos Python"
fi

if [ $EXIT_CODE -eq 0 ]; then
    echo "$(date -Is) SUCCESS todos los archivos Python tienen formato correcto" >> "$LOG_FILE"
    echo "✅ Todos los archivos Python tienen el formato correcto"
else
    echo "$(date -Is) FAILURE algunos archivos tienen formato incorrecto" >> "$LOG_FILE"
    echo "❌ Algunos archivos Python no tienen el formato correcto"
    echo "Revisar el log en: $LOG_FILE"
    echo "Para corregir automáticamente, ejecutar: black software_templates/**/*.py.tpl"
fi

exit $EXIT_CODE
