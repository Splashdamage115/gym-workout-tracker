# Gym Workout Tracker

A simple and easy-to-use command-line application for logging and tracking gym workouts. Organize your workouts by muscle groups and training days (Push/Pull/Legs split), track your progress, and review your training history.

## Features

- **Workout Logging by Day Type**: Organize workouts into Push, Pull, and Legs days with appropriate exercises for each
- **Detailed Exercise Tracking**: Log sets, weight, and reps for each exercise
- **Smart Exercise Selection**: Only shows exercises relevant to the current workout type
  - **Push Day**: Chest, Shoulders, and Triceps exercises (Push-ups, Bench Press, Shoulder Press, etc.)
  - **Pull Day**: Back and Biceps exercises (Pull-ups, Rows, Curls, etc.)
  - **Leg Day**: Quads, Hamstrings, Glutes, and Calves exercises (Squats, Lunges, etc.)
- **Workout History**: View your workout history over the last 7 days
- **Exercise Breakdown**: Get detailed breakdown of exercises performed on any day
- **Missed Muscle Groups**: Review which muscle groups you worked and which you missed
- **Persistent Storage**: All data is saved locally in JSON format

## Installation

1. Clone this repository:
```bash
git clone https://github.com/Splashdamage115/gym-workout-tracker.git
cd gym-workout-tracker
```

2. Ensure you have Python 3.6+ installed:
```bash
python3 --version
```

3. No additional dependencies needed! Uses only Python standard library.

## Usage

### Starting the Application

Run the workout tracker:
```bash
python3 workout_tracker.py
```

### Main Menu Options

1. **Log Push Day Workout** - Record exercises for chest, shoulders, and triceps
2. **Log Pull Day Workout** - Record exercises for back and biceps
3. **Log Leg Day Workout** - Record exercises for legs and glutes
4. **View Workout History** - See your workouts from the last 7 days
5. **Exercise Breakdown (Today)** - Get detailed breakdown of today's exercises
6. **Check Missed Muscle Groups (Today)** - See which muscle groups you worked/missed today
7. **Exit** - Save and exit the application

### Example: Logging a Push Day Workout

1. Select option `1` from the main menu
2. Choose exercises from the push day list
3. For each exercise, enter:
   - Weight (in kg)
   - Number of reps
   - Type 'done' when you finish all sets for that exercise
4. Select more exercises or type 'done' to finish the workout

### Example Session

```
=== PUSH DAY WORKOUT ===

Available exercises:
1. Push-ups (Chest)
2. Bench Press (Chest)
3. Shoulder Press (Shoulders)
...

Select exercise number (or 'done' to finish): 2

Logging: Bench Press

Set 1:
  Weight (kg) or 'done' to finish: 60
  Reps: 10
  Set 1 logged: 60.0kg x 10 reps

Set 2:
  Weight (kg) or 'done' to finish: 65
  Reps: 8
  Set 2 logged: 65.0kg x 8 reps
```

## Data Storage

All workout data is stored in `workout_data.json` in the same directory as the script. This file is automatically created and updated as you log workouts.

## Exercise Database

The application includes predefined exercises for each workout type:

### Push Day Exercises
- Chest: Push-ups, Bench Press, Incline Bench Press, Chest Fly
- Shoulders: Shoulder Press, Lateral Raises, Front Raises, Overhead Press
- Triceps: Tricep Dips, Tricep Extensions

### Pull Day Exercises
- Back: Pull-ups, Chin-ups, Barbell Rows, Dumbbell Rows, Lat Pulldown, Face Pulls, Deadlift
- Biceps: Bicep Curls, Hammer Curls, Preacher Curls

### Leg Day Exercises
- Quads: Squats, Leg Press, Lunges, Leg Extensions, Bulgarian Split Squats
- Hamstrings: Romanian Deadlift, Leg Curls
- Glutes: Hip Thrusts, Leg Abduction
- Calves: Calf Raises

## Features in Detail

### Workout Breakdown
Get a detailed summary of your workout including:
- Total sets per muscle group
- Total volume (weight × reps) per muscle group
- Individual set details for each exercise

### Missed Muscle Groups
Identify gaps in your training:
- See which muscle groups you trained
- Get a list of muscle groups you missed
- Plan better for balanced training

### Workout History
Review your recent training:
- See all workouts from the last 7 days
- View total volume and sets per exercise
- Track your consistency

## Contributing

Feel free to submit issues and enhancement requests!

## License

MIT License - feel free to use this for your own fitness tracking!