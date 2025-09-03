const express = require('express');
const ExcursionController = require('../controllers/ExcursionController');

const router = express.Router();

// GET /api/excursions - Get all excursions
router.get('/', ExcursionController.getAllExcursions);

// GET /api/excursions/:id - Get excursion by ID
router.get('/:id', ExcursionController.getExcursionById);

// POST /api/excursions - Create new excursion
router.post('/', ExcursionController.createExcursion);

// PUT /api/excursions/:id - Update excursion
router.put('/:id', ExcursionController.updateExcursion);

// DELETE /api/excursions/:id - Delete excursion
router.delete('/:id', ExcursionController.deleteExcursion);

module.exports = router;