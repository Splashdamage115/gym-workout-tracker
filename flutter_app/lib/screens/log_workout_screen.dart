import 'package:flutter/material.dart';
import '../models/workout_models.dart';
import '../models/exercise_database.dart';
import '../services/workout_storage_service.dart';

class LogWorkoutScreen extends StatefulWidget {
  final String workoutType;

  const LogWorkoutScreen({super.key, required this.workoutType});

  @override
  State<LogWorkoutScreen> createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  final WorkoutStorageService _storageService = WorkoutStorageService();
  final List<WorkoutLog> _loggedWorkouts = [];

  String get _workoutTitle {
    switch (widget.workoutType) {
      case 'push':
        return 'Push Day 💪';
      case 'pull':
        return 'Pull Day 🔙';
      case 'legs':
        return 'Leg Day 🦵';
      default:
        return 'Workout';
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercises = ExerciseDatabase.getExercisesByType(widget.workoutType);

    return Scaffold(
      appBar: AppBar(
        title: Text(_workoutTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      exercise.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(exercise.muscleGroup),
                    trailing: const Icon(Icons.add_circle_outline),
                    onTap: () => _logExercise(exercise),
                  ),
                );
              },
            ),
          ),
          if (_loggedWorkouts.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Logged: ${_loggedWorkouts.length} exercise(s)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _finishWorkout,
                    icon: const Icon(Icons.check),
                    label: const Text('Finish Workout'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _logExercise(Exercise exercise) async {
    final sets = await _showSetEntryDialog(exercise);
    if (sets != null && sets.isNotEmpty) {
      final log = WorkoutLog(
        exerciseName: exercise.name,
        muscleGroup: exercise.muscleGroup,
        workoutType: exercise.workoutType,
        date: DateTime.now(),
        sets: sets,
      );

      setState(() {
        _loggedWorkouts.add(log);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${exercise.name} logged with ${sets.length} sets'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<List<WorkoutSet>?> _showSetEntryDialog(Exercise exercise) async {
    final List<WorkoutSet> sets = [];
    final weightController = TextEditingController();
    final repsController = TextEditingController();

    return showDialog<List<WorkoutSet>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Log ${exercise.name}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (sets.isNotEmpty) ...[
                      ...sets.asMap().entries.map((entry) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text('${entry.key + 1}'),
                          ),
                          title: Text(
                            '${entry.value.weight}kg × ${entry.value.reps} reps',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setDialogState(() {
                                sets.removeAt(entry.key);
                              });
                            },
                          ),
                        );
                      }),
                      const Divider(),
                    ],
                    TextField(
                      controller: weightController,
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: repsController,
                      decoration: const InputDecoration(
                        labelText: 'Reps',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        final weight = double.tryParse(weightController.text);
                        final reps = int.tryParse(repsController.text);

                        if (weight != null && reps != null) {
                          setDialogState(() {
                            sets.add(WorkoutSet(weight: weight, reps: reps));
                            weightController.clear();
                            repsController.clear();
                          });
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Set'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, sets),
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _finishWorkout() async {
    for (var log in _loggedWorkouts) {
      await _storageService.addWorkoutLog(log);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Workout saved successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }
  }
}
