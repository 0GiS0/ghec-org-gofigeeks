# Excursions API Reference

Welcome to the Excursions API documentation. This API provides comprehensive excursion management functionality, allowing you to create, read, update, and delete excursions.

## Base URL

```
Production: https://your-production-url.com/api
Staging: https://your-staging-url.com/api
Development: http://localhost:PORT/api
```

## Authentication

Currently, this API does not require authentication for demonstration purposes. In a production environment, you would typically use API keys or OAuth tokens.

```bash
# No authentication required for demo
curl -X GET "https://api.example.com/api/excursions"
```

## Common Headers

All API requests should include these headers:

```http
Content-Type: application/json
Accept: application/json
```

## Response Format

All API responses follow a consistent JSON format:

### Success Response

```json
{
  "success": true,
  "data": {
    // Response data here
  },
  "message": "Operation completed successfully"
}
```

### Error Response

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": "Additional error details"
  }
}
```

## Status Codes

| Code | Description |
|------|-------------|
| 200 | OK - Request successful |
| 201 | Created - Resource created successfully |
| 400 | Bad Request - Invalid request parameters |
| 401 | Unauthorized - Authentication required |
| 403 | Forbidden - Insufficient permissions |
| 404 | Not Found - Resource not found |
| 422 | Unprocessable Entity - Validation failed |
| 429 | Too Many Requests - Rate limit exceeded |
| 500 | Internal Server Error - Server error |

## Health Check

### GET /health

Check the health status of the API.

**Response:**

```json
{
  "status": "OK",
  "service": "${{values.name}}",
  "timestamp": "2023-12-01T12:00:00Z",
  "version": "1.0.0"
}
```

## Excursions API

### Data Models

#### Excursion Object

```json
{
  "id": 1,
  "name": "Mountain Hiking Adventure",
  "description": "A thrilling hike through the scenic mountain trails with breathtaking views",
  "location": "Rocky Mountains",
  "price": 75.00,
  "duration": 6,
  "maxParticipants": 12,
  "createdAt": "2023-12-01T12:00:00Z",
  "updatedAt": "2023-12-01T12:00:00Z"
}
```

#### Create/Update Request

```json
{
  "name": "Mountain Hiking Adventure",
  "description": "A thrilling hike through the scenic mountain trails with breathtaking views",
  "location": "Rocky Mountains",
  "price": 75.00,
  "duration": 6,
  "maxParticipants": 12
}
```

### Endpoints

#### GET /api/excursions

Get a list of all excursions.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `limit` | number | No | Maximum number of results (default: 100) |
| `offset` | number | No | Number of results to skip (default: 0) |
| `location` | string | No | Filter by location |
| `maxPrice` | number | No | Filter by maximum price |

**Example Request:**

```bash
curl -X GET "https://api.example.com/api/excursions?limit=10&location=Mountain"
```

**Example Response:**

```json
[
  {
    "id": 1,
    "name": "Mountain Hiking Adventure",
    "description": "A thrilling hike through the scenic mountain trails with breathtaking views",
    "location": "Rocky Mountains",
    "price": 75.00,
    "duration": 6,
    "maxParticipants": 12,
    "createdAt": "2023-12-01T12:00:00Z",
    "updatedAt": "2023-12-01T12:00:00Z"
  },
  {
    "id": 2,
    "name": "City Food Tour",
    "description": "Explore the best local cuisine and hidden food gems in the city",
    "location": "Downtown",
    "price": 45.00,
    "duration": 3,
    "maxParticipants": 8,
    "createdAt": "2023-12-01T11:00:00Z",
    "updatedAt": "2023-12-01T11:00:00Z"
  }
]
```

#### GET /api/excursions/{id}

Get a specific excursion by ID.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | number | Yes | Excursion identifier |

**Example Request:**

```bash
curl -X GET "https://api.example.com/api/excursions/1"
```

**Example Response:**

```json
{
  "id": 1,
  "name": "Mountain Hiking Adventure",
  "description": "A thrilling hike through the scenic mountain trails with breathtaking views",
  "location": "Rocky Mountains",
  "price": 75.00,
  "duration": 6,
  "maxParticipants": 12,
  "createdAt": "2023-12-01T12:00:00Z",
  "updatedAt": "2023-12-01T12:00:00Z"
}
```

#### POST /api/excursions

Create a new excursion.

**Request Body:**

```json
{
  "name": "Beach Walking Tour",
  "description": "A relaxing walk along beautiful beaches with stunning ocean views",
  "location": "Coastal Area",
  "price": 35.00,
  "duration": 2,
  "maxParticipants": 15
}
```

**Example Request:**

```bash
curl -X POST "https://api.example.com/api/excursions" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Beach Walking Tour",
    "description": "A relaxing walk along beautiful beaches with stunning ocean views",
    "location": "Coastal Area",
    "price": 35.00,
    "duration": 2,
    "maxParticipants": 15
  }'
```

**Example Response:**

```json
{
  "id": 3,
  "name": "Beach Walking Tour",
  "description": "A relaxing walk along beautiful beaches with stunning ocean views",
  "location": "Coastal Area",
  "price": 35.00,
  "duration": 2,
  "maxParticipants": 15,
  "createdAt": "2023-12-01T13:00:00Z",
  "updatedAt": "2023-12-01T13:00:00Z"
}
```

#### PUT /api/excursions/{id}

Update an existing excursion.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | number | Yes | Excursion identifier |

**Request Body:**

```json
{
  "name": "Updated Mountain Adventure",
  "description": "An enhanced mountain hiking experience with new trails",
  "location": "Rocky Mountains National Park",
  "price": 85.00,
  "duration": 7,
  "maxParticipants": 10
}
```

#### DELETE /api/excursions/{id}

Delete a specific excursion.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | number | Yes | Excursion identifier |

**Example Request:**

```bash
curl -X DELETE "https://api.example.com/api/excursions/1"
```

**Response:** 
- Status: 204 No Content (empty response body)

## Validation Rules

### Excursion Validation

- **name**: Required, must be a non-empty string
- **description**: Optional string
- **location**: Required, must be a non-empty string  
- **price**: Required, must be a positive number
- **duration**: Required, must be a positive integer (hours)
- **maxParticipants**: Required, must be a positive integer

### Error Examples

**Validation Error Response:**

```json
{
  "error": "Validation failed",
  "message": "Request validation failed",
  "details": [
    "Name is required",
    "Price must be greater than 0",
    "Duration must be greater than 0"
  ]
}
```

**Not Found Error Response:**

```json
{
  "error": "Not found", 
  "message": "Excursion with id 999 not found"
}
```

## Rate Limiting

API requests are rate limited to prevent abuse:

- **Per minute**: 60 requests
- **Per hour**: 1000 requests

When you exceed the rate limit, you'll receive a `429 Too Many Requests` response.

## AI Assistant Integration

The API also provides AI-powered excursion recommendations:

### POST /ai/chat

Chat with the AI assistant for excursion recommendations.

**Request:**
```json
{
  "message": "I want a mountain hiking adventure for beginners",
  "context": ""
}
```

**Response:**
```json
{
  "response": "I found perfect beginner-friendly mountain excursions for you!",
  "confidence": 0.9,
  "suggestedExcursions": [
    {
      "id": 1,
      "name": "Mountain Hiking Adventure",
      "difficulty": "moderate"
    }
  ]
}
```

### POST /ai/recommend

Get personalized excursion recommendations.

**Request:**
```json
{
  "budget": 100,
  "difficulty": "easy",
  "interests": ["food", "culture"],
  "season": "summer"
}
```

## Testing

Use these endpoints for testing your integration:

- **Health Check**: `GET /health`
- **Sample Excursions**: `GET /api/excursions` 
- **AI Chat**: `POST /ai/chat` with message "hello"

## Support

For API support, please contact:
- **Email**: api-support@example.com
- **Documentation**: https://docs.example.com
- **Status Page**: https://status.example.com

## Base URL

```
Production: https://your-production-url.com/api
Staging: https://your-staging-url.com/api
Development: http://localhost:PORT/api
```

## Authentication

Describe how authentication works for your API:

### API Keys

```http
Authorization: Bearer your-api-key-here
```

### OAuth 2.0

```http
Authorization: Bearer your-oauth-token-here
```

## Common Headers

All API requests should include these headers:

```http
Content-Type: application/json
Accept: application/json
Authorization: Bearer your-token-here
```

## Response Format

All API responses follow this standard format:

### Success Response

```json
{
  "success": true,
  "data": {
    // Response data here
  },
  "message": "Operation completed successfully"
}
```

### Error Response

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": "Additional error details"
  }
}
```

## Status Codes

| Code | Description |
|------|-------------|
| 200 | OK - Request successful |
| 201 | Created - Resource created successfully |
| 400 | Bad Request - Invalid request parameters |
| 401 | Unauthorized - Authentication required |
| 403 | Forbidden - Insufficient permissions |
| 404 | Not Found - Resource not found |
| 429 | Too Many Requests - Rate limit exceeded |
| 500 | Internal Server Error - Server error |

## Health Check

### GET /health

Check the health status of the API.

**Response:**

```json
{
  "success": true,
  "data": {
    "status": "healthy",
    "timestamp": "2023-12-01T12:00:00Z",
    "version": "1.0.0"
  }
}
```

## API Endpoints

### Resource Management

#### GET /resource

Get a list of resources.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `page` | integer | No | Page number (default: 1) |
| `limit` | integer | No | Items per page (default: 10, max: 100) |
| `filter` | string | No | Filter criteria |

**Example Request:**

```bash
curl -X GET "https://api.example.com/resource?page=1&limit=20" \
  -H "Authorization: Bearer your-token-here"
```

**Example Response:**

```json
{
  "success": true,
  "data": {
    "items": [
      {
        "id": "123",
        "name": "Resource Name",
        "created_at": "2023-12-01T12:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 100,
      "pages": 5
    }
  }
}
```

#### GET /resource/{id}

Get a specific resource by ID.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | string | Yes | Resource identifier |

**Example Request:**

```bash
curl -X GET "https://api.example.com/resource/123" \
  -H "Authorization: Bearer your-token-here"
```

**Example Response:**

```json
{
  "success": true,
  "data": {
    "id": "123",
    "name": "Resource Name",
    "description": "Resource description",
    "created_at": "2023-12-01T12:00:00Z",
    "updated_at": "2023-12-01T12:00:00Z"
  }
}
```

#### POST /resource

Create a new resource.

**Request Body:**

```json
{
  "name": "New Resource",
  "description": "Resource description"
}
```

**Example Request:**

```bash
curl -X POST "https://api.example.com/resource" \
  -H "Authorization: Bearer your-token-here" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "New Resource",
    "description": "Resource description"
  }'
```

**Example Response:**

```json
{
  "success": true,
  "data": {
    "id": "124",
    "name": "New Resource",
    "description": "Resource description",
    "created_at": "2023-12-01T12:00:00Z"
  },
  "message": "Resource created successfully"
}
```

#### PUT /resource/{id}

Update an existing resource.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | string | Yes | Resource identifier |

**Request Body:**

```json
{
  "name": "Updated Resource Name",
  "description": "Updated description"
}
```

#### DELETE /resource/{id}

Delete a specific resource.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `id` | string | Yes | Resource identifier |

**Example Response:**

```json
{
  "success": true,
  "message": "Resource deleted successfully"
}
```

## Rate Limiting

API requests are rate limited to prevent abuse:

- **Authenticated requests:** 1000 requests per hour
- **Unauthenticated requests:** 100 requests per hour

Rate limit headers are included in all responses:

```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1635724800
```

## Pagination

For endpoints that return lists, pagination is handled via query parameters:

- `page`: Page number (starting from 1)
- `limit`: Number of items per page (default: 10, max: 100)

## Error Handling

### Validation Errors

When request validation fails:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": {
      "field_name": ["Field is required", "Field must be a string"]
    }
  }
}
```

### Common Error Codes

| Code | Description |
|------|-------------|
| `VALIDATION_ERROR` | Request validation failed |
| `RESOURCE_NOT_FOUND` | Requested resource not found |
| `UNAUTHORIZED` | Authentication failed |
| `FORBIDDEN` | Insufficient permissions |
| `RATE_LIMIT_EXCEEDED` | Too many requests |

## SDKs and Libraries

### JavaScript/TypeScript

```bash
npm install your-api-client
```

```javascript
import { ApiClient } from 'your-api-client';

const client = new ApiClient({
  apiKey: 'your-api-key',
  baseUrl: 'https://api.example.com'
});
```

### Python

```bash
pip install your-api-client
```

```python
from your_api_client import ApiClient

client = ApiClient(
    api_key='your-api-key',
    base_url='https://api.example.com'
)
```

## Testing

Use these endpoints for testing your integration:

- **Sandbox URL:** `https://sandbox-api.example.com`
- **Test API Key:** Contact the platform team for test credentials

## Support

- **API Documentation:** This document
- **Technical Support:** Contact ${{values.owner}}
- **Platform Issues:** Contact the platform team
- **Bug Reports:** Create an issue in the repository