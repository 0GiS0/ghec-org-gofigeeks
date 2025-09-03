### ${{values.name}} Frontend API Tests
### Base URL for development
@baseUrl = http://localhost:4321

### Health Check
GET {{baseUrl}}/api/health

### Get all excursions
GET {{baseUrl}}/api/excursions

### Get excursion by ID
GET {{baseUrl}}/api/excursions/1

### Create new excursion
POST {{baseUrl}}/api/excursions
Content-Type: application/json

{
  "name": "Test Adventure",
  "description": "A test excursion for API validation",
  "location": "Test Location",
  "price": 50.0,
  "duration": 3,
  "maxParticipants": 10
}

### Update excursion
PUT {{baseUrl}}/api/excursions/1
Content-Type: application/json

{
  "name": "Updated Test Adventure",
  "description": "An updated test excursion",
  "location": "Updated Location",
  "price": 75.0,
  "duration": 4,
  "maxParticipants": 12
}

### Delete excursion
DELETE {{baseUrl}}/api/excursions/1

### Test non-existent excursion
GET {{baseUrl}}/api/excursions/999

### Frontend homepage (for reference)
GET {{baseUrl}}/