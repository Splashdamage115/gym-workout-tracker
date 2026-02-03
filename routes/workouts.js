const express = require('express');
const db = require('../database');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

// All workout routes require authentication
router.use(authenticateToken);

// Create new workout
router.post('/', (req, res) => {
  const { exercise_name, sets, reps, weight, duration, notes, workout_date } = req.body;
  const user_id = req.user.id;

  if (!exercise_name) {
    return res.status(400).json({ error: 'Exercise name is required' });
  }

  const date = workout_date || new Date().toISOString();

  db.run(
    `INSERT INTO workouts (user_id, exercise_name, sets, reps, weight, duration, notes, workout_date)
     VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
    [user_id, exercise_name, sets, reps, weight, duration, notes, date],
    function(err) {
      if (err) {
        return res.status(500).json({ error: 'Failed to create workout' });
      }

      res.status(201).json({
        message: 'Workout logged successfully',
        workoutId: this.lastID
      });
    }
  );
});

// Get all workouts for the authenticated user
router.get('/', (req, res) => {
  const user_id = req.user.id;
  const { limit = 50, offset = 0 } = req.query;

  db.all(
    `SELECT * FROM workouts WHERE user_id = ? ORDER BY workout_date DESC LIMIT ? OFFSET ?`,
    [user_id, parseInt(limit), parseInt(offset)],
    (err, workouts) => {
      if (err) {
        return res.status(500).json({ error: 'Failed to fetch workouts' });
      }

      res.json({ workouts });
    }
  );
});

// Get a specific workout
router.get('/:id', (req, res) => {
  const { id } = req.params;
  const user_id = req.user.id;

  db.get(
    'SELECT * FROM workouts WHERE id = ? AND user_id = ?',
    [id, user_id],
    (err, workout) => {
      if (err) {
        return res.status(500).json({ error: 'Database error' });
      }

      if (!workout) {
        return res.status(404).json({ error: 'Workout not found' });
      }

      res.json({ workout });
    }
  );
});

// Update a workout
router.put('/:id', (req, res) => {
  const { id } = req.params;
  const user_id = req.user.id;
  const { exercise_name, sets, reps, weight, duration, notes, workout_date } = req.body;

  // Build update query dynamically based on provided fields
  const updates = [];
  const values = [];

  if (exercise_name !== undefined) {
    updates.push('exercise_name = ?');
    values.push(exercise_name);
  }
  if (sets !== undefined) {
    updates.push('sets = ?');
    values.push(sets);
  }
  if (reps !== undefined) {
    updates.push('reps = ?');
    values.push(reps);
  }
  if (weight !== undefined) {
    updates.push('weight = ?');
    values.push(weight);
  }
  if (duration !== undefined) {
    updates.push('duration = ?');
    values.push(duration);
  }
  if (notes !== undefined) {
    updates.push('notes = ?');
    values.push(notes);
  }
  if (workout_date !== undefined) {
    updates.push('workout_date = ?');
    values.push(workout_date);
  }

  if (updates.length === 0) {
    return res.status(400).json({ error: 'No fields to update' });
  }

  values.push(id, user_id);

  db.run(
    `UPDATE workouts SET ${updates.join(', ')} WHERE id = ? AND user_id = ?`,
    values,
    function(err) {
      if (err) {
        return res.status(500).json({ error: 'Failed to update workout' });
      }

      if (this.changes === 0) {
        return res.status(404).json({ error: 'Workout not found' });
      }

      res.json({ message: 'Workout updated successfully' });
    }
  );
});

// Delete a workout
router.delete('/:id', (req, res) => {
  const { id } = req.params;
  const user_id = req.user.id;

  db.run(
    'DELETE FROM workouts WHERE id = ? AND user_id = ?',
    [id, user_id],
    function(err) {
      if (err) {
        return res.status(500).json({ error: 'Failed to delete workout' });
      }

      if (this.changes === 0) {
        return res.status(404).json({ error: 'Workout not found' });
      }

      res.json({ message: 'Workout deleted successfully' });
    }
  );
});

module.exports = router;
