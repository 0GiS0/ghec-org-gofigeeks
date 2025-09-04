const Excursion = require('../models/Excursion');
const { getPool } = require('../db');

class ExcursionController {
  static async getAllExcursions(req, res) {
    try {
      const { rows } = await getPool().query('SELECT id, name, description, location, price::float AS price, duration::float AS duration, max_participants AS "maxParticipants", created_at AS "createdAt", updated_at AS "updatedAt" FROM excursions ORDER BY id');
      res.json(rows);
    } catch (error) {
      console.error('Error getting excursions:', error);
      res.status(500).json({
        error: 'Internal server error',
        message: 'Failed to retrieve excursions'
      });
    }
  }

  static async getExcursionById(req, res) {
    try {
      const id = parseInt(req.params.id, 10);
      const { rows } = await getPool().query('SELECT id, name, description, location, price::float AS price, duration::float AS duration, max_participants AS "maxParticipants", created_at AS "createdAt", updated_at AS "updatedAt" FROM excursions WHERE id = $1', [id]);
      if (rows.length === 0) {
        return res.status(404).json({
          error: 'Not found',
          message: `Excursion with id ${id} not found`
        });
      }
      res.json(rows[0]);
    } catch (error) {
      console.error('Error getting excursion by id:', error);
      res.status(500).json({
        error: 'Internal server error',
        message: 'Failed to retrieve excursion'
      });
    }
  }

  static async createExcursion(req, res) {
    try {
      const validationErrors = Excursion.validateCreateRequest(req.body);
      if (validationErrors.length > 0) {
        return res.status(400).json({
          error: 'Validation failed',
          message: 'Request validation failed',
          details: validationErrors
        });
      }
      const newExcursion = Excursion.fromRequest(req.body);
      const { rows } = await getPool().query(
        'INSERT INTO excursions (name, description, location, price, duration, max_participants) VALUES ($1,$2,$3,$4,$5,$6) RETURNING id, name, description, location, price::float AS price, duration::float AS duration, max_participants AS "maxParticipants", created_at AS "createdAt", updated_at AS "updatedAt"',
        [
          newExcursion.name,
          newExcursion.description,
          newExcursion.location,
          newExcursion.price,
          newExcursion.duration,
          newExcursion.maxParticipants
        ]
      );
      res.status(201).json(rows[0]);
    } catch (error) {
      console.error('Error creating excursion:', error);
      res.status(500).json({
        error: 'Internal server error',
        message: 'Failed to create excursion'
      });
    }
  }

  static async updateExcursion(req, res) {
    try {
      const id = parseInt(req.params.id, 10);
      const validationErrors = Excursion.validateCreateRequest(req.body);
      if (validationErrors.length > 0) {
        return res.status(400).json({
          error: 'Validation failed',
          message: 'Request validation failed',
          details: validationErrors
        });
      }
      const { rows } = await getPool().query(
        'UPDATE excursions SET name=$1, description=$2, location=$3, price=$4, duration=$5, max_participants=$6, updated_at=now() WHERE id=$7 RETURNING id, name, description, location, price::float AS price, duration::float AS duration, max_participants AS "maxParticipants", created_at AS "createdAt", updated_at AS "updatedAt"',
        [
          req.body.name,
          req.body.description,
          req.body.location,
          req.body.price,
          req.body.duration,
          req.body.maxParticipants,
          id
        ]
      );
      if (rows.length === 0) {
        return res.status(404).json({
          error: 'Not found',
          message: `Excursion with id ${id} not found`
        });
      }
      res.json(rows[0]);
    } catch (error) {
      console.error('Error updating excursion:', error);
      res.status(500).json({
        error: 'Internal server error',
        message: 'Failed to update excursion'
      });
    }
  }

  static async deleteExcursion(req, res) {
    try {
      const id = parseInt(req.params.id, 10);
      const { rowCount } = await getPool().query('DELETE FROM excursions WHERE id=$1', [id]);
      if (rowCount === 0) {
        return res.status(404).json({
          error: 'Not found',
          message: `Excursion with id ${id} not found`
        });
      }
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