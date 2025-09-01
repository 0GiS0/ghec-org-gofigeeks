const request = require('supertest');
const app = require('../src/index');

describe('${{values.name}} API', () => {
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