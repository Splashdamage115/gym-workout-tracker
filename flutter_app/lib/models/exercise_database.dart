import 'workout_models.dart';

class ExerciseDatabase {
  static final Map<String, List<Exercise>> exercises = {
    'push': [
      Exercise(name: 'Push-ups', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Bench Press', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Incline Bench Press', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Chest Fly', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Shoulder Press', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Lateral Raises', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Front Raises', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Tricep Dips', muscleGroup: 'Triceps', workoutType: 'push'),
      Exercise(name: 'Tricep Extensions', muscleGroup: 'Triceps', workoutType: 'push'),
      Exercise(name: 'Overhead Press', muscleGroup: 'Shoulders', workoutType: 'push'),
    ],
    'pull': [
      Exercise(name: 'Pull-ups', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Chin-ups', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Barbell Rows', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Dumbbell Rows', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Lat Pulldown', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Face Pulls', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Bicep Curls', muscleGroup: 'Biceps', workoutType: 'pull'),
      Exercise(name: 'Hammer Curls', muscleGroup: 'Biceps', workoutType: 'pull'),
      Exercise(name: 'Preacher Curls', muscleGroup: 'Biceps', workoutType: 'pull'),
      Exercise(name: 'Deadlift', muscleGroup: 'Back', workoutType: 'pull'),
    ],
    'legs': [
      Exercise(name: 'Squats', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Leg Press', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Lunges', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Leg Extensions', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Romanian Deadlift', muscleGroup: 'Hamstrings', workoutType: 'legs'),
      Exercise(name: 'Leg Curls', muscleGroup: 'Hamstrings', workoutType: 'legs'),
      Exercise(name: 'Calf Raises', muscleGroup: 'Calves', workoutType: 'legs'),
      Exercise(name: 'Bulgarian Split Squats', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Hip Thrusts', muscleGroup: 'Glutes', workoutType: 'legs'),
      Exercise(name: 'Leg Abduction', muscleGroup: 'Glutes', workoutType: 'legs'),
    ],
  };

  static List<Exercise> getExercisesByType(String workoutType) {
    return exercises[workoutType] ?? [];
  }

  static Set<String> getAllMuscleGroups() {
    final Set<String> muscleGroups = {};
    exercises.values.forEach((exerciseList) {
      for (var exercise in exerciseList) {
        muscleGroups.add(exercise.muscleGroup);
      }
    });
    return muscleGroups;
  }
}
