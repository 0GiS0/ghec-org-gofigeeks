#!/usr/bin/env python3
"""
Script to translate Spanish text to English in README templates
"""

import os
import re

# Translation dictionary
translations = {
    "Este template permite crear un nuevo": "This template allows you to create a new",
    "Este template permite crear": "This template allows you to create",
    "¿Qué incluye este template?": "What does this template include?",
    "Tecnologías y frameworks": "Technologies and frameworks",
    "Estructura del proyecto": "Project structure",
    "Funcionalidades incluidas": "Included features",
    "DevOps y CI/CD": "DevOps and CI/CD",
    "Uso": "Usage",
    "Utiliza este template desde Backstage": "Use this template from Backstage",
    "Completa el formulario con:": "Complete the form with:",
    "Nombre del proyecto (en kebab-case)": "Project name (in kebab-case)",
    "Descripción del servicio": "Service description",
    "Sistema al que pertenece": "System it belongs to",
    "Tier de servicio (1-3 o experimental)": "Service tier (1-3 or experimental)",
    "Equipo responsable": "Responsible team",
    "El template creará:": "The template will create:",
    "Repositorio con toda la estructura": "Repository with complete structure",
    "Configuración de protección de rama": "Branch protection configuration",
    "Pipelines de CI/CD configurados": "Configured CI/CD pipelines",
    "Documentación inicial": "Initial documentation",
    "Estructura generada": "Generated structure",
    "Mejores prácticas incluidas": "Included best practices",
    "Configuración de desarrollo": "Development configuration",
    "Soporte": "Support",
    "Documentación": "Documentation",
    "Consulta la documentación generada en": "Check the generated documentation in",
    "Issues": "Issues",
    "Reporta problemas en el repositorio del template": "Report problems in the template repository",
    "Canal #platform-team para soporte": "#platform-team channel for support",
    
    # Common Spanish words that need translation
    "con ": "with ",
    "para ": "for ",
    "de ": "of ",
    "y ": "and ",
    "el ": "the ",
    "la ": "the ",
    "los ": "the ",
    "las ": "the ",
    "en ": "in ",
    "a ": "to ",
    "del ": "of the ",
    
    # Specific technical translations
    "APIs web": "web APIs",
    "acceso a datos": "data access",
    "testing": "testing",
    "logging estructurado": "structured logging",
    "validación de datos": "data validation",
    "servidor ASGI": "ASGI server",
    "gestión de dependencias": "dependency management",
    "Código fuente de la aplicación": "Application source code",
    "Tests automatizados": "Automated tests",
    "Configuración para desarrollo en contenedores": "Configuration for container development",
    "documentación técnica": "technical documentation",
    "endpoints CRUD para excursiones": "CRUD endpoints for trips/excursions",
    "monitoreo": "monitoring",
    "manejo de errores": "error handling",
    "centralizado": "centralized",
    "protección": "protection",
    "configurado": "configured",
    "documentación automática": "automatic documentation",
    "desarrollo": "development",
    "actualizaciones automáticas": "automatic updates",
    "análisis de seguridad": "security analysis",
    "desarrollo consistente": "consistent development",
    "habilitado": "enabled",
    "disponible en desarrollo": "available in development",
    "certificados de desarrollo": "development certificates",
    "configuración": "configuration",
    "dependencias locales": "local dependencies"
}

def translate_file(file_path):
    """Translate Spanish text in a file to English"""
    print(f"Translating {file_path}")
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    # Apply translations
    for spanish, english in translations.items():
        content = content.replace(spanish, english)
    
    # Save if changes were made
    if content != original_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"  ✅ Updated {file_path}")
    else:
        print(f"  ℹ️  No changes needed in {file_path}")

def main():
    """Main function to process all README files"""
    templates_dir = "/workspaces/ghec-org-as-code/templates"
    
    # Find all README.md files that still contain Spanish
    readme_files = []
    for root, dirs, files in os.walk(templates_dir):
        for file in files:
            if file == "README.md":
                file_path = os.path.join(root, file)
                readme_files.append(file_path)
    
    print(f"Found {len(readme_files)} README files to check")
    
    for readme_file in readme_files:
        translate_file(readme_file)
    
    print("Translation complete!")

if __name__ == "__main__":
    main()
