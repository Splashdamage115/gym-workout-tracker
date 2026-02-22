import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout_models.dart';

class WorkoutStorageService {
  static const String _workoutLogsKey = 'workout_logs';

  Future<List<WorkoutLog>> loadWorkoutLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_workoutLogsKey);
    
    if (jsonString == null) {
      return [];
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => WorkoutLog.fromJson(json)).toList();
    } catch (e) {
      print('Error loading workout logs: $e');
      return [];
    }
  }

  Future<void> saveWorkoutLogs(List<WorkoutLog> logs) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(logs.map((log) => log.toJson()).toList());
    await prefs.setString(_workoutLogsKey, jsonString);
  }

  Future<void> addWorkoutLog(WorkoutLog log) async {
    final logs = await loadWorkoutLogs();
    logs.add(log);
    await saveWorkoutLogs(logs);
  }

  Future<List<WorkoutLog>> getWorkoutLogsByDate(DateTime date) async {
    final logs = await loadWorkoutLogs();
    return logs.where((log) {
      return log.date.year == date.year &&
          log.date.month == date.month &&
          log.date.day == date.day;
    }).toList();
  }

  Future<List<WorkoutLog>> getRecentWorkoutLogs(int days) async {
    final logs = await loadWorkoutLogs();
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    return logs.where((log) => log.date.isAfter(cutoffDate)).toList();
  }
}
