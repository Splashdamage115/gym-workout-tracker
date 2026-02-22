# Gym Workout Tracker - Flutter App

A beautiful, cross-platform gym workout tracker built with Flutter. Track your workouts on Android, iOS, Web, Windows, macOS, and Linux!

## Features

✨ **Cross-Platform**: Works on mobile (Android/iOS), web, and desktop (Windows/macOS/Linux)
💪 **Push/Pull/Legs Split**: Organized workout types with relevant exercises
📊 **Track Progress**: Log sets, weight, and reps for each exercise
📈 **Analytics**: View workout history, exercise breakdowns, and missed muscle groups
💾 **Local Storage**: All data stored locally on your device
🌓 **Dark Mode**: Automatic light/dark theme support
🎨 **Modern UI**: Beautiful Material Design 3 interface

## Screenshots

The app includes:
- **Home Screen**: Quick access to Push/Pull/Legs workouts and analytics
- **Log Workout**: Easy-to-use interface for logging exercises and sets
- **Workout History**: View your last 7 days of workouts
- **Exercise Breakdown**: Detailed stats per muscle group for any day
- **Missed Muscle Groups**: See which muscle groups you've worked or missed

## Prerequisites

Before you begin, ensure you have:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.0.0 or higher)
- For Android: Android Studio with Android SDK
- For iOS: Xcode (macOS only)
- For Web: Chrome browser
- For Desktop: Platform-specific requirements (see Flutter docs)

## Installation

1. **Clone the repository:**
   ```bash
   cd gym-workout-tracker/flutter_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**

   **Android/iOS (with device connected or emulator running):**
   ```bash
   flutter run
   ```

   **Web:**
   ```bash
   flutter run -d chrome
   ```

   **Windows:**
   ```bash
   flutter run -d windows
   ```

   **macOS:**
   ```bash
   flutter run -d macos
   ```

   **Linux:**
   ```bash
   flutter run -d linux
   ```

## Building for Production

### Android APK
```bash
flutter build apk --release
```
The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

### iOS (requires macOS and Xcode)
```bash
flutter build ios --release
```
Then open `ios/Runner.xcworkspace` in Xcode to archive and upload to App Store.

### Web
```bash
flutter build web --release
```
The web build will be at: `build/web/`

### Windows
```bash
flutter build windows --release
```
The executable will be at: `build/windows/runner/Release/`

### macOS
```bash
flutter build macos --release
```
The app bundle will be at: `build/macos/Build/Products/Release/`

### Linux
```bash
flutter build linux --release
```
The executable will be at: `build/linux/x64/release/bundle/`

## Project Structure

```
flutter_app/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/
│   │   ├── workout_models.dart   # Data models
│   │   └── exercise_database.dart # Exercise definitions
│   ├── services/
│   │   └── workout_storage_service.dart # Local storage
│   ├── screens/
│   │   ├── home_screen.dart      # Main menu
│   │   ├── log_workout_screen.dart # Log workouts
│   │   ├── workout_history_screen.dart # History view
│   │   ├── exercise_breakdown_screen.dart # Analytics
│   │   └── missed_muscle_groups_screen.dart # Gap analysis
│   └── widgets/                  # Reusable widgets
├── android/                      # Android configuration
├── ios/                         # iOS configuration
├── web/                         # Web configuration
└── pubspec.yaml                 # Dependencies
```

## Exercise Database

The app includes 30 pre-defined exercises:

### Push Day (10 exercises)
- Chest: Push-ups, Bench Press, Incline Bench Press, Chest Fly
- Shoulders: Shoulder Press, Lateral Raises, Front Raises, Overhead Press
- Triceps: Tricep Dips, Tricep Extensions

### Pull Day (10 exercises)
- Back: Pull-ups, Chin-ups, Barbell Rows, Dumbbell Rows, Lat Pulldown, Face Pulls, Deadlift
- Biceps: Bicep Curls, Hammer Curls, Preacher Curls

### Leg Day (10 exercises)
- Quads: Squats, Leg Press, Lunges, Leg Extensions, Bulgarian Split Squats
- Hamstrings: Romanian Deadlift, Leg Curls
- Glutes: Hip Thrusts, Leg Abduction
- Calves: Calf Raises

## Usage

### Logging a Workout

1. Open the app and select a workout type (Push/Pull/Legs)
2. Tap on an exercise from the list
3. Enter weight and reps for each set
4. Tap "Add Set" to add more sets
5. Tap "Done" when finished with the exercise
6. Repeat for more exercises or tap "Finish Workout"

### Viewing History

- Tap "Workout History" on the home screen
- View workouts from the last 7 days
- See total sets and volume for each exercise

### Exercise Breakdown

- Tap "Exercise Breakdown" on the home screen
- Select a date to view detailed stats
- See exercises grouped by muscle group
- View individual sets with weight and reps

### Checking Missed Muscle Groups

- Tap "Missed Groups" on the home screen
- Select a date to analyze
- See which muscle groups you worked
- Identify gaps in your training

## Data Storage

All workout data is stored locally on your device using `shared_preferences`:
- **Android**: SharedPreferences
- **iOS**: NSUserDefaults
- **Web**: LocalStorage
- **Desktop**: Platform-specific local storage

Your data is never sent to any servers and remains completely private.

## Customization

### Adding New Exercises

Edit `lib/models/exercise_database.dart` and add exercises to the appropriate workout type:

```dart
Exercise(name: 'New Exercise', muscleGroup: 'Target Muscle', workoutType: 'push/pull/legs'),
```

### Changing Theme Colors

Edit `lib/main.dart` and modify the `seedColor`:

```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.yourColor, // Change this
  brightness: Brightness.light,
),
```

## Dependencies

- **flutter**: SDK
- **shared_preferences**: Local data storage
- **intl**: Date formatting
- **cupertino_icons**: iOS-style icons

## Troubleshooting

### iOS Build Issues
- Run `cd ios && pod install`
- Make sure Xcode is up to date

### Android Build Issues
- Update Android SDK in Android Studio
- Check `android/app/build.gradle` for compatibility

### Web CORS Issues
- Use `flutter run -d chrome --web-browser-flag "--disable-web-security"`

## Future Enhancements

Potential features for future versions:
- Cloud sync across devices
- Custom exercise creation
- Progress charts and graphs
- Workout templates
- Rest timer
- Exercise images/videos
- Export data to CSV
- Social features

## Contributing

Feel free to submit issues and pull requests!

## License

MIT License - See LICENSE file for details

## Support

For issues or questions, please open an issue on GitHub.

---

**Happy Training!** 💪🏋️‍♀️
