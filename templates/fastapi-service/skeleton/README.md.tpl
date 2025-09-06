# ${{values.name}}

<!-- Badges (dynamic using Backstage template variables) -->
<p align="left">
      <a href="https://github.com/0GiS0/${{values.name}}/actions/workflows/ci.yml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/0GiS0/${{values.name}}/ci.yml?branch=main&label=CI&logo=github" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/security/code-scanning"><img alt="CodeQL" src="https://img.shields.io/github/actions/workflow/status/0GiS0/${{values.name}}/codeql.yml?branch=main&label=CodeQL&logo=github" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/issues"><img alt="Issues" src="https://img.shields.io/github/issues/0GiS0/${{values.name}}?logo=github" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/pulls"><img alt="PRs" src="https://img.shields.io/github/issues-pr/0GiS0/${{values.name}}?logo=github" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/commits/main"><img alt="Last Commit" src="https://img.shields.io/github/last-commit/0GiS0/${{values.name}}?logo=github" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/0GiS0/${{values.name}}" /></a>
      <a href="https://github.com/0GiS0/${{values.name}}/network/dependencies"><img alt="Dependabot" src="https://img.shields.io/badge/Dependabot-enabled-success?logo=dependabot" /></a>
</p>

${{values.description}}

## 🚀 Quick Start

### Prerequisites

- Python 3.11 or higher
- pip

### Development

1. **Install dependencies:**
   ```bash
   pip install -r requirements.txt -r requirements-dev.txt
   ```

2. **Start development server:**
   ```bash
   uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
   ```

3. **Run tests:**
   ```bash
   pytest
   ```

4. **Run tests with coverage:**
   ```bash
   pytest --cov=app --cov-report=html
   ```

5. **Format code:**
   ```bash
   black .
   isort .
   ```

6. **Lint code:**
   ```bash
   flake8 .
   ```

7. **Build documentation:**
   ```bash
   mkdocs serve
   ```

### API Documentation

- Interactive API docs: http://localhost:8000/docs
- Alternative docs: http://localhost:8000/redoc
- OpenAPI schema: http://localhost:8000/openapi.json
- Project documentation: http://localhost:8001 (after running `mkdocs serve`)

### API Testing

Use the provided HTTP files in VS Code with the REST Client extension:
- `api.http` - Complete API test suite for interactive testing

### API Endpoints

- `GET /` - Root endpoint with service information
- `GET /health` - Health check endpoint
- `GET /api/hello` - Hello world endpoint
- `GET /api/status` - Service status endpoint

### Environment Variables

Create a `.env` file in the root directory:

```env
PORT=8000
HOST=0.0.0.0
ENVIRONMENT=development
```

### Docker Development

This project includes a dev container configuration. Open in VS Code and use "Dev Containers: Reopen in Container".

### Production Deployment

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

## 📝 Architecture

This is a FastAPI service with:

- FastAPI web framework
- Pydantic for data validation
- CORS middleware
- Environment variable configuration
- Health check endpoints
- Automatic OpenAPI documentation
- Pytest for testing

## 🧪 Testing

Run the test suite:

```bash
pytest
```

Run with coverage:

```bash
pytest --cov=app --cov-report=html
```

View coverage report by opening `htmlcov/index.html` in your browser.

## 📚 Documentation

This project includes comprehensive documentation built with MkDocs:

### Local Development
```bash
mkdocs serve
```
Then visit http://localhost:8001

### Build Static Site
```bash
mkdocs build
```

### Deploy to GitHub Pages
```bash
mkdocs gh-deploy
```

## 🤖 AI Agent Support

This project includes comprehensive documentation for working with AI coding agents. See [AGENTS.md](AGENTS.md) for:
- Best practices for AI-assisted development
- Common prompts and templates
- Code quality guidelines
- Security considerations

## 🔗 Integration

### Backstage Integration
This service includes a `catalog-info.yaml` file for integration with Backstage developer portals.

### VS Code Integration
- REST Client files for API testing
- Dev container configuration
- Recommended extensions and settings

## 📦 Dependencies

- **fastapi**: Modern web framework
- **uvicorn**: ASGI server
- **pydantic**: Data validation
- **python-dotenv**: Environment variable management

## 🛠️ Development Dependencies

- **pytest**: Testing framework
- **pytest-cov**: Coverage reporting
- **httpx**: HTTP client for testing
- **black**: Code formatter
- **flake8**: Code linter
- **isort**: Import organizer
- **mkdocs**: Documentation generator
- **mkdocs-material**: Documentation theme