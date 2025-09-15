#!/bin/bash

# Script para actualizar archivos Terraform con las nuevas rutas skeleton/
set -e

REPO_ROOT="/workspaces/ghec-org-as-code"

echo "🔄 Actualizando archivos Terraform con nuevas rutas skeleton..."

# Lista de archivos Terraform específicos de templates
TERRAFORM_FILES=(
    "repository-template-fastapi-service.tf"
    "repository-template-astro-frontend.tf"
    "repository-template-ai-assistant.tf" 
    "repository-template-gateway.tf"
    "repository-template-helm-base.tf"
    "repository-template-env-live.tf"
    "repository-template-dotnet-service.tf"
    # node-service ya está actualizado
)

cd "$REPO_ROOT"

for tf_file in "${TERRAFORM_FILES[@]}"; do
    if [ -f "$tf_file" ]; then
        echo "📝 Actualizando $tf_file"
        
        # Backup del archivo original
        cp "$tf_file" "$tf_file.backup"
        
        # Template name (extraer de nombre de archivo)
        template_name=$(echo "$tf_file" | sed 's/repository-template-\(.*\)\.tf/\1/')
        
        # Actualizar rutas de archivos que van en skeleton/
        # Cambiar rutas como "templates/fastapi-service/app/" a "templates/fastapi-service/skeleton/app/"
    sed -i "s|software_templates/$template_name/\([^"]*\)|software_templates/$template_name/skeleton/\1|g" "$tf_file"
        
        # Pero revertir para archivos que NO van en skeleton (como el catalog-info.yaml del template)
        # Estos archivos están directamente en la raíz del template
    sed -i "s|software_templates/$template_name/skeleton/skeleton/|software_templates/$template_name/skeleton/|g" "$tf_file"
        
        echo "✅ $tf_file actualizado"
    else
        echo "❌ $tf_file no encontrado"
    fi
done

echo ""
echo "🔍 Verificando cambios realizados..."

# Mostrar un resumen de los cambios
for tf_file in "${TERRAFORM_FILES[@]}"; do
    if [ -f "$tf_file" ] && [ -f "$tf_file.backup" ]; then
        changes=$(diff -u "$tf_file.backup" "$tf_file" | grep "^[+-]" | grep -v "^[+-][+-][+-]" | wc -l)
        if [ "$changes" -gt 0 ]; then
            echo "📊 $tf_file: $changes líneas modificadas"
        else
            echo "📊 $tf_file: sin cambios"
        fi
    fi
done

echo ""
echo "🎉 Actualización de archivos Terraform completada!"
echo "💡 Los backups están disponibles como *.backup en caso de necesitar revertir"
