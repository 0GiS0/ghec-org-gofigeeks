---
_format_version: "3.0"
_transform: true

services:
  - name: health-service
    url: http://httpbin.org
    routes:
      - name: health-route
        paths:
          - /health
        methods:
          - GET
        strip_path: true

  - name: excursions-service
    url: http://excursions-api:8000
    routes:
      - name: excursions-route
        paths:
          - /api/excursions
        methods:
          - GET
          - POST
          - PUT
          - DELETE
        strip_path: false
      - name: excursions-single-route
        paths:
          - /api/excursions/(?<id>\d+)
        methods:
          - GET
          - PUT
          - DELETE
        strip_path: false

  - name: ai-assistant-service
    url: http://ai-assistant:8000
    routes:
      - name: ai-chat-route
        paths:
          - /ai/chat
        methods:
          - POST
        strip_path: false
      - name: ai-recommend-route
        paths:
          - /ai/recommend
        methods:
          - POST
        strip_path: false

plugins:
  - name: cors
    config:
      origins:
        - "*"
      methods:
        - GET
        - POST
        - PUT
        - DELETE
        - OPTIONS
      headers:
        - Accept
        - Accept-Version
        - Content-Length
        - Content-MD5
        - Content-Type
        - Date
        - X-Auth-Token
        - Authorization
      exposed_headers:
        - X-Auth-Token
      credentials: true
      max_age: 86400

  - name: rate-limiting
    config:
      minute: 60
      hour: 1000
      policy: local

  - name: request-size-limiting
    config:
      allowed_payload_size: 128
      max_age: 3600

  - name: rate-limiting
    config:
      minute: 100
      hour: 1000
