const request = require('supertest');
const app = require('../src/index');

describe('${{values.name}} API', () => {
  describe('GET /', () => {
    test('should return service information with API endpoints', async () => {
      const response = await request(app)
        .get('/')
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toHaveProperty('service', '${{values.name}}');
      expect(response.body).toHaveProperty('message', 'Welcome to the Excursions API');
      expect(response.body).toHaveProperty('endpoints');
      expect(response.body).toHaveProperty('excursionEndpoints');
      expect(response.body.endpoints).toHaveProperty('excursions', '/api/excursions');
    });
  });

  describe('GET /health', () => {
    test('should return health status', async () => {
      const response = await request(app)
        .get('/health')
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toHaveProperty('status', 'OK');
      expect(response.body).toHaveProperty('service', '${{values.name}}');
      expect(response.body).toHaveProperty('timestamp');
      expect(response.body).toHaveProperty('version');
    });
  });

  describe('GET /api/hello', () => {
    test('should return hello message', async () => {
      const response = await request(app)
        .get('/api/hello')
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toHaveProperty('message', 'Hello from ${{values.name}}!');
      expect(response.body).toHaveProperty('timestamp');
    });
  });

  describe('GET /api/status', () => {
    test('should return service status', async () => {
      const response = await request(app)
        .get('/api/status')
        .expect('Content-Type', /json/)
        .expect(200);

      expect(response.body).toHaveProperty('service', '${{values.name}}');
      expect(response.body).toHaveProperty('status', 'running');
      expect(response.body).toHaveProperty('uptime');
      expect(response.body).toHaveProperty('memory');
      expect(response.body).toHaveProperty('environment');
    });
  });

  describe('Excursions API', () => {
    describe('GET /api/excursions', () => {
      test('should return list of excursions', async () => {
        const response = await request(app)
          .get('/api/excursions')
          .expect('Content-Type', /json/)
          .expect(200);

        expect(Array.isArray(response.body)).toBe(true);
        expect(response.body.length).toBeGreaterThanOrEqual(2); // Default excursions
        
        const firstExcursion = response.body[0];
        expect(firstExcursion).toHaveProperty('id');
        expect(firstExcursion).toHaveProperty('name');
        expect(firstExcursion).toHaveProperty('description');
        expect(firstExcursion).toHaveProperty('location');
        expect(firstExcursion).toHaveProperty('price');
        expect(firstExcursion).toHaveProperty('duration');
        expect(firstExcursion).toHaveProperty('maxParticipants');
      });
    });

    describe('GET /api/excursions/:id', () => {
      test('should return specific excursion by id', async () => {
        const response = await request(app)
          .get('/api/excursions/1')
          .expect('Content-Type', /json/)
          .expect(200);

        expect(response.body).toHaveProperty('id', 1);
        expect(response.body).toHaveProperty('name');
        expect(response.body).toHaveProperty('location');
      });

      test('should return 404 for non-existent excursion', async () => {
        const response = await request(app)
          .get('/api/excursions/999')
          .expect('Content-Type', /json/)
          .expect(404);

        expect(response.body).toHaveProperty('error', 'Not found');
      });
    });

    describe('POST /api/excursions', () => {
      test('should create new excursion', async () => {
        const newExcursion = {
          name: 'Beach Walking Tour',
          description: 'A relaxing walk along beautiful beaches',
          location: 'Coastal Area',
          price: 35.00,
          duration: 2,
          maxParticipants: 15
        };

        const response = await request(app)
          .post('/api/excursions')
          .send(newExcursion)
          .expect('Content-Type', /json/)
          .expect(201);

        expect(response.body).toHaveProperty('id');
        expect(response.body).toHaveProperty('name', 'Beach Walking Tour');
        expect(response.body).toHaveProperty('location', 'Coastal Area');
        expect(response.body).toHaveProperty('price', 35.00);
        expect(response.body).toHaveProperty('createdAt');
        expect(response.body).toHaveProperty('updatedAt');
      });

      test('should return validation error for missing required fields', async () => {
        const invalidExcursion = {
          name: '', // Empty name
          description: 'Test description',
          location: '', // Empty location
          price: -10, // Invalid price
          duration: 0, // Invalid duration
          maxParticipants: 0 // Invalid maxParticipants
        };

        const response = await request(app)
          .post('/api/excursions')
          .send(invalidExcursion)
          .expect('Content-Type', /json/)
          .expect(400);

        expect(response.body).toHaveProperty('error', 'Validation failed');
        expect(response.body).toHaveProperty('details');
        expect(Array.isArray(response.body.details)).toBe(true);
      });
    });

    describe('PUT /api/excursions/:id', () => {
      test('should update existing excursion', async () => {
        const updatedData = {
          name: 'Updated Mountain Adventure',
          description: 'Updated description for mountain hiking',
          location: 'Updated Rocky Mountains',
          price: 85.00,
          duration: 7,
          maxParticipants: 10
        };

        const response = await request(app)
          .put('/api/excursions/1')
          .send(updatedData)
          .expect('Content-Type', /json/)
          .expect(200);

        expect(response.body).toHaveProperty('id', 1);
        expect(response.body).toHaveProperty('name', 'Updated Mountain Adventure');
        expect(response.body).toHaveProperty('price', 85.00);
        expect(response.body).toHaveProperty('updatedAt');
      });

      test('should return 404 for non-existent excursion', async () => {
        const updatedData = {
          name: 'Updated Name',
          description: 'Updated description',
          location: 'Updated location',
          price: 50.00,
          duration: 3,
          maxParticipants: 8
        };

        const response = await request(app)
          .put('/api/excursions/999')
          .send(updatedData)
          .expect('Content-Type', /json/)
          .expect(404);

        expect(response.body).toHaveProperty('error', 'Not found');
      });
    });

    describe('DELETE /api/excursions/:id', () => {
      test('should delete excursion', async () => {
        // First create an excursion to delete
        const newExcursion = {
          name: 'Test Excursion for Deletion',
          description: 'This will be deleted',
          location: 'Test Location',
          price: 25.00,
          duration: 1,
          maxParticipants: 5
        };

        const createResponse = await request(app)
          .post('/api/excursions')
          .send(newExcursion)
          .expect(201);

        const excursionId = createResponse.body.id;

        // Now delete it
        await request(app)
          .delete(`/api/excursions/${excursionId}`)
          .expect(204);

        // Verify it's gone
        await request(app)
          .get(`/api/excursions/${excursionId}`)
          .expect(404);
      });

      test('should return 404 for non-existent excursion', async () => {
        const response = await request(app)
          .delete('/api/excursions/999')
          .expect('Content-Type', /json/)
          .expect(404);

        expect(response.body).toHaveProperty('error', 'Not found');
      });
    });
  });

  describe('GET /nonexistent', () => {
    test('should return 404 for non-existent routes', async () => {
      const response = await request(app)
        .get('/nonexistent')
        .expect('Content-Type', /json/)
        .expect(404);

      expect(response.body).toHaveProperty('error', 'Not Found');
    });
  });
});