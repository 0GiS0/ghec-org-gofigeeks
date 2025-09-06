# ${{values.name}}

<!-- Badges (dynamic using Backstage template variables) -->
<p align="left">
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/actions/workflows/ci.yml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/${{values.github_organization}}/${{values.repo_name}}/ci.yml?branch=main&label=CI&logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/security/code-scanning"><img alt="CodeQL" src="https://img.shields.io/github/actions/workflow/status/${{values.github_organization}}/${{values.repo_name}}/codeql.yml?branch=main&label=CodeQL&logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/issues"><img alt="Issues" src="https://img.shields.io/github/issues/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/pulls"><img alt="PRs" src="https://img.shields.io/github/issues-pr/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/commits/main"><img alt="Last Commit" src="https://img.shields.io/github/last-commit/${{values.github_organization}}/${{values.repo_name}}?logo=github" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/${{values.github_organization}}/${{values.repo_name}}" /></a>
   <a href="https://github.com/${{values.github_organization}}/${{values.repo_name}}/network/dependencies"><img alt="Dependabot" src="https://img.shields.io/badge/Dependabot-enabled-success?logo=dependabot" /></a>
</p>

${{values.description}}

## 🚀 Quick Start

### Prerequisites

- Node.js 18 or higher
- npm or yarn

### Development

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start development server:**
   ```bash
   npm run dev
   ```

3. **Build for production:**
   ```bash
   npm run build
   ```

4. **Preview production build:**
   ```bash
   npm run preview
   ```

5. **Type checking:**
   ```bash
   npm run check
   ```

### Project Structure

```
src/
├── pages/
│   ├── index.astro      # Home page
│   └── api/             # API endpoints
├── components/          # Reusable components
├── layouts/            # Page layouts
└── styles/             # Global styles
```

### Development Server

The development server runs on `http://localhost:4321` by default.

### API Endpoints

This template includes API route examples in `src/pages/api/`.

### Docker Development

This project includes a dev container configuration. Open in VS Code and use "Dev Containers: Reopen in Container".

## 📝 Architecture

This is an Astro frontend application with:

- Astro framework for fast, content-focused websites
- TypeScript support
- Server-side rendering (SSR) capabilities
- Static site generation (SSG)
- API routes for backend functionality
- Component-based architecture

## 🧪 Testing

Add your testing framework of choice. Astro works well with:

- Vitest for unit testing
- Playwright for e2e testing
- Cypress for integration testing

## 📦 Dependencies

- **astro**: The Astro framework
- **typescript**: TypeScript support
- **@astrojs/check**: Type checking

## 🛠️ Development Dependencies

- **@types/node**: Node.js type definitions

## 🚀 Deployment

Astro supports multiple deployment targets:

- Static hosting (Netlify, Vercel, GitHub Pages)
- Node.js servers
- Serverless functions
- Docker containers

Refer to the [Astro deployment guide](https://docs.astro.build/en/guides/deploy/) for specific instructions.