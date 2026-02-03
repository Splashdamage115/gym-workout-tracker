#!/usr/bin/env python3
"""
Gym Workout Tracker - A simple CLI application to log and track workouts
"""

import json
import os
from datetime import datetime
from typing import List, Dict, Optional


class Exercise:
    """Represents a single exercise with its details"""
    
    def __init__(self, name: str, muscle_group: str, workout_type: str):
        self.name = name
        self.muscle_group = muscle_group
        self.workout_type = workout_type
    
    def to_dict(self):
        return {
            'name': self.name,
            'muscle_group': self.muscle_group,
            'workout_type': self.workout_type
        }


class WorkoutSet:
    """Represents a single set of an exercise"""
    
    def __init__(self, weight: float, reps: int):
        self.weight = weight
        self.reps = reps
    
    def to_dict(self):
        return {
            'weight': self.weight,
            'reps': self.reps
        }
    
    @staticmethod
    def from_dict(data):
        return WorkoutSet(data['weight'], data['reps'])


class WorkoutLog:
    """Represents a logged workout session"""
    
    def __init__(self, exercise_name: str, muscle_group: str, workout_type: str, date: Optional[str] = None):
        self.exercise_name = exercise_name
        self.muscle_group = muscle_group
        self.workout_type = workout_type
        self.date = date or datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        self.sets: List[WorkoutSet] = []
    
    def add_set(self, weight: float, reps: int):
        self.sets.append(WorkoutSet(weight, reps))
    
    def to_dict(self):
        return {
            'exercise_name': self.exercise_name,
            'muscle_group': self.muscle_group,
            'workout_type': self.workout_type,
            'date': self.date,
            'sets': [s.to_dict() for s in self.sets]
        }
    
    @staticmethod
    def from_dict(data):
        log = WorkoutLog(
            data['exercise_name'],
            data['muscle_group'],
            data['workout_type'],
            data['date']
        )
        log.sets = [WorkoutSet.from_dict(s) for s in data['sets']]
        return log


class WorkoutTracker:
    """Main workout tracker application"""
    
    # Predefined exercises categorized by workout type
    EXERCISES = {
        'push': [
            Exercise('Push-ups', 'Chest', 'push'),
            Exercise('Bench Press', 'Chest', 'push'),
            Exercise('Incline Bench Press', 'Chest', 'push'),
            Exercise('Chest Fly', 'Chest', 'push'),
            Exercise('Shoulder Press', 'Shoulders', 'push'),
            Exercise('Lateral Raises', 'Shoulders', 'push'),
            Exercise('Front Raises', 'Shoulders', 'push'),
            Exercise('Tricep Dips', 'Triceps', 'push'),
            Exercise('Tricep Extensions', 'Triceps', 'push'),
            Exercise('Overhead Press', 'Shoulders', 'push'),
        ],
        'pull': [
            Exercise('Pull-ups', 'Back', 'pull'),
            Exercise('Chin-ups', 'Back', 'pull'),
            Exercise('Barbell Rows', 'Back', 'pull'),
            Exercise('Dumbbell Rows', 'Back', 'pull'),
            Exercise('Lat Pulldown', 'Back', 'pull'),
            Exercise('Face Pulls', 'Back', 'pull'),
            Exercise('Bicep Curls', 'Biceps', 'pull'),
            Exercise('Hammer Curls', 'Biceps', 'pull'),
            Exercise('Preacher Curls', 'Biceps', 'pull'),
            Exercise('Deadlift', 'Back', 'pull'),
        ],
        'legs': [
            Exercise('Squats', 'Quads', 'legs'),
            Exercise('Leg Press', 'Quads', 'legs'),
            Exercise('Lunges', 'Quads', 'legs'),
            Exercise('Leg Extensions', 'Quads', 'legs'),
            Exercise('Romanian Deadlift', 'Hamstrings', 'legs'),
            Exercise('Leg Curls', 'Hamstrings', 'legs'),
            Exercise('Calf Raises', 'Calves', 'legs'),
            Exercise('Bulgarian Split Squats', 'Quads', 'legs'),
            Exercise('Hip Thrusts', 'Glutes', 'legs'),
            Exercise('Leg Abduction', 'Glutes', 'legs'),
        ]
    }
    
    def __init__(self, data_file='workout_data.json'):
        self.data_file = data_file
        self.workout_logs: List[WorkoutLog] = []
        self.load_data()
    
    def load_data(self):
        """Load workout data from JSON file"""
        if os.path.exists(self.data_file):
            try:
                with open(self.data_file, 'r') as f:
                    data = json.load(f)
                    self.workout_logs = [WorkoutLog.from_dict(log) for log in data]
            except (json.JSONDecodeError, KeyError):
                print("Warning: Could not load existing data. Starting fresh.")
                self.workout_logs = []
    
    def save_data(self):
        """Save workout data to JSON file"""
        with open(self.data_file, 'w') as f:
            json.dump([log.to_dict() for log in self.workout_logs], f, indent=2)
    
    def log_workout(self, workout_type: str):
        """Log a workout for a specific type (push/pull/legs)"""
        print(f"\n=== {workout_type.upper()} DAY WORKOUT ===\n")
        
        exercises = self.EXERCISES.get(workout_type.lower(), [])
        if not exercises:
            print(f"Invalid workout type: {workout_type}")
            return
        
        print("Available exercises:")
        for idx, exercise in enumerate(exercises, 1):
            print(f"{idx}. {exercise.name} ({exercise.muscle_group})")
        
        while True:
            choice = input("\nSelect exercise number (or 'done' to finish): ").strip()
            if choice.lower() == 'done':
                break
            
            try:
                idx = int(choice) - 1
                if 0 <= idx < len(exercises):
                    exercise = exercises[idx]
                    self._log_exercise(exercise)
                else:
                    print("Invalid exercise number!")
            except ValueError:
                print("Please enter a valid number or 'done'")
        
        self.save_data()
        print("\nWorkout logged successfully!")
    
    def _log_exercise(self, exercise: Exercise):
        """Log sets for a specific exercise"""
        print(f"\nLogging: {exercise.name}")
        log = WorkoutLog(exercise.name, exercise.muscle_group, exercise.workout_type)
        
        set_num = 1
        while True:
            print(f"\nSet {set_num}:")
            weight_input = input("  Weight (kg) or 'done' to finish: ").strip()
            if weight_input.lower() == 'done':
                break
            
            try:
                weight = float(weight_input)
                reps = int(input("  Reps: ").strip())
                log.add_set(weight, reps)
                print(f"  Set {set_num} logged: {weight}kg x {reps} reps")
                set_num += 1
            except ValueError:
                print("  Invalid input! Please enter numbers.")
        
        if log.sets:
            self.workout_logs.append(log)
            print(f"\n{exercise.name} logged with {len(log.sets)} sets!")
    
    def view_workout_history(self, days: int = 7):
        """View workout history for the last N days"""
        print(f"\n=== WORKOUT HISTORY (Last {days} days) ===\n")
        
        if not self.workout_logs:
            print("No workouts logged yet!")
            return
        
        # Filter logs by date
        cutoff_date = datetime.now()
        recent_logs = []
        
        for log in self.workout_logs:
            try:
                log_date = datetime.strptime(log.date, "%Y-%m-%d %H:%M:%S")
                days_diff = (cutoff_date - log_date).days
                if days_diff <= days:
                    recent_logs.append(log)
            except ValueError:
                continue
        
        if not recent_logs:
            print(f"No workouts in the last {days} days!")
            return
        
        # Group by date
        by_date = {}
        for log in recent_logs:
            date_key = log.date.split()[0]
            if date_key not in by_date:
                by_date[date_key] = []
            by_date[date_key].append(log)
        
        for date in sorted(by_date.keys(), reverse=True):
            print(f"\n{date}:")
            for log in by_date[date]:
                total_sets = len(log.sets)
                total_volume = sum(s.weight * s.reps for s in log.sets)
                print(f"  - {log.exercise_name} ({log.muscle_group}): {total_sets} sets, {total_volume:.0f}kg volume")
    
    def get_exercise_breakdown(self, date: Optional[str] = None):
        """Get breakdown of exercises done on a specific date"""
        target_date = date or datetime.now().strftime("%Y-%m-%d")
        print(f"\n=== EXERCISE BREAKDOWN for {target_date} ===\n")
        
        # Filter logs for the target date
        day_logs = [log for log in self.workout_logs if log.date.startswith(target_date)]
        
        if not day_logs:
            print(f"No workouts logged on {target_date}")
            return
        
        # Group by muscle group
        muscle_groups = {}
        for log in day_logs:
            if log.muscle_group not in muscle_groups:
                muscle_groups[log.muscle_group] = []
            muscle_groups[log.muscle_group].append(log)
        
        print("Muscle Groups Worked:")
        for muscle_group in sorted(muscle_groups.keys()):
            logs = muscle_groups[muscle_group]
            total_sets = sum(len(log.sets) for log in logs)
            total_volume = sum(sum(s.weight * s.reps for s in log.sets) for log in logs)
            print(f"\n{muscle_group}: {total_sets} sets, {total_volume:.0f}kg total volume")
            for log in logs:
                print(f"  - {log.exercise_name}:")
                for idx, s in enumerate(log.sets, 1):
                    print(f"    Set {idx}: {s.weight}kg x {s.reps} reps")
    
    def check_missed_muscle_groups(self, date: Optional[str] = None):
        """Check which muscle groups were missed on a particular day"""
        target_date = date or datetime.now().strftime("%Y-%m-%d")
        print(f"\n=== MISSED MUSCLE GROUPS for {target_date} ===\n")
        
        # All possible muscle groups
        all_muscle_groups = set()
        for exercises in self.EXERCISES.values():
            for exercise in exercises:
                all_muscle_groups.add(exercise.muscle_group)
        
        # Get worked muscle groups for the date
        day_logs = [log for log in self.workout_logs if log.date.startswith(target_date)]
        worked_groups = set(log.muscle_group for log in day_logs)
        
        if not day_logs:
            print(f"No workouts logged on {target_date}")
            print(f"\nAll muscle groups missed: {', '.join(sorted(all_muscle_groups))}")
            return
        
        missed_groups = all_muscle_groups - worked_groups
        
        print(f"Worked: {', '.join(sorted(worked_groups))}")
        if missed_groups:
            print(f"\nMissed: {', '.join(sorted(missed_groups))}")
        else:
            print("\nGreat job! You worked all muscle groups today!")


def main():
    """Main CLI interface"""
    tracker = WorkoutTracker()
    
    while True:
        print("\n" + "="*50)
        print("GYM WORKOUT TRACKER")
        print("="*50)
        print("\n1. Log Push Day Workout")
        print("2. Log Pull Day Workout")
        print("3. Log Leg Day Workout")
        print("4. View Workout History")
        print("5. Exercise Breakdown (Today)")
        print("6. Check Missed Muscle Groups (Today)")
        print("7. Exit")
        
        choice = input("\nSelect an option (1-7): ").strip()
        
        if choice == '1':
            tracker.log_workout('push')
        elif choice == '2':
            tracker.log_workout('pull')
        elif choice == '3':
            tracker.log_workout('legs')
        elif choice == '4':
            tracker.view_workout_history()
        elif choice == '5':
            tracker.get_exercise_breakdown()
        elif choice == '6':
            tracker.check_missed_muscle_groups()
        elif choice == '7':
            print("\nGoodbye! Keep up the great work!")
            break
        else:
            print("\nInvalid option! Please select 1-7.")


if __name__ == "__main__":
    main()
