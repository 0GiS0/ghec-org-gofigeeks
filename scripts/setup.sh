#!/usr/bin/env bash
set -eo pipefail

# Script de configuración inicial para GHEC Org as Code
# Ayuda a configurar el entorno de desarrollo por primera vez

echo "🚀 Configuración inicial de GHEC Org as Code"
echo "============================================="
echo ""

# Verificar que estamos en el directorio correcto
if [ ! -f ".env.sample" ] || [ ! -f "terraform.tf" ]; then
    echo "❌ Error: Este script debe ejecutarse desde el directorio raíz del proyecto" >&2
    exit 1
fi

# Paso 1: Verificar dependencias
echo "📋 Paso 1: Verificando dependencias..."

# Verificar Terraform
if ! command -v terraform >/dev/null 2>&1; then
    echo "❌ Terraform no está instalado"
    echo "   Instalar desde: https://terraform.io/downloads"
    exit 1
fi
echo "✅ Terraform $(terraform version -json | jq -r .terraform_version)"

# Verificar black
if ! command -v black >/dev/null 2>&1; then
    echo "⚠️  Black no está instalado (opcional para desarrollo Python)"
    echo "   Instalar con: pip install black"
else
    echo "✅ Black $(black --version | cut -d' ' -f2)"
fi

# Verificar curl y jq
if ! command -v curl >/dev/null 2>&1; then
    echo "❌ curl no está instalado"
    exit 1
fi
echo "✅ curl disponible"

if ! command -v jq >/dev/null 2>&1; then
    echo "❌ jq no está instalado"
    echo "   Instalar con: apt-get install jq (Ubuntu) o brew install jq (macOS)"
    exit 1
fi
echo "✅ jq disponible"
echo ""

# Paso 2: Configurar archivo .env
echo "📝 Paso 2: Configurando variables de entorno..."

if [ -f ".env" ]; then
    echo "⚠️  El archivo .env ya existe."
    read -p "¿Quieres sobrescribirlo? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "✅ Manteniendo archivo .env existente"
    else
        cp .env.sample .env
        echo "✅ Archivo .env sobrescrito desde .env.sample"
    fi
else
    cp .env.sample .env
    echo "✅ Archivo .env creado desde .env.sample"
fi
echo ""

# Paso 3: Guía de configuración
echo "🔧 Paso 3: Configurar variables de entorno"
echo "==========================================="
echo ""
echo "Edita el archivo .env con tus credenciales reales:"
echo ""
echo "  nano .env"
echo ""
echo "Variables requeridas:"
echo "  - GITHUB_ORGANIZATION: Nombre de tu organización"
echo "  - GITHUB_APP_ID: ID de tu GitHub App"
echo "  - GITHUB_APP_INSTALLATION_ID: ID de instalación"
echo "  - GITHUB_APP_PEM_FILE: Ruta al archivo .pem"
echo ""

read -p "¿Quieres abrir .env para editarlo ahora? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ${EDITOR:-nano} .env
fi

echo ""

# Paso 4: Configurar GitHub App
echo "📱 Paso 4: Configuración de GitHub App"
echo "======================================"
echo ""
echo "Si aún no tienes una GitHub App configurada:"
echo ""
echo "1. Ve a tu organización > Settings > GitHub Apps"
echo "2. Clic en 'New GitHub App'"
echo "3. Configura estos permisos:"
echo "   - Organization: Read & Write"
echo "   - Repository: Read & Write"
echo "   - Metadata: Read"
echo "   - Members: Read"
echo "   - Administration: Read & Write"
echo ""
echo "4. Genera y descarga la clave privada (.pem)"
echo "5. Instala la app en tu organización"
echo "6. Anota el App ID e Installation ID"
echo ""

# Paso 5: Verificar configuración
echo "🔍 Paso 5: Verificar configuración"
echo "=================================="
echo ""

if [ -f ".env" ]; then
    echo "Intentando cargar variables de entorno..."
    if source scripts/load-env.sh; then
        echo ""
        echo "🎉 ¡Configuración completada exitosamente!"
        echo ""
        echo "Próximos pasos:"
        echo "  1. terraform init"
        echo "  2. terraform plan"
        echo "  3. terraform apply"
        echo ""
        echo "Para verificar todo:"
        echo "  ./scripts/repo-tools/check-all.sh"
    else
        echo ""
        echo "⚠️  Configuración incompleta. Revisa el archivo .env"
    fi
else
    echo "❌ Archivo .env no encontrado"
fi

echo ""
echo "📚 Para más información, consulta:"
echo "   - README.md"
echo "   - AGENTS.md"
echo "   - scripts/README.md"
