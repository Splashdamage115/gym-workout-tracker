import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/workout_models.dart';
import '../models/exercise_database.dart';
import '../services/workout_storage_service.dart';

class LogWorkoutScreen extends StatefulWidget {
  final String workoutType;

  const LogWorkoutScreen({super.key, required this.workoutType});

  @override
  State<LogWorkoutScreen> createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> with SingleTickerProviderStateMixin {
  final WorkoutStorageService _storageService = WorkoutStorageService();
  final List<WorkoutLog> _loggedWorkouts = [];
  late AnimationController _animationController;
  bool _isSaving = false;

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

  Color get _workoutColor {
    switch (widget.workoutType) {
      case 'push':
        return Colors.red;
      case 'pull':
        return Colors.blue;
      case 'legs':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercises = ExerciseDatabase.getExercisesByType(widget.workoutType);

    return WillPopScope(
      onWillPop: () async {
        if (_loggedWorkouts.isNotEmpty) {
          return await _showExitConfirmation();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_workoutTitle),
          actions: [
            if (_loggedWorkouts.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear_all),
                onPressed: _clearAllLogs,
                tooltip: 'Clear all',
              ),
          ],
        ),
        body: Column(
          children: [
            if (_loggedWorkouts.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: _workoutColor.withOpacity(0.1),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: _workoutColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${_loggedWorkouts.length} exercise(s) logged',
                      style: TextStyle(
                        color: _workoutColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_getTotalSets()} sets',
                      style: TextStyle(
                        color: _workoutColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: exercises.isEmpty
                  ? const Center(child: Text('No exercises available'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = exercises[index];
                        final isLogged = _isExerciseLogged(exercise.name);
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 200 + (index * 50)),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  elevation: isLogged ? 4 : 2,
                                  color: isLogged
                                      ? _workoutColor.withOpacity(0.1)
                                      : null,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: _workoutColor.withOpacity(0.2),
                                      child: Icon(
                                        isLogged ? Icons.check : Icons.fitness_center,
                                        color: _workoutColor,
                                        size: 20,
                                      ),
                                    ),
                                    title: Text(
                                      exercise.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isLogged ? _workoutColor : null,
                                      ),
                                    ),
                                    subtitle: Text(
                                      exercise.muscleGroup,
                                      style: TextStyle(
                                        color: isLogged
                                            ? _workoutColor.withOpacity(0.7)
                                            : null,
                                      ),
                                    ),
                                    trailing: Icon(
                                      isLogged ? Icons.edit : Icons.add_circle_outline,
                                      color: _workoutColor,
                                    ),
                                    onTap: () => _logExercise(exercise),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
            if (_loggedWorkouts.isNotEmpty)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
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
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatChip('Exercises', '${_loggedWorkouts.length}'),
                          _buildStatChip('Sets', '${_getTotalSets()}'),
                          _buildStatChip('Volume', '${_getTotalVolume().toStringAsFixed(0)}kg'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _isSaving
                          ? const CircularProgressIndicator()
                          : ElevatedButton.icon(
                              onPressed: _finishWorkout,
                              icon: const Icon(Icons.check_circle),
                              label: const Text('Finish Workout'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 52),
                                backgroundColor: _workoutColor,
                                foregroundColor: Colors.white,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _workoutColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: _workoutColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _workoutColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  bool _isExerciseLogged(String exerciseName) {
    return _loggedWorkouts.any((log) => log.exerciseName == exerciseName);
  }

  int _getTotalSets() {
    return _loggedWorkouts.fold(0, (sum, log) => sum + log.sets.length);
  }

  double _getTotalVolume() {
    return _loggedWorkouts.fold(0.0, (sum, log) => sum + log.totalVolume);
  }

  Future<void> _logExercise(Exercise exercise) async {
    final sets = await _showSetEntryDialog(exercise);
    if (sets != null && sets.isNotEmpty) {
      final existingIndex = _loggedWorkouts.indexWhere(
        (log) => log.exerciseName == exercise.name,
      );

      final log = WorkoutLog(
        exerciseName: exercise.name,
        muscleGroup: exercise.muscleGroup,
        workoutType: exercise.workoutType,
        date: DateTime.now(),
        sets: sets,
      );

      setState(() {
        if (existingIndex >= 0) {
          _loggedWorkouts[existingIndex] = log;
        } else {
          _loggedWorkouts.add(log);
        }
      });

      if (mounted) {
        HapticFeedback.lightImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${exercise.name} logged with ${sets.length} sets',
                  ),
                ),
              ],
            ),
            backgroundColor: _workoutColor,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<List<WorkoutSet>?> _showSetEntryDialog(Exercise exercise) async {
    final existingLog = _loggedWorkouts.firstWhere(
      (log) => log.exerciseName == exercise.name,
      orElse: () => WorkoutLog(
        exerciseName: '',
        muscleGroup: '',
        workoutType: '',
        date: DateTime.now(),
        sets: [],
      ),
    );
    
    final List<WorkoutSet> sets = List.from(existingLog.sets);
    final weightController = TextEditingController();
    final repsController = TextEditingController();

    return showDialog<List<WorkoutSet>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _workoutColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.fitness_center, color: _workoutColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          exercise.muscleGroup,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (sets.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _workoutColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Logged Sets',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _workoutColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...sets.asMap().entries.map((entry) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: _workoutColor.withOpacity(0.2),
                                      child: Text(
                                        '${entry.key + 1}',
                                        style: TextStyle(
                                          color: _workoutColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        '${entry.value.weight}kg × ${entry.value.reps} reps',
                                        style: const TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      color: Colors.red,
                                      onPressed: () {
                                        HapticFeedback.lightImpact();
                                        setDialogState(() {
                                          sets.removeAt(entry.key);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    TextField(
                      controller: weightController,
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.fitness_center),
                        suffixText: 'kg',
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      autofocus: sets.isEmpty,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: repsController,
                      decoration: InputDecoration(
                        labelText: 'Reps',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.repeat),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) {
                        final weight = double.tryParse(weightController.text);
                        final reps = int.tryParse(repsController.text);
                        if (weight != null && reps != null) {
                          HapticFeedback.lightImpact();
                          setDialogState(() {
                            sets.add(WorkoutSet(weight: weight, reps: reps));
                            weightController.clear();
                            repsController.clear();
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        final weight = double.tryParse(weightController.text);
                        final reps = int.tryParse(repsController.text);

                        if (weight != null && reps != null) {
                          HapticFeedback.lightImpact();
                          setDialogState(() {
                            sets.add(WorkoutSet(weight: weight, reps: reps));
                            weightController.clear();
                            repsController.clear();
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter valid weight and reps'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: Text('Add Set ${sets.length + 1}'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: _workoutColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton.icon(
                  onPressed: sets.isEmpty
                      ? null
                      : () {
                          HapticFeedback.mediumImpact();
                          Navigator.pop(context, sets);
                        },
                  icon: const Icon(Icons.check),
                  label: Text('Done (${sets.length})'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<bool> _showExitConfirmation() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit without saving?'),
            content: Text(
              'You have ${_loggedWorkouts.length} exercise(s) logged. '
              'Are you sure you want to exit without saving?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Stay'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Exit'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _clearAllLogs() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear all exercises?'),
        content: const Text('This will remove all logged exercises from this session.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _loggedWorkouts.clear();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All exercises cleared')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  Future<void> _finishWorkout() async {
    setState(() {
      _isSaving = true;
    });

    try {
      for (var log in _loggedWorkouts) {
        await _storageService.addWorkoutLog(log);
      }

      if (mounted) {
        HapticFeedback.heavyImpact();
        
        // Show success animation
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: _workoutColor,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Workout Saved!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_loggedWorkouts.length} exercises • ${_getTotalSets()} sets',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_getTotalVolume().toStringAsFixed(0)}kg total volume',
                  style: TextStyle(
                    color: _workoutColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );

        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving workout: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
