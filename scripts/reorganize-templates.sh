#!/bin/bash

# Script para reorganizar templates a la nueva estructura
# Mueve archivos del skeleton a skeleton/ y crea archivos base del template

set -e

TEMPLATES_DIR="/workspaces/ghec-org-as-code/templates"

# Lista de templates a reorganizar (excluyendo los que ya están reorganizados)
TEMPLATES=(
    "fastapi-service"
    "astro-frontend" 
    "ai-assistant"
    "gateway"
    "helm-base"
    "env-live"
)

echo "🔄 Reorganizando templates a la nueva estructura..."

for template in "${TEMPLATES[@]}"; do
    echo "📁 Procesando template: $template"
    
    template_dir="$TEMPLATES_DIR/$template"
    skeleton_dir="$template_dir/skeleton"
    
    # Verificar si el template existe
    if [ ! -d "$template_dir" ]; then
        echo "❌ Template $template no encontrado, saltando..."
        continue
    fi
    
    # Crear directorio skeleton si no existe
    if [ ! -d "$skeleton_dir" ]; then
        echo "📂 Creando directorio skeleton para $template"
        mkdir -p "$skeleton_dir"
    fi
    
    # Buscar archivos que deben ir al skeleton (excluyendo catalog-info.yaml que ya está en la raíz)
    cd "$template_dir"
    
    # Archivos y directorios que van al skeleton
    files_to_move=()
    
    # Buscar archivos .tpl
    for file in *.tpl; do
        if [ -f "$file" ] && [ "$file" != "catalog-info.yaml" ]; then
            files_to_move+=("$file")
        fi
    done
    
    # Directorios que van al skeleton
    for dir in src tests app docs environments .devcontainer .github .vscode; do
        if [ -d "$dir" ]; then
            files_to_move+=("$dir")
        fi
    done
    
    # Archivos específicos que van al skeleton
    for file in dependabot.yml pyproject.toml; do
        if [ -f "$file" ]; then
            files_to_move+=("$file")
        fi
    done
    
    # Mover archivos al skeleton
    if [ ${#files_to_move[@]} -gt 0 ]; then
        echo "📦 Moviendo archivos al skeleton: ${files_to_move[*]}"
        mv "${files_to_move[@]}" skeleton/ 2>/dev/null || true
    fi
    
    echo "✅ Template $template reorganizado"
done

echo "🎉 Reorganización completada!"

# Verificar la nueva estructura
echo ""
echo "📋 Nueva estructura de templates:"
for template in "${TEMPLATES[@]}"; do
    template_dir="$TEMPLATES_DIR/$template"
    if [ -d "$template_dir" ]; then
        echo ""
        echo "📁 $template:"
        echo "   └── Raíz: $(ls -1 "$template_dir" | grep -v skeleton | wc -l) archivos"
        if [ -d "$template_dir/skeleton" ]; then
            echo "   └── Skeleton: $(find "$template_dir/skeleton" -type f | wc -l) archivos"
        fi
    fi
done
