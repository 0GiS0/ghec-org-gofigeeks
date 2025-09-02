---
environment: development
service_name: ${{values.name}}
version: "1.0.0"

# Database configuration
database:
  host: localhost
  port: 5432
  name: ${{values.name | replace("-", "_")}}_dev
  connection_pool_size: 10
  ssl_mode: disable

# API configuration
api:
  host: localhost
  port: 8000
  debug: true
  cors_origins:
    - "http://localhost:3000"
    - "http://localhost:4321"

# Feature flags
features:
  enable_analytics: false
  enable_caching: false
  enable_rate_limiting: false

# Logging
logging:
  level: DEBUG
  format: detailed

# Resource limits
resources:
  cpu_limit: "500m"
  memory_limit: "512Mi"
  replicas: 1
