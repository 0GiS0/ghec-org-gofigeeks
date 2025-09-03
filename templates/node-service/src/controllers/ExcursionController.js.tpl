const Excursion = require('../models/Excursion');

// In-memory storage for demonstration purposes
// In a real application, this would be replaced with a proper database
let excursions = [
  new Excursion(1, 'Mountain Hiking Adventure', 'A thrilling hike through the scenic mountain trails with breathtaking views', 'Rocky Mountains', 75.00, 6, 12),
  new Excursion(2, 'City Food Tour', 'Explore the best local cuisine and hidden food gems in the city', 'Downtown', 45.00, 3, 8)
];
let nextId = 3;

class ExcursionController {
  static getAllExcursions(req, res) {
    try {
      console.log('Getting all excursions');
      res.json(excursions);
    } catch (error) {
      console.error('Error getting excursions:', error);
      res.status(500).json({ 
        error: 'Internal server error',
        message: 'Failed to retrieve excursions'
      });
    }
  }

  static getExcursionById(req, res) {
    try {
      const id = parseInt(req.params.id);
      console.log(`Getting excursion with id: ${id}`);
      
      const excursion = excursions.find(e => e.id === id);
      
      if (!excursion) {
        console.log(`Excursion with id ${id} not found`);
        return res.status(404).json({ 
          error: 'Not found',
          message: `Excursion with id ${id} not found`
        });
      }

      res.json(excursion);
    } catch (error) {
      console.error('Error getting excursion by id:', error);
      res.status(500).json({ 
        error: 'Internal server error',
        message: 'Failed to retrieve excursion'
      });
    }
  }

  static createExcursion(req, res) {
    try {
      console.log('Creating new excursion:', req.body);
      
      const validationErrors = Excursion.validateCreateRequest(req.body);
      if (validationErrors.length > 0) {
        return res.status(400).json({
          error: 'Validation failed',
          message: 'Request validation failed',
          details: validationErrors
        });
      }

      const newExcursion = Excursion.fromRequest(req.body);
      newExcursion.id = nextId++;
      
      excursions.push(newExcursion);
      
      console.log(`Created excursion with id: ${newExcursion.id}`);
      res.status(201).json(newExcursion);
    } catch (error) {
      console.error('Error creating excursion:', error);
      res.status(500).json({ 
        error: 'Internal server error',
        message: 'Failed to create excursion'
      });
    }
  }

  static updateExcursion(req, res) {
    try {
      const id = parseInt(req.params.id);
      console.log(`Updating excursion with id: ${id}`);
      
      const excursion = excursions.find(e => e.id === id);
      
      if (!excursion) {
        console.log(`Excursion with id ${id} not found for update`);
        return res.status(404).json({ 
          error: 'Not found',
          message: `Excursion with id ${id} not found`
        });
      }

      const validationErrors = Excursion.validateCreateRequest(req.body);
      if (validationErrors.length > 0) {
        return res.status(400).json({
          error: 'Validation failed',
          message: 'Request validation failed',
          details: validationErrors
        });
      }

      excursion.updateFromRequest(req.body);
      
      console.log(`Updated excursion with id: ${id}`);
      res.json(excursion);
    } catch (error) {
      console.error('Error updating excursion:', error);
      res.status(500).json({ 
        error: 'Internal server error',
        message: 'Failed to update excursion'
      });
    }
  }

  static deleteExcursion(req, res) {
    try {
      const id = parseInt(req.params.id);
      console.log(`Deleting excursion with id: ${id}`);
      
      const excursionIndex = excursions.findIndex(e => e.id === id);
      
      if (excursionIndex === -1) {
        console.log(`Excursion with id ${id} not found for deletion`);
        return res.status(404).json({ 
          error: 'Not found',
          message: `Excursion with id ${id} not found`
        });
      }

      excursions.splice(excursionIndex, 1);
      
      console.log(`Deleted excursion with id: ${id}`);
      res.status(204).send();
    } catch (error) {
      console.error('Error deleting excursion:', error);
      res.status(500).json({ 
        error: 'Internal server error',
        message: 'Failed to delete excursion'
      });
    }
  }
}

module.exports = ExcursionController;