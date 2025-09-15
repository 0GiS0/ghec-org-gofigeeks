#!/usr/bin/env bash
set -eo pipefail

# Script para aplicar automáticamente el formato black a archivos Python en plantillas
# Este script corrige el formato de todo el código Python según el estándar de black

LOG_FILE="${LOG_FILE:-/tmp/python-format-apply.log}"

echo "$(date -Is) INICIO aplicación formato Python" >> "$LOG_FILE"

# Función para formatear archivos .py.tpl
format_python_template() {
    local template_file="$1"
    local temp_file="/tmp/$(basename "$template_file" .tpl)"
    
    echo "$(date -Is) FORMATTING $template_file" >> "$LOG_FILE"
    
    # Copiar el archivo sin la extensión .tpl para que black lo reconozca como Python
    cp "$template_file" "$temp_file"
    
    # Aplicar black al archivo temporal
    if black "$temp_file" >> "$LOG_FILE" 2>&1; then
        # Copiar el archivo formateado de vuelta al archivo original
        cp "$temp_file" "$template_file"
        echo "$(date -Is) SUCCESS $template_file formateado correctamente" >> "$LOG_FILE"
        echo "✅ Formateado: $template_file"
    else
        echo "$(date -Is) ERROR no se pudo formatear $template_file" >> "$LOG_FILE"
        echo "❌ Error formateando: $template_file" >&2
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

echo "Aplicando formato black a archivos Python en plantillas..."
echo "$(date -Is) INICIO búsqueda archivos .py.tpl" >> "$LOG_FILE"

# Buscar y formatear todos los archivos .py.tpl
while IFS= read -r -d '' file; do
    format_python_template "$file"
done < <(find software_templates/ -name "*.py.tpl" -type f -print0 2>/dev/null || true)

# Verificar si encontramos archivos
PYTHON_FILES_COUNT=$(find software_templates/ -name "*.py.tpl" -type f | wc -l)
echo "$(date -Is) PROCESADOS $PYTHON_FILES_COUNT archivos Python" >> "$LOG_FILE"

if [ "$PYTHON_FILES_COUNT" -eq 0 ]; then
    echo "No se encontraron archivos Python (.py.tpl) en software_templates/"
    echo "$(date -Is) WARNING no hay archivos Python para formatear" >> "$LOG_FILE"
else
    echo "Procesados $PYTHON_FILES_COUNT archivos Python"
    echo "$(date -Is) SUCCESS formato aplicado a todos los archivos" >> "$LOG_FILE"
    echo "✅ Formato aplicado a todos los archivos Python"
fi
