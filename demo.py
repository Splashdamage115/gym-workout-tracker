#!/usr/bin/env python3
"""
Interactive demo of the Gym Workout Tracker
This simulates a user session to show how the app works
"""

import sys
import time

def print_slow(text, delay=0.03):
    """Print text with a typing effect"""
    for char in text:
        sys.stdout.write(char)
        sys.stdout.flush()
        time.sleep(delay)
    print()

def demo():
    """Run an interactive demo"""
    
    print("\n" + "="*60)
    print("GYM WORKOUT TRACKER - INTERACTIVE DEMO")
    print("="*60)
    print()
    
    print_slow("Welcome to the Gym Workout Tracker!")
    print_slow("This app helps you log workouts organized by muscle groups.")
    print()
    
    print_slow("The app supports three workout types:")
    print_slow("  1. PUSH DAY - Chest, Shoulders, Triceps")
    print_slow("  2. PULL DAY - Back, Biceps")
    print_slow("  3. LEG DAY - Quads, Hamstrings, Glutes, Calves")
    print()
    
    print_slow("Let's start by logging a Push Day workout...")
    time.sleep(1)
    print()
    
    print("="*60)
    print("PUSH DAY WORKOUT")
    print("="*60)
    print()
    
    print("Available exercises:")
    exercises = [
        "1. Push-ups (Chest)",
        "2. Bench Press (Chest)",
        "3. Incline Bench Press (Chest)",
        "4. Chest Fly (Chest)",
        "5. Shoulder Press (Shoulders)",
        "6. Lateral Raises (Shoulders)",
        "7. Front Raises (Shoulders)",
        "8. Tricep Dips (Triceps)",
        "9. Tricep Extensions (Triceps)",
        "10. Overhead Press (Shoulders)"
    ]
    
    for exercise in exercises:
        print(exercise)
    print()
    
    print_slow("Select exercise number (or 'done' to finish): 2")
    print()
    print_slow("Logging: Bench Press")
    print()
    
    # Simulate logging sets
    sets = [
        ("60", "10"),
        ("65", "8"),
        ("65", "7")
    ]
    
    for i, (weight, reps) in enumerate(sets, 1):
        print(f"Set {i}:")
        print_slow(f"  Weight (kg) or 'done' to finish: {weight}")
        print_slow(f"  Reps: {reps}")
        print(f"  Set {i} logged: {weight}kg x {reps} reps")
        print()
    
    print_slow("  Weight (kg) or 'done' to finish: done")
    print()
    print("Bench Press logged with 3 sets!")
    print()
    
    print_slow("Select exercise number (or 'done' to finish): 5")
    print()
    print_slow("Logging: Shoulder Press")
    print()
    
    sets2 = [
        ("40", "10"),
        ("42.5", "9"),
        ("42.5", "8")
    ]
    
    for i, (weight, reps) in enumerate(sets2, 1):
        print(f"Set {i}:")
        print_slow(f"  Weight (kg) or 'done' to finish: {weight}")
        print_slow(f"  Reps: {reps}")
        print(f"  Set {i} logged: {weight}kg x {reps} reps")
        print()
    
    print_slow("  Weight (kg) or 'done' to finish: done")
    print()
    print("Shoulder Press logged with 3 sets!")
    print()
    
    print_slow("Select exercise number (or 'done' to finish): done")
    print()
    print("Workout logged successfully!")
    print()
    
    time.sleep(1)
    
    # Show workout history
    print("="*60)
    print("WORKOUT HISTORY (Last 7 days)")
    print("="*60)
    print()
    print("2026-02-03:")
    print("  - Bench Press (Chest): 3 sets, 1575kg volume")
    print("  - Shoulder Press (Shoulders): 3 sets, 1122kg volume")
    print()
    
    time.sleep(1)
    
    # Show exercise breakdown
    print("="*60)
    print("EXERCISE BREAKDOWN for 2026-02-03")
    print("="*60)
    print()
    print("Muscle Groups Worked:")
    print()
    print("Chest: 3 sets, 1575kg total volume")
    print("  - Bench Press:")
    print("    Set 1: 60.0kg x 10 reps")
    print("    Set 2: 65.0kg x 8 reps")
    print("    Set 3: 65.0kg x 7 reps")
    print()
    print("Shoulders: 3 sets, 1122kg total volume")
    print("  - Shoulder Press:")
    print("    Set 1: 40.0kg x 10 reps")
    print("    Set 2: 42.5kg x 9 reps")
    print("    Set 3: 42.5kg x 8 reps")
    print()
    
    time.sleep(1)
    
    # Show missed muscle groups
    print("="*60)
    print("MISSED MUSCLE GROUPS for 2026-02-03")
    print("="*60)
    print()
    print("Worked: Chest, Shoulders")
    print()
    print("Missed: Back, Biceps, Calves, Glutes, Hamstrings, Quads, Triceps")
    print()
    
    print("="*60)
    print("Demo completed!")
    print("="*60)
    print()
    print_slow("To use the real app, run: python3 workout_tracker.py")
    print()


if __name__ == "__main__":
    demo()
