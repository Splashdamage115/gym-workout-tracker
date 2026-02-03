#!/usr/bin/env python3
"""
Example usage of the Gym Workout Tracker
This demonstrates how the application works programmatically
"""

from workout_tracker import WorkoutTracker, WorkoutLog

def example_usage():
    """Demonstrate the workout tracker features"""
    
    # Create a tracker instance
    tracker = WorkoutTracker(data_file='example_workout_data.json')
    
    print("="*60)
    print("EXAMPLE: Logging a Push Day Workout")
    print("="*60)
    
    # Simulate logging a push workout
    # Exercise 1: Bench Press
    bench_press = tracker.EXERCISES['push'][1]
    log1 = WorkoutLog(bench_press.name, bench_press.muscle_group, bench_press.workout_type)
    log1.add_set(60.0, 10)
    log1.add_set(65.0, 8)
    log1.add_set(65.0, 7)
    tracker.workout_logs.append(log1)
    print(f"✓ Logged {bench_press.name}: 3 sets")
    
    # Exercise 2: Shoulder Press
    shoulder_press = tracker.EXERCISES['push'][4]
    log2 = WorkoutLog(shoulder_press.name, shoulder_press.muscle_group, shoulder_press.workout_type)
    log2.add_set(40.0, 10)
    log2.add_set(42.5, 9)
    log2.add_set(42.5, 8)
    tracker.workout_logs.append(log2)
    print(f"✓ Logged {shoulder_press.name}: 3 sets")
    
    # Exercise 3: Tricep Dips
    tricep_dips = tracker.EXERCISES['push'][7]
    log3 = WorkoutLog(tricep_dips.name, tricep_dips.muscle_group, tricep_dips.workout_type)
    log3.add_set(0, 15)  # Bodyweight
    log3.add_set(0, 12)
    log3.add_set(0, 10)
    tracker.workout_logs.append(log3)
    print(f"✓ Logged {tricep_dips.name}: 3 sets (bodyweight)")
    
    # Save the data
    tracker.save_data()
    print("\n✓ Workout saved to example_workout_data.json")
    
    # View workout history
    print("\n" + "="*60)
    tracker.view_workout_history()
    
    # Get exercise breakdown
    print("\n" + "="*60)
    tracker.get_exercise_breakdown()
    
    # Check missed muscle groups
    print("\n" + "="*60)
    tracker.check_missed_muscle_groups()
    
    print("\n" + "="*60)
    print("Example completed successfully!")
    print("="*60)
    print("\nTo use the interactive app, run: python3 workout_tracker.py")


if __name__ == "__main__":
    example_usage()
