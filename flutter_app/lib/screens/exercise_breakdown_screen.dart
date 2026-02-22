import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/workout_models.dart';
import '../services/workout_storage_service.dart';

class ExerciseBreakdownScreen extends StatefulWidget {
  const ExerciseBreakdownScreen({super.key});

  @override
  State<ExerciseBreakdownScreen> createState() =>
      _ExerciseBreakdownScreenState();
}

class _ExerciseBreakdownScreenState extends State<ExerciseBreakdownScreen> {
  final WorkoutStorageService _storageService = WorkoutStorageService();
  DateTime _selectedDate = DateTime.now();
  List<WorkoutLog> _workoutLogs = [];
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
      _workoutLogs = logs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Breakdown'),
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
                : _workoutLogs.isEmpty
                    ? Center(
                        child: Text(
                          'No workouts on ${DateFormat('MMM d').format(_selectedDate)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _groupedByMuscle.length,
                        itemBuilder: (context, index) {
                          final muscleGroup =
                              _groupedByMuscle.keys.elementAt(index);
                          final logs = _groupedByMuscle[muscleGroup]!;
                          return _buildMuscleGroupCard(muscleGroup, logs);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Map<String, List<WorkoutLog>> get _groupedByMuscle {
    final Map<String, List<WorkoutLog>> grouped = {};
    for (var log in _workoutLogs) {
      grouped.putIfAbsent(log.muscleGroup, () => []).add(log);
    }
    return grouped;
  }

  Widget _buildMuscleGroupCard(String muscleGroup, List<WorkoutLog> logs) {
    final totalSets = logs.fold<int>(0, (sum, log) => sum + log.sets.length);
    final totalVolume =
        logs.fold<double>(0, (sum, log) => sum + log.totalVolume);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          muscleGroup,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '$totalSets sets • ${totalVolume.toStringAsFixed(0)}kg total volume',
        ),
        children: logs.map((log) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.exerciseName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...log.sets.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4),
                    child: Text(
                      'Set ${entry.key + 1}: ${entry.value.weight}kg × ${entry.value.reps} reps',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  );
                }),
                const Divider(),
              ],
            ),
          );
        }).toList(),
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
