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

  - name: example-service
    url: http://httpbin.org
    routes:
      - name: example-route
        paths:
          - /api
        methods:
          - GET
          - POST
          - PUT
          - DELETE
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
      exposed_headers:
        - X-Auth-Token
      credentials: true
      max_age: 3600

  - name: rate-limiting
    config:
      minute: 100
      hour: 1000
