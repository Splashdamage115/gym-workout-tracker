class Exercise {
  final String name;
  final String muscleGroup;
  final String workoutType;

  Exercise({
    required this.name,
    required this.muscleGroup,
    required this.workoutType,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'muscleGroup': muscleGroup,
      'workoutType': workoutType,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      muscleGroup: json['muscleGroup'],
      workoutType: json['workoutType'],
    );
  }
}

class WorkoutSet {
  final double weight;
  final int reps;

  WorkoutSet({
    required this.weight,
    required this.reps,
  });

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'reps': reps,
    };
  }

  factory WorkoutSet.fromJson(Map<String, dynamic> json) {
    return WorkoutSet(
      weight: (json['weight'] as num).toDouble(),
      reps: json['reps'],
    );
  }
}

class WorkoutLog {
  final String exerciseName;
  final String muscleGroup;
  final String workoutType;
  final DateTime date;
  final List<WorkoutSet> sets;

  WorkoutLog({
    required this.exerciseName,
    required this.muscleGroup,
    required this.workoutType,
    required this.date,
    required this.sets,
  });

  Map<String, dynamic> toJson() {
    return {
      'exerciseName': exerciseName,
      'muscleGroup': muscleGroup,
      'workoutType': workoutType,
      'date': date.toIso8601String(),
      'sets': sets.map((s) => s.toJson()).toList(),
    };
  }

  factory WorkoutLog.fromJson(Map<String, dynamic> json) {
    return WorkoutLog(
      exerciseName: json['exerciseName'],
      muscleGroup: json['muscleGroup'],
      workoutType: json['workoutType'],
      date: DateTime.parse(json['date']),
      sets: (json['sets'] as List)
          .map((s) => WorkoutSet.fromJson(s))
          .toList(),
    );
  }

  double get totalVolume {
    return sets.fold(0, (sum, set) => sum + (set.weight * set.reps));
  }
}
