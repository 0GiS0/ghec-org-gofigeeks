# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
.pnpm-debug.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage
*.lcov

# nyc test coverage
.nyc_output

# Dependency directories
node_modules/
jspm_packages/

# dotenv environment variable files
.env
.env.development.local
.env.test.local
.env.production.local
.env.local

# Docker
.dockerignore
docker-compose.override.yml
docker-compose.dev.yml

# Temporary files
tmp/
temp/

# Configuration overrides
config/local.yml
config/local.yaml
config/local.json
config/development.yml
config/development.yaml
config/development.json
config/production.yml
config/production.yaml
config/production.json

# SSL certificates
*.pem
*.key
*.crt
*.p12
*.pfx

# Gateway specific
logs/
access.log
error.log

# Cache
.cache/

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Editor files
.vscode/*
!.vscode/extensions.json
!.vscode/settings.json
.idea/
*.swp
*.swo
*~