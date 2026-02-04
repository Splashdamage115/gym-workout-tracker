import 'workout_models.dart';

class ExerciseDatabase {
  static final Map<String, List<Exercise>> exercises = {
    'push': [
      // Chest exercises
      Exercise(name: 'Push-ups', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Bench Press', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Incline Bench Press', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Decline Bench Press', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Chest Fly', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Cable Crossover', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Dumbbell Press', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Incline Dumbbell Press', muscleGroup: 'Chest', workoutType: 'push'),
      Exercise(name: 'Pec Deck', muscleGroup: 'Chest', workoutType: 'push'),
      // Shoulder exercises
      Exercise(name: 'Shoulder Press', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Military Press', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Arnold Press', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Lateral Raises', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Front Raises', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Rear Delt Fly', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Overhead Press', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Upright Row', muscleGroup: 'Shoulders', workoutType: 'push'),
      Exercise(name: 'Shrugs', muscleGroup: 'Shoulders', workoutType: 'push'),
      // Tricep exercises
      Exercise(name: 'Tricep Dips', muscleGroup: 'Triceps', workoutType: 'push'),
      Exercise(name: 'Tricep Extensions', muscleGroup: 'Triceps', workoutType: 'push'),
      Exercise(name: 'Overhead Tricep Extension', muscleGroup: 'Triceps', workoutType: 'push'),
      Exercise(name: 'Skull Crushers', muscleGroup: 'Triceps', workoutType: 'push'),
      Exercise(name: 'Tricep Pushdown', muscleGroup: 'Triceps', workoutType: 'push'),
      Exercise(name: 'Close-Grip Bench Press', muscleGroup: 'Triceps', workoutType: 'push'),
      Exercise(name: 'Diamond Push-ups', muscleGroup: 'Triceps', workoutType: 'push'),
    ],
    'pull': [
      // Back exercises
      Exercise(name: 'Pull-ups', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Chin-ups', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Barbell Rows', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Dumbbell Rows', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'T-Bar Rows', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Lat Pulldown', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Cable Rows', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Face Pulls', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Deadlift', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Romanian Deadlift', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Rack Pulls', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Hyperextensions', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Straight Arm Pulldown', muscleGroup: 'Back', workoutType: 'pull'),
      Exercise(name: 'Inverted Rows', muscleGroup: 'Back', workoutType: 'pull'),
      // Bicep exercises
      Exercise(name: 'Bicep Curls', muscleGroup: 'Biceps', workoutType: 'pull'),
      Exercise(name: 'Hammer Curls', muscleGroup: 'Biceps', workoutType: 'pull'),
      Exercise(name: 'Preacher Curls', muscleGroup: 'Biceps', workoutType: 'pull'),
      Exercise(name: 'Concentration Curls', muscleGroup: 'Biceps', workoutType: 'pull'),
      Exercise(name: 'Cable Curls', muscleGroup: 'Biceps', workoutType: 'pull'),
      Exercise(name: 'Incline Dumbbell Curls', muscleGroup: 'Biceps', workoutType: 'pull'),
      Exercise(name: '21s', muscleGroup: 'Biceps', workoutType: 'pull'),
      Exercise(name: 'Zottman Curls', muscleGroup: 'Biceps', workoutType: 'pull'),
      // Forearm exercises
      Exercise(name: 'Wrist Curls', muscleGroup: 'Forearms', workoutType: 'pull'),
      Exercise(name: 'Reverse Wrist Curls', muscleGroup: 'Forearms', workoutType: 'pull'),
      Exercise(name: 'Farmers Walk', muscleGroup: 'Forearms', workoutType: 'pull'),
    ],
    'legs': [
      // Quad exercises
      Exercise(name: 'Squats', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Front Squats', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Leg Press', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Hack Squats', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Lunges', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Walking Lunges', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Leg Extensions', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Bulgarian Split Squats', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Goblet Squats', muscleGroup: 'Quads', workoutType: 'legs'),
      Exercise(name: 'Step-ups', muscleGroup: 'Quads', workoutType: 'legs'),
      // Hamstring exercises
      Exercise(name: 'Romanian Deadlift', muscleGroup: 'Hamstrings', workoutType: 'legs'),
      Exercise(name: 'Stiff-Leg Deadlift', muscleGroup: 'Hamstrings', workoutType: 'legs'),
      Exercise(name: 'Leg Curls', muscleGroup: 'Hamstrings', workoutType: 'legs'),
      Exercise(name: 'Seated Leg Curls', muscleGroup: 'Hamstrings', workoutType: 'legs'),
      Exercise(name: 'Good Mornings', muscleGroup: 'Hamstrings', workoutType: 'legs'),
      Exercise(name: 'Nordic Curls', muscleGroup: 'Hamstrings', workoutType: 'legs'),
      // Glute exercises
      Exercise(name: 'Hip Thrusts', muscleGroup: 'Glutes', workoutType: 'legs'),
      Exercise(name: 'Glute Bridge', muscleGroup: 'Glutes', workoutType: 'legs'),
      Exercise(name: 'Cable Kickbacks', muscleGroup: 'Glutes', workoutType: 'legs'),
      Exercise(name: 'Leg Abduction', muscleGroup: 'Glutes', workoutType: 'legs'),
      Exercise(name: 'Donkey Kicks', muscleGroup: 'Glutes', workoutType: 'legs'),
      Exercise(name: 'Fire Hydrants', muscleGroup: 'Glutes', workoutType: 'legs'),
      // Calf exercises
      Exercise(name: 'Calf Raises', muscleGroup: 'Calves', workoutType: 'legs'),
      Exercise(name: 'Seated Calf Raises', muscleGroup: 'Calves', workoutType: 'legs'),
      Exercise(name: 'Donkey Calf Raises', muscleGroup: 'Calves', workoutType: 'legs'),
      Exercise(name: 'Single-Leg Calf Raises', muscleGroup: 'Calves', workoutType: 'legs'),
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
  
  static int getTotalExerciseCount() {
    return exercises.values.fold(0, (sum, list) => sum + list.length);
  }
  
  static Map<String, int> getExerciseCountByType() {
    return exercises.map((key, value) => MapEntry(key, value.length));
  }
}

