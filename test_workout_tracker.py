#!/usr/bin/env python3
"""
Comprehensive test suite for the Gym Workout Tracker
Tests all major functionality
"""

import os
import json
from datetime import datetime
from workout_tracker import WorkoutTracker, WorkoutLog, WorkoutSet, Exercise


def test_exercise_creation():
    """Test Exercise class"""
    exercise = Exercise('Bench Press', 'Chest', 'push')
    assert exercise.name == 'Bench Press'
    assert exercise.muscle_group == 'Chest'
    assert exercise.workout_type == 'push'
    
    exercise_dict = exercise.to_dict()
    assert exercise_dict['name'] == 'Bench Press'
    print("✓ Exercise creation test passed")


def test_workout_set():
    """Test WorkoutSet class"""
    workout_set = WorkoutSet(60.0, 10)
    assert workout_set.weight == 60.0
    assert workout_set.reps == 10
    
    # Test serialization
    set_dict = workout_set.to_dict()
    assert set_dict['weight'] == 60.0
    assert set_dict['reps'] == 10
    
    # Test deserialization
    new_set = WorkoutSet.from_dict(set_dict)
    assert new_set.weight == 60.0
    assert new_set.reps == 10
    print("✓ WorkoutSet test passed")


def test_workout_log():
    """Test WorkoutLog class"""
    log = WorkoutLog('Bench Press', 'Chest', 'push')
    assert log.exercise_name == 'Bench Press'
    assert log.muscle_group == 'Chest'
    assert log.workout_type == 'push'
    assert len(log.sets) == 0
    
    # Add sets
    log.add_set(60.0, 10)
    log.add_set(65.0, 8)
    assert len(log.sets) == 2
    
    # Test serialization
    log_dict = log.to_dict()
    assert log_dict['exercise_name'] == 'Bench Press'
    assert len(log_dict['sets']) == 2
    
    # Test deserialization
    new_log = WorkoutLog.from_dict(log_dict)
    assert new_log.exercise_name == 'Bench Press'
    assert len(new_log.sets) == 2
    assert new_log.sets[0].weight == 60.0
    print("✓ WorkoutLog test passed")


def test_workout_tracker_exercises():
    """Test that all exercise categories are properly defined"""
    tracker = WorkoutTracker(data_file='test_workout_data.json')
    
    # Check push exercises
    assert 'push' in tracker.EXERCISES
    push_exercises = tracker.EXERCISES['push']
    assert len(push_exercises) > 0
    assert any(e.name == 'Bench Press' for e in push_exercises)
    assert any(e.name == 'Shoulder Press' for e in push_exercises)
    
    # Check pull exercises
    assert 'pull' in tracker.EXERCISES
    pull_exercises = tracker.EXERCISES['pull']
    assert len(pull_exercises) > 0
    assert any(e.name == 'Pull-ups' for e in pull_exercises)
    assert any(e.name == 'Barbell Rows' for e in pull_exercises)
    
    # Check leg exercises
    assert 'legs' in tracker.EXERCISES
    leg_exercises = tracker.EXERCISES['legs']
    assert len(leg_exercises) > 0
    assert any(e.name == 'Squats' for e in leg_exercises)
    assert any(e.name == 'Leg Press' for e in leg_exercises)
    
    print("✓ Exercise categories test passed")


def test_data_persistence():
    """Test saving and loading workout data"""
    test_file = 'test_workout_data.json'
    
    # Clean up any existing test file
    if os.path.exists(test_file):
        os.remove(test_file)
    
    # Create tracker and add a workout
    tracker1 = WorkoutTracker(data_file=test_file)
    log = WorkoutLog('Bench Press', 'Chest', 'push')
    log.add_set(60.0, 10)
    log.add_set(65.0, 8)
    tracker1.workout_logs.append(log)
    tracker1.save_data()
    
    # Load data in a new tracker
    tracker2 = WorkoutTracker(data_file=test_file)
    assert len(tracker2.workout_logs) == 1
    assert tracker2.workout_logs[0].exercise_name == 'Bench Press'
    assert len(tracker2.workout_logs[0].sets) == 2
    
    # Clean up
    os.remove(test_file)
    print("✓ Data persistence test passed")


def test_muscle_group_tracking():
    """Test muscle group tracking functionality"""
    test_file = 'test_workout_data.json'
    
    # Clean up
    if os.path.exists(test_file):
        os.remove(test_file)
    
    tracker = WorkoutTracker(data_file=test_file)
    
    # Add workouts for different muscle groups
    log1 = WorkoutLog('Bench Press', 'Chest', 'push')
    log1.add_set(60.0, 10)
    tracker.workout_logs.append(log1)
    
    log2 = WorkoutLog('Shoulder Press', 'Shoulders', 'push')
    log2.add_set(40.0, 10)
    tracker.workout_logs.append(log2)
    
    # Get all muscle groups
    all_muscle_groups = set()
    for exercises in tracker.EXERCISES.values():
        for exercise in exercises:
            all_muscle_groups.add(exercise.muscle_group)
    
    # Get worked muscle groups
    today = datetime.now().strftime("%Y-%m-%d")
    worked_groups = set(log.muscle_group for log in tracker.workout_logs 
                       if log.date.startswith(today))
    
    assert 'Chest' in worked_groups
    assert 'Shoulders' in worked_groups
    
    # Clean up
    if os.path.exists(test_file):
        os.remove(test_file)
    
    print("✓ Muscle group tracking test passed")


def test_volume_calculation():
    """Test total volume calculation"""
    log = WorkoutLog('Bench Press', 'Chest', 'push')
    log.add_set(60.0, 10)  # 600
    log.add_set(65.0, 8)   # 520
    log.add_set(65.0, 7)   # 455
    
    total_volume = sum(s.weight * s.reps for s in log.sets)
    assert total_volume == 1575.0
    
    print("✓ Volume calculation test passed")


def run_all_tests():
    """Run all tests"""
    print("\n" + "="*60)
    print("RUNNING COMPREHENSIVE TESTS")
    print("="*60 + "\n")
    
    try:
        test_exercise_creation()
        test_workout_set()
        test_workout_log()
        test_workout_tracker_exercises()
        test_data_persistence()
        test_muscle_group_tracking()
        test_volume_calculation()
        
        print("\n" + "="*60)
        print("ALL TESTS PASSED!")
        print("="*60 + "\n")
        return True
    except AssertionError as e:
        print(f"\n✗ Test failed: {e}")
        return False
    except Exception as e:
        print(f"\n✗ Unexpected error: {e}")
        return False


if __name__ == "__main__":
    success = run_all_tests()
    exit(0 if success else 1)
