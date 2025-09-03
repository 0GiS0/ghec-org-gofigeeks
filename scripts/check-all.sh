#!/usr/bin/env bash
set -eo pipefail

# Script de verificación completa antes de hacer commit
# Ejecuta todas las validaciones necesarias para el proyecto

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
if ./scripts/check-python-format.sh; then
    echo "✅ Formato Python correcto"
else
    echo "❌ Formato Python incorrecto"
    echo "💡 Ejecutar: ./scripts/format-python.sh"
    EXIT_CODE=1
fi
echo ""

# Resumen final
if [ $EXIT_CODE -eq 0 ]; then
    echo "🎉 ¡Todas las verificaciones pasaron! Listo para commit."
else
    echo "⚠️  Algunas verificaciones fallaron. Corregir antes de commit."
    echo ""
    echo "Comandos para corregir:"
    echo "  terraform fmt                    # Formatear Terraform"
    echo "  ./scripts/format-python.sh       # Formatear Python"
    echo "  ./scripts/check-all.sh           # Verificar nuevamente"
fi

exit $EXIT_CODE
