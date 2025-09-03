#!/usr/bin/env bash
set -eo pipefail

# Script de verificación completa antes de hacer commit
# Ejecuta todas las validaciones necesarias para el proyecto

# Cargar variables de entorno si existe .env
if [ -f ".env" ]; then
    set -a
    source .env
    set +a
fi

echo "🔍 Ejecutando verificación completa del proyecto..."
echo ""

EXIT_CODE=0

# 1. Verificar formato Terraform
echo "📋 Verificando formato Terraform..."
if terraform fmt -check; then
    echo "✅ Formato Terraform correcto"
else
    echo "❌ Formato Terraform incorrecto"
    echo "💡 Ejecutar: terraform fmt"
    EXIT_CODE=1
fi
echo ""

# 2. Validar configuración Terraform
echo "🔧 Validando configuración Terraform..."
if terraform validate; then
    echo "✅ Configuración Terraform válida"
else
    echo "❌ Configuración Terraform inválida"
    EXIT_CODE=1
fi
echo ""

# 3. Verificar formato Python
echo "🐍 Verificando formato código Python..."
if ./scripts/repo-tools/check-python-format.sh; then
    echo "✅ Formato Python correcto"
else
    echo "❌ Formato Python incorrecto"
    echo "💡 Ejecutar: ./scripts/repo-tools/format-python.sh"
    HAS_ERRORS=true
fi

echo ""
echo "🎨 Verificando plantillas renderizadas..."
if ./scripts/repo-tools/check-rendered-templates.sh; then
    echo "✅ Plantillas renderizadas correctas"
else
    echo "❌ Plantillas renderizadas fallan verificación"
    echo "💡 Revisar placeholders y formato en plantillas"
    HAS_ERRORS=true
fi
echo ""

# Resumen final
if [ $EXIT_CODE -eq 0 ]; then
    echo "🎉 ¡Todas las verificaciones pasaron! Listo para commit."
else
    echo "⚠️  Algunas verificaciones fallaron. Corregir antes de commit."
    echo ""
    echo "Comandos para corregir:"
    echo "  terraform fmt                                          # Formatear Terraform"
    echo "  ./scripts/repo-tools/format-python.sh                 # Formatear Python"
    echo "  ./scripts/repo-tools/check-rendered-templates.sh      # Verificar plantillas renderizadas"
    echo "  ./scripts/repo-tools/check-all.sh                     # Verificar nuevamente"
fi

exit $EXIT_CODE
