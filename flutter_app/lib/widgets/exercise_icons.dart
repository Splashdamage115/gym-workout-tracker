import 'package:flutter/material.dart';

class ExerciseIcon extends StatelessWidget {
  final String exerciseName;
  final double size;
  final Color? color;

  const ExerciseIcon({
    super.key,
    required this.exerciseName,
    this.size = 40,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = _getIconForExercise(exerciseName);
    final iconColor = color ?? Theme.of(context).primaryColor;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: iconColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: size * 0.5,
      ),
    );
  }

  IconData _getIconForExercise(String name) {
    final lowerName = name.toLowerCase();
    
    // Push exercises
    if (lowerName.contains('push') || lowerName.contains('press') || 
        lowerName.contains('chest')) {
      return Icons.fitness_center;
    }
    // Pull exercises
    if (lowerName.contains('pull') || lowerName.contains('row') ||
        lowerName.contains('curl')) {
      return Icons.sports_gymnastics;
    }
    // Leg exercises
    if (lowerName.contains('squat') || lowerName.contains('lunge') ||
        lowerName.contains('leg')) {
      return Icons.directions_run;
    }
    // Shoulder exercises
    if (lowerName.contains('shoulder') || lowerName.contains('raise') ||
        lowerName.contains('fly')) {
      return Icons.expand_circle_down;
    }
    // Arm exercises
    if (lowerName.contains('tricep') || lowerName.contains('bicep') ||
        lowerName.contains('dip')) {
      return Icons.swipe_vertical;
    }
    // Back exercises
    if (lowerName.contains('back') || lowerName.contains('deadlift')) {
      return Icons.sports_martial_arts;
    }
    // Core/Calf
    if (lowerName.contains('calf') || lowerName.contains('hip') ||
        lowerName.contains('abduction')) {
      return Icons.self_improvement;
    }
    
    // Default
    return Icons.fitness_center;
  }
}

class MuscleGroupIcon extends StatelessWidget {
  final String muscleGroup;
  final double size;
  final Color? color;

  const MuscleGroupIcon({
    super.key,
    required this.muscleGroup,
    this.size = 32,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = _getIconForMuscleGroup(muscleGroup);
    final iconColor = color ?? Theme.of(context).primaryColor;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            iconColor.withOpacity(0.7),
            iconColor.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(size / 4),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        iconData,
        color: Colors.white,
        size: size * 0.6,
      ),
    );
  }

  IconData _getIconForMuscleGroup(String group) {
    final lowerGroup = group.toLowerCase();
    
    if (lowerGroup.contains('chest')) return Icons.favorite;
    if (lowerGroup.contains('shoulder')) return Icons.expand_circle_down;
    if (lowerGroup.contains('tricep')) return Icons.swipe_vertical;
    if (lowerGroup.contains('back')) return Icons.sports_martial_arts;
    if (lowerGroup.contains('bicep')) return Icons.sports_gymnastics;
    if (lowerGroup.contains('quad')) return Icons.directions_run;
    if (lowerGroup.contains('hamstring')) return Icons.directions_walk;
    if (lowerGroup.contains('glute')) return Icons.self_improvement;
    if (lowerGroup.contains('calf')) return Icons.hiking;
    
    return Icons.fitness_center;
  }
}

class WorkoutTypeIcon extends StatelessWidget {
  final String workoutType;
  final double size;

  const WorkoutTypeIcon({
    super.key,
    required this.workoutType,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfigForWorkoutType(workoutType);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            config.color.withOpacity(0.7),
            config.color.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(size / 4),
        boxShadow: [
          BoxShadow(
            color: config.color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        config.icon,
        color: Colors.white,
        size: size * 0.55,
      ),
    );
  }

  ({IconData icon, Color color}) _getConfigForWorkoutType(String type) {
    switch (type.toLowerCase()) {
      case 'push':
        return (icon: Icons.fitness_center, color: Colors.red);
      case 'pull':
        return (icon: Icons.sports_gymnastics, color: Colors.blue);
      case 'legs':
        return (icon: Icons.directions_run, color: Colors.green);
      default:
        return (icon: Icons.fitness_center, color: Colors.grey);
    }
  }
}
