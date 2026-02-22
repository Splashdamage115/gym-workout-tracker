# Quick Start Guide - Gym Workout Tracker

## Installation (30 seconds)

```bash
# 1. Clone the repository
git clone https://github.com/Splashdamage115/gym-workout-tracker.git
cd gym-workout-tracker

# 2. Run the app (requires Python 3.6+)
python3 workout_tracker.py
```

That's it! No dependencies to install.

## Your First Workout (2 minutes)

### Example: Push Day

1. Run the app: `python3 workout_tracker.py`
2. Select option `1` (Log Push Day Workout)
3. You'll see exercises like:
   - Push-ups (Chest)
   - Bench Press (Chest)
   - Shoulder Press (Shoulders)
   - Tricep Dips (Triceps)

4. Select an exercise (e.g., type `2` for Bench Press)
5. Log your sets:
   - Weight: `60` (kg)
   - Reps: `10`
   - Continue adding sets or type `done`

6. Add more exercises or type `done` to finish

### Quick Demo

Want to see how it works first?
```bash
python3 demo.py
```

### View Your Progress

From the main menu:
- Option `4` - View workout history (last 7 days)
- Option `5` - See today's exercise breakdown
- Option `6` - Check which muscle groups you missed

## Workout Types

### Push Day (Option 1)
- **Chest**: Push-ups, Bench Press, Incline Bench Press, Chest Fly
- **Shoulders**: Shoulder Press, Lateral Raises, Front Raises, Overhead Press
- **Triceps**: Tricep Dips, Tricep Extensions

### Pull Day (Option 2)
- **Back**: Pull-ups, Chin-ups, Rows, Lat Pulldown, Deadlift
- **Biceps**: Bicep Curls, Hammer Curls, Preacher Curls

### Leg Day (Option 3)
- **Quads**: Squats, Leg Press, Lunges, Leg Extensions
- **Hamstrings**: Romanian Deadlift, Leg Curls
- **Glutes**: Hip Thrusts, Leg Abduction
- **Calves**: Calf Raises

## Tips

- **Bodyweight exercises**: Use `0` for weight (e.g., push-ups, pull-ups)
- **Progressive overload**: Review your history to track progress
- **Balance**: Use "Check Missed Muscle Groups" to ensure balanced training
- **Data safety**: Your data is saved in `workout_data.json` - back it up!

## Example Workflow

```
Monday (Push Day):
- Bench Press: 3 sets
- Shoulder Press: 3 sets
- Tricep Dips: 3 sets

Wednesday (Pull Day):
- Pull-ups: 3 sets
- Barbell Rows: 3 sets
- Bicep Curls: 3 sets

Friday (Leg Day):
- Squats: 4 sets
- Leg Curls: 3 sets
- Calf Raises: 3 sets
```

## Need Help?

- See the full [README.md](README.md) for detailed documentation
- Run `python3 example.py` to see programmatic usage
- Run `python3 demo.py` for an interactive demo

Happy training! 💪
