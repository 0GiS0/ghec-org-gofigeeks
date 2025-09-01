# ${{values.name}}

${{values.description}}

## Gateway Configuration

This template provides a basic API Gateway configuration using Kong.

### Structure

- `config/kong.yml` - Kong configuration file
- `docker-compose.yml` - Docker Compose setup for local development
- `.devcontainer/` - VS Code dev container configuration

### Quick Start

1. **Start the gateway:**
   ```bash
   docker-compose up -d
   ```

2. **Verify gateway is running:**
   ```bash
   curl http://localhost:8000/health
   ```

3. **Admin API:**
   ```bash
   curl http://localhost:8001/status
   ```

### Configuration

The gateway is configured to proxy requests to backend services. Modify `config/kong.yml` to add your services and routes.

### API Endpoints

- `GET /health` - Health check endpoint
- Admin API: `http://localhost:8001`
- Proxy: `http://localhost:8000`