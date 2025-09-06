# Astro Frontend Template

<!-- Badges (templated) -->
<p align="left">
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/actions/workflows/ci.yml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/${{values.github_organization}}/${{values.repo_name}}/ci.yml?branch=main&label=CI&logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/security/code-scanning"><img alt="CodeQL" src="https://img.shields.io/github/actions/workflow/status/${{values.github_organization}}/${{values.repo_name}}/codeql.yml?branch=main&label=CodeQL&logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/issues"><img alt="Issues" src="https://img.shields.io/github/issues/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/pulls"><img alt="PRs" src="https://img.shields.io/github/issues-pr/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/commits/main"><img alt="Last Commit" src="https://img.shields.io/github/last-commit/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/${{values.github_organization}}/${{values.repo_name}}" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/network/dependencies"><img alt="Dependabot" src="https://img.shields.io/badge/Dependabot-enabled-success?logo=dependabot" /></a>
</p>

Este template permite crear una nueva aplicación frontend con Astro, TypeScript y prácticas modernas de desarrollo web.

## ¿Qué incluye este template?

### Tecnologías y frameworks
- **Astro** para sitios web modernos y rápidos
- **TypeScript** para tipado estático
- **Tailwind CSS** para estilos utilitarios
- **Vue.js/React** componentes (configurable)
- **Vite** como bundler de desarrollo
- **ESLint** y **Prettier** para calidad de código

### Estructura del proyecto
- `src/` - Código fuente de la aplicación
  - `pages/` - Páginas de la aplicación (rutas)
  - `components/` - Componentes reutilizables
  - `layouts/` - Layouts de página
  - `styles/` - Estilos globales
- `.devcontainer/` - Configuración para desarrollo en contenedores

### Funcionalidades incluidas
- **Static Site Generation (SSG)** por defecto
- **Server Side Rendering (SSR)** opcional
- **API Routes** para funcionalidad backend ligera
- **Image optimization** automática
- **SEO optimizado** con meta tags
- **PWA ready** configuración preparada
- **Hot reload** para desarrollo

### DevOps y CI/CD
- **GitHub Actions** para CI/CD y deploy
- **Vercel/Netlify** deploy automático
- **Docker** para despliegues containerizados
- **DevContainer** para desarrollo consistente
- **Dependabot** para actualizaciones de npm
- **Lighthouse CI** para auditorías de performance

## Uso

1. Utiliza este template desde Backstage
2. Completa el formulario con:
   - Nombre del proyecto (en kebab-case)
   - Descripción de la aplicación
   - Sistema al que pertenece
   - Tier de servicio (normalmente tier-3 para frontends)
   - Equipo responsable

3. El template creará:
   - Repositorio con estructura Astro optimizada
   - Configuración de protección de rama
   - Pipelines de CI/CD para deployment
   - Documentación inicial

## Estructura generada

```
my-frontend/
├── src/
│   ├── pages/
│   │   ├── index.astro
│   │   └── about.astro
│   ├── components/
│   │   ├── Header.astro
│   │   └── Footer.astro
│   ├── layouts/
│   │   └── Layout.astro
│   └── styles/
│       └── global.css
├── public/
│   ├── favicon.ico
│   └── images/
├── .devcontainer/
│   └── devcontainer.json
├── .github/
│   └── workflows/
│       └── deploy.yml
├── package.json
├── astro.config.mjs
├── tailwind.config.js
├── tsconfig.json
└── README.md
```

## Mejores prácticas incluidas

- **Performance first** con Astro Islands
- **Accessibility** (a11y) consideraciones
- **SEO optimization** con meta tags dinámicos
- **Core Web Vitals** optimización
- **Modern CSS** con Tailwind y CSS Grid/Flexbox
- **Component composition** patterns
- **Static assets** optimization
- **Bundle splitting** automático

## Configuración de desarrollo

- **Dev server** con hot reload en puerto 4321
- **TypeScript** checking automático
- **ESLint** y **Prettier** configurados
- **Tailwind CSS** con JIT compilation
- **Image optimization** con `@astrojs/image`
- **VS Code** extensions recomendadas

## Deployment

- **Static hosting** optimizado (Vercel, Netlify, GitHub Pages)
- **CDN ready** con optimización de assets
- **Environment variables** para configuración
- **Build optimization** automática

## Soporte

- **Documentación**: Consulta la documentación generada en `docs/`
- **Issues**: Reporta problemas en el repositorio del template
- **Slack**: Canal #platform-team para soporte
