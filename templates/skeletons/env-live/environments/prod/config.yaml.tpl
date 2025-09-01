---
environment: production
service_name: ${{values.name}}
version: "1.0.0"

# Database configuration
database:
  host: prod-db.example.com
  port: 5432
  name: ${{values.name}}_prod
  connection_pool_size: 50
  ssl_mode: require

# API configuration
api:
  host: 0.0.0.0
  port: 8000
  debug: false
  cors_origins:
    - "https://your-domain.com"

# Feature flags
features:
  enable_analytics: true
  enable_caching: true
  enable_rate_limiting: true

# Logging
logging:
  level: INFO
  format: json

# Resource limits
resources:
  cpu_limit: "2000m"
  memory_limit: "2Gi"
  replicas: 3
