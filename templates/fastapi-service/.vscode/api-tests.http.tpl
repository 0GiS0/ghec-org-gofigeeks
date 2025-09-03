### ${{values.name}} API Testing
### This file contains HTTP requests for testing the API endpoints
### Use VS Code with REST Client extension to run these requests

# Set the base URL for your API
@baseUrl = http://localhost:8000

### Health Check
GET {{baseUrl}}/health

### Root endpoint - Service information
GET {{baseUrl}}/

### Hello World endpoint
GET {{baseUrl}}/api/hello

### Service Status
GET {{baseUrl}}/api/status

### API Documentation
GET {{baseUrl}}/docs

### OpenAPI Schema
GET {{baseUrl}}/openapi.json

### Get all excursions
GET {{baseUrl}}/api/excursions/

### Get specific excursion by ID
GET {{baseUrl}}/api/excursions/1

### Get non-existent excursion (should return 404)
GET {{baseUrl}}/api/excursions/999

### Create new excursion
POST {{baseUrl}}/api/excursions/
Content-Type: application/json

{
  "name": "Sunset Beach Walk",
  "description": "A relaxing evening walk along the beautiful beach during sunset",
  "location": "Santa Monica Beach",
  "price": 25.00,
  "duration": 2,
  "max_participants": 20
}

### Update existing excursion
PUT {{baseUrl}}/api/excursions/1
Content-Type: application/json

{
  "name": "Updated Mountain Adventure",
  "description": "An updated thrilling hike through scenic mountain trails with breathtaking views",
  "location": "Rocky Mountains National Park",
  "price": 85.00,
  "duration": 8,
  "max_participants": 10
}

### Delete excursion (be careful with this!)
DELETE {{baseUrl}}/api/excursions/3

### Test validation error - empty name
POST {{baseUrl}}/api/excursions/
Content-Type: application/json

{
  "name": "",
  "description": "Test description",
  "location": "Test Location",
  "price": 50.00,
  "duration": 3,
  "max_participants": 10
}

### Test validation error - negative price
POST {{baseUrl}}/api/excursions/
Content-Type: application/json

{
  "name": "Test Excursion",
  "description": "Test description",
  "location": "Test Location",
  "price": -10.00,
  "duration": 3,
  "max_participants": 10
}

### Test validation error - zero duration
POST {{baseUrl}}/api/excursions/
Content-Type: application/json

{
  "name": "Test Excursion",
  "description": "Test description",
  "location": "Test Location",
  "price": 50.00,
  "duration": 0,
  "max_participants": 10
}
