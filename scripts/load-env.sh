#!/usr/bin/env bash
# Helper script para cargar variables de entorno desde .env
# Uso: source scripts/load-env.sh

# Verificar que estamos en el directorio correcto
if [ ! -f ".env.sample" ]; then
    echo "Error: Este script debe ejecutarse desde el directorio raíz del proyecto" >&2
    return 1 2>/dev/null || exit 1
fi

# Verificar que existe el archivo .env
if [ ! -f ".env" ]; then
    echo "⚠️  Archivo .env no encontrado."
    echo "📋 Copia .env.sample a .env y configura tus variables:"
    echo "   cp .env.sample .env"
    echo "   nano .env"
    return 1 2>/dev/null || exit 1
fi

# Cargar variables de entorno
set -a  # Exportar automáticamente todas las variables
source .env
set +a

echo "✅ Variables de entorno cargadas desde .env"
echo "📊 Configuración actual:"
echo "   - Organización: ${GITHUB_ORGANIZATION:-'no configurada'}"
echo "   - GitHub App ID: ${GITHUB_APP_ID:-'no configurado'}"
echo "   - Installation ID: ${GITHUB_APP_INSTALLATION_ID:-'no configurado'}"
echo "   - Archivo PEM: ${GITHUB_APP_PEM_FILE:-'no configurado'}"

# Validar configuración mínima
missing_vars=()

[ -z "${GITHUB_ORGANIZATION:-}" ] && missing_vars+=("GITHUB_ORGANIZATION")
[ -z "${GITHUB_APP_ID:-}" ] && missing_vars+=("GITHUB_APP_ID")
[ -z "${GITHUB_APP_INSTALLATION_ID:-}" ] && missing_vars+=("GITHUB_APP_INSTALLATION_ID")
[ -z "${GITHUB_APP_PEM_FILE:-}" ] && missing_vars+=("GITHUB_APP_PEM_FILE")

if [ ${#missing_vars[@]} -gt 0 ]; then
    echo ""
    echo "⚠️  Variables faltantes en .env:"
    for var in "${missing_vars[@]}"; do
        echo "   - $var"
    done
    echo ""
    echo "📝 Edita .env y configura estas variables antes de continuar."
    return 1 2>/dev/null || exit 1
fi

# Verificar que el archivo PEM existe
if [ ! -f "${GITHUB_APP_PEM_FILE}" ]; then
    echo ""
    echo "⚠️  Archivo PEM no encontrado: ${GITHUB_APP_PEM_FILE}"
    echo "📝 Verifica que el archivo PEM existe y la ruta es correcta."
    return 1 2>/dev/null || exit 1
fi

# Verificar permisos del archivo PEM
if [ "$(stat -c %a "${GITHUB_APP_PEM_FILE}" 2>/dev/null)" != "600" ]; then
    echo ""
    echo "⚠️  El archivo PEM no tiene permisos seguros."
    echo "🔒 Ejecuta: chmod 600 ${GITHUB_APP_PEM_FILE}"
fi

echo ""
echo "🚀 Configuración lista. Puedes ejecutar scripts y Terraform."
