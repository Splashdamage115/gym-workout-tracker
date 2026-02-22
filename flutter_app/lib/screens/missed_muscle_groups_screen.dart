import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exercise_database.dart';
import '../services/workout_storage_service.dart';

class MissedMuscleGroupsScreen extends StatefulWidget {
  const MissedMuscleGroupsScreen({super.key});

  @override
  State<MissedMuscleGroupsScreen> createState() =>
      _MissedMuscleGroupsScreenState();
}

class _MissedMuscleGroupsScreenState extends State<MissedMuscleGroupsScreen> {
  final WorkoutStorageService _storageService = WorkoutStorageService();
  DateTime _selectedDate = DateTime.now();
  Set<String> _workedMuscleGroups = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    setState(() => _isLoading = true);
    final logs = await _storageService.getWorkoutLogsByDate(_selectedDate);
    setState(() {
      _workedMuscleGroups = logs.map((log) => log.muscleGroup).toSet();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final allMuscleGroups = ExerciseDatabase.getAllMuscleGroups();
    final missedGroups = allMuscleGroups.difference(_workedMuscleGroups);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Missed Muscle Groups'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                DateFormat('EEEE, MMMM d, y').format(_selectedDate),
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: _selectDate,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        if (_workedMuscleGroups.isNotEmpty) ...[
                          Card(
                            color: Colors.green[50],
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.check_circle,
                                          color: Colors.green[700]),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Worked Muscle Groups',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: _workedMuscleGroups
                                        .map((group) => Chip(
                                              label: Text(group),
                                              backgroundColor: Colors.green[100],
                                              avatar: const Icon(
                                                Icons.fitness_center,
                                                size: 18,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (missedGroups.isNotEmpty)
                          Card(
                            color: Colors.orange[50],
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.info_outline,
                                          color: Colors.orange[700]),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Missed Muscle Groups',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: missedGroups
                                        .map((group) => Chip(
                                              label: Text(group),
                                              backgroundColor: Colors.orange[100],
                                              avatar: const Icon(
                                                Icons.remove_circle_outline,
                                                size: 18,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (_workedMuscleGroups.isNotEmpty)
                          Card(
                            color: Colors.blue[50],
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Icon(Icons.emoji_events,
                                      color: Colors.blue[700]),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Great job! You worked all muscle groups today!',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          Card(
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline,
                                      color: Colors.grey[700]),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'No workouts logged on this date.',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _loadWorkouts();
    }
  }
}
