# API Reference

Complete reference for all API endpoints available in the BACKSTAGE_ENTITY_NAME service.

## Base URL

```
http://localhost:8080
```

## Authentication

Currently, this API does not require authentication. All endpoints are publicly accessible.

## Response Format

All API responses follow a consistent JSON format:

- **Success responses**: Return the requested data directly or wrapped in appropriate structure
- **Error responses**: Include error details with appropriate HTTP status codes

## Core Endpoints

### Root Endpoint

Get basic service information.

**Endpoint:** `GET /`

**Response:**
```json
{
  "service": "BACKSTAGE_ENTITY_NAME",
  "message": "Welcome to BACKSTAGE_ENTITY_NAME API",
  "docs": "/docs",
  "health": "/health"
}
```

**Status Codes:**
- `200 OK`: Service information retrieved successfully

---

### Health Check

Check the health status of the service.

**Endpoint:** `GET /health`

**Response:**
```json
{
  "status": "OK",
  "service": "BACKSTAGE_ENTITY_NAME",
  "timestamp": "2024-01-15T10:30:00Z",
  "version": "1.0.0"
}
```

**Status Codes:**
- `200 OK`: Service is healthy

---

### Hello World

Simple hello world endpoint for testing.

**Endpoint:** `GET /api/hello`

**Response:**
```json
{
  "message": "Hello from BACKSTAGE_ENTITY_NAME!",
  "timestamp": "2024-01-15T10:30:00Z"
}
```

**Status Codes:**
- `200 OK`: Hello message retrieved successfully

---

### Service Status

Get detailed service status information.

**Endpoint:** `GET /api/status`

**Response:**
```json
{
  "service": "BACKSTAGE_ENTITY_NAME",
  "status": "running",
  "uptime": "2.15:30:45",
  "environment": "Development",
  "version": "1.0.0"
}
```

**Status Codes:**
- `200 OK`: Status information retrieved successfully

## Excursions API

Complete CRUD operations for managing excursions.

### Get All Excursions

Retrieve a list of all available excursions.

**Endpoint:** `GET /api/excursions`

**Response:**
```json
[
  {
    "id": 1,
    "name": "Mountain Hiking Adventure",
    "description": "A thrilling hike through the scenic mountain trails with breathtaking views",
    "location": "Rocky Mountains",
    "price": 75.00,
    "duration": 6,
    "maxParticipants": 12
  },
  {
    "id": 2,
    "name": "City Food Tour",
    "description": "Explore the city's best culinary spots and hidden gems",
    "location": "Downtown",
    "price": 45.00,
    "duration": 3,
    "maxParticipants": 8
  }
]
```

**Status Codes:**
- `200 OK`: Excursions retrieved successfully

---

### Get Excursion by ID

Retrieve details of a specific excursion.

**Endpoint:** `GET /api/excursions/{id}`

**Path Parameters:**
- `id` (integer, required): The unique identifier of the excursion

**Response:**
```json
{
  "id": 1,
  "name": "Mountain Hiking Adventure",
  "description": "A thrilling hike through the scenic mountain trails with breathtaking views",
  "location": "Rocky Mountains",
  "price": 75.00,
  "duration": 6,
  "maxParticipants": 12
}
```

**Status Codes:**
- `200 OK`: Excursion found and retrieved successfully
- `404 Not Found`: Excursion with specified ID does not exist

**Example Error Response:**
```json
{
  "error": "Excursion with id 999 not found"
}
```

---

### Create New Excursion

Create a new excursion.

**Endpoint:** `POST /api/excursions`

**Request Headers:**
- `Content-Type: application/json`

**Request Body:**
```json
{
  "name": "Beach Adventure",
  "description": "Relaxing day at the beautiful coastline",
  "location": "Pacific Coast",
  "price": 45.00,
  "duration": 4,
  "maxParticipants": 20
}
```

**Request Body Schema:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | Yes | Name of the excursion (max 100 characters) |
| `description` | string | Yes | Detailed description (max 500 characters) |
| `location` | string | Yes | Location where excursion takes place |
| `price` | decimal | Yes | Price per participant (must be > 0) |
| `duration` | integer | Yes | Duration in hours (must be > 0) |
| `maxParticipants` | integer | Yes | Maximum number of participants (must be > 0) |

**Response:**
```json
{
  "id": 3,
  "name": "Beach Adventure",
  "description": "Relaxing day at the beautiful coastline",
  "location": "Pacific Coast",
  "price": 45.00,
  "duration": 4,
  "maxParticipants": 20
}
```

**Status Codes:**
- `201 Created`: Excursion created successfully
- `400 Bad Request`: Invalid input data

**Example Error Response:**
```json
{
  "error": "Invalid excursion data: Name is required"
}
```

---

### Delete Excursion

Delete an existing excursion.

**Endpoint:** `DELETE /api/excursions/{id}`

**Path Parameters:**
- `id` (integer, required): The unique identifier of the excursion to delete

**Response:** No content body

**Status Codes:**
- `204 No Content`: Excursion deleted successfully
- `404 Not Found`: Excursion with specified ID does not exist

## Error Handling

The API uses standard HTTP status codes and provides descriptive error messages.

### Common Error Codes

| Status Code | Description |
|------------|-------------|
| `200 OK` | Request successful |
| `201 Created` | Resource created successfully |
| `204 No Content` | Request successful, no content to return |
| `400 Bad Request` | Invalid request data |
| `404 Not Found` | Resource not found |
| `500 Internal Server Error` | Unexpected server error |

### Error Response Format

```json
{
  "error": "Detailed error message explaining what went wrong"
}
```

## Rate Limiting

Currently, no rate limiting is implemented. This may be added in future versions.

## Examples

### cURL Examples

**Get all excursions:**
```bash
curl -X GET http://localhost:8080/api/excursions
```

**Get specific excursion:**
```bash
curl -X GET http://localhost:8080/api/excursions/1
```

**Create new excursion:**
```bash
curl -X POST http://localhost:8080/api/excursions \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Sunset Photography Tour",
    "description": "Capture stunning sunset photos",
    "location": "Scenic Overlook",
    "price": 65.00,
    "duration": 3,
    "maxParticipants": 6
  }'
```

**Delete excursion:**
```bash
curl -X DELETE http://localhost:8080/api/excursions/3
```

### JavaScript Examples

**Using fetch API:**

```javascript
// Get all excursions
const excursions = await fetch('http://localhost:8080/api/excursions')
  .then(response => response.json());

// Create new excursion
const newExcursion = await fetch('http://localhost:8080/api/excursions', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    name: 'Wine Tasting Tour',
    description: 'Sample local wines and learn about viticulture',
    location: 'Wine Valley',
    price: 85.00,
    duration: 5,
    maxParticipants: 10
  })
}).then(response => response.json());
```

## Interactive Documentation

For interactive API testing and exploration, visit the Swagger UI at:
[http://localhost:8080/docs](http://localhost:8080/docs) (when running locally)

The Swagger UI provides:
- Interactive endpoint testing
- Request/response schema validation
- Code generation examples
- OpenAPI specification download
