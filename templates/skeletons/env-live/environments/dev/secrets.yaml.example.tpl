# EXAMPLE SECRETS FILE - DO NOT COMMIT ACTUAL SECRETS
# Copy this file to secrets.yaml and fill in actual values

---
database:
  username: "your_db_username"
  password: "your_db_password"

api:
  secret_key: "your_secret_key_here"
  jwt_secret: "your_jwt_secret_here"

external_services:
  openai_api_key: "your_openai_key"
  stripe_api_key: "your_stripe_key"

monitoring:
  datadog_api_key: "your_datadog_key"
  sentry_dsn: "your_sentry_dsn"
