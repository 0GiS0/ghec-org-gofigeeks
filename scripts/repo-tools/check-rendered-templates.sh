#!/bin/bash

# Script para verificar que las plantillas renderizadas con valores largos 
# no generen problemas de formato con black

set -e

echo "🔍 Verificando plantillas renderizadas con valores largos..."

TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Valores de prueba largos que podrían causar problemas
LONG_NAME="my-super-extremely-long-service-name-that-could-cause-line-length-issues-and-exceed-formatting-limits"
LONG_DESC="This is an exceptionally long service description that explains in great detail what this service does, how it integrates with other systems in our microservices architecture, what patterns it follows, and why it was designed this way"

# Buscar todas las plantillas Python
find templates -name "*.py.tpl" | while read -r template; do
    echo "  Verificando: $template"
    
    # Crear archivo renderizado temporal
    rendered_file="$TEMP_DIR/$(basename "$template" .tpl)"
    
    # Simular renderizado de Backstage
    sed -e "s/\${{values\.name}}/$LONG_NAME/g" \
        -e "s/\${{values\.description}}/$LONG_DESC/g" \
        -e "s/\${{values\.owner}}/platform-team-with-very-long-name/g" \
        -e "s/\${{values\.system}}/booking-and-reservation-management-system-v2/g" \
        "$template" > "$rendered_file"
    
    # Verificar con black usando configuración de templates
    if ! black --config templates/pyproject.toml --check --quiet "$rendered_file" 2>/dev/null; then
        echo "    ❌ FALLA: $template genera código que no pasa black --check"
        echo "    📄 Archivo renderizado: $rendered_file"
        echo "    🔧 Ejecute: black --config templates/pyproject.toml --diff $rendered_file"
        exit 1
    else
        echo "    ✅ OK: $template"
    fi
done

echo "✅ Todas las plantillas Python pasan la verificación de renderizado"
