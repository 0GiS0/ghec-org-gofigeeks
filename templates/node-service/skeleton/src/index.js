const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const excursionRoutes = require('./routes/excursions');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
  status: 'OK',
  service: 'BACKSTAGE_ENTITY_NAME',
    timestamp: new Date().toISOString(),
  version: '1.0.0'
  });
});

// API routes
app.get('/api/hello', (req, res) => {
  res.json({
  message: 'Hello from BACKSTAGE_ENTITY_NAME!',
    timestamp: new Date().toISOString(),
  });
});

app.get('/api/status', (req, res) => {
  res.json({
  service: 'BACKSTAGE_ENTITY_NAME',
  status: 'running',
    uptime: process.uptime(),
    memory: process.memoryUsage(),
  environment: process.env.NODE_ENV || 'development'
  });
});

// Excursions API routes
app.use('/api/excursions', excursionRoutes);

// Root endpoint with API information
app.get('/', (req, res) => {
  res.json({
    service: 'BACKSTAGE_ENTITY_NAME',
    message: 'Welcome to the Excursions API',
    version: '1.0.0',
    endpoints: {
      health: '/health',
      hello: '/api/hello',
      status: '/api/status',
      excursions: '/api/excursions'
    },
    excursionEndpoints: {
      getAllExcursions: 'GET /api/excursions',
      getExcursionById: 'GET /api/excursions/:id',
      createExcursion: 'POST /api/excursions',
      updateExcursion: 'PUT /api/excursions/:id',
      deleteExcursion: 'DELETE /api/excursions/:id'
    },
  });
});

// Error handling middleware
app.use((err, req, res, _next) => {
  console.error(err.stack);
  res.status(500).json({
    error: 'Something went wrong!',
    message:
      process.env.NODE_ENV === 'development'
        ? err.message
        : 'Internal server error'
  });
});

// 404 handler (Express 5: avoid using '*' which breaks with path-to-regexp v8)
app.use((req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: `Route ${req.originalUrl} not found`
  });
});

// Start server only if not in test environment
if (process.env.NODE_ENV !== 'test' && require.main === module) {
  app.listen(PORT, () => {
  console.log(`🚀 BACKSTAGE_ENTITY_NAME server running on port ${PORT}`);
  console.log(`📋 Health check: http://localhost:${PORT}/health`);
  console.log(`🔧 API endpoints: http://localhost:${PORT}/api/hello`);
  console.log(`🎯 Excursions API: http://localhost:${PORT}/api/excursions`);
  });
}

module.exports = app;
