import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/workout_models.dart';
import '../services/workout_storage_service.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<WorkoutHistoryScreen> createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  final WorkoutStorageService _storageService = WorkoutStorageService();
  List<WorkoutLog> _workoutLogs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    final logs = await _storageService.getRecentWorkoutLogs(7);
    setState(() {
      _workoutLogs = logs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout History'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _workoutLogs.isEmpty
              ? const Center(
                  child: Text(
                    'No workouts logged yet!',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _groupedLogs.length,
                  itemBuilder: (context, index) {
                    final date = _groupedLogs.keys.elementAt(index);
                    final logs = _groupedLogs[date]!;
                    return _buildDateGroup(date, logs);
                  },
                ),
    );
  }

  Map<String, List<WorkoutLog>> get _groupedLogs {
    final Map<String, List<WorkoutLog>> grouped = {};
    for (var log in _workoutLogs) {
      final dateKey = DateFormat('yyyy-MM-dd').format(log.date);
      grouped.putIfAbsent(dateKey, () => []).add(log);
    }
    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
    );
  }

  Widget _buildDateGroup(String date, List<WorkoutLog> logs) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, MMMM d, y').format(DateTime.parse(date)),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...logs.map((log) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              log.exerciseName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              log.muscleGroup,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${log.sets.length} sets',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${log.totalVolume.toStringAsFixed(0)}kg vol',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
