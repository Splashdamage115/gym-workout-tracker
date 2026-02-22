# Flutter Migration Guide

This repository now includes both Python CLI and Flutter versions of the Gym Workout Tracker!

## 📱 Flutter Version (NEW!)

The Flutter version provides a modern, cross-platform UI that works on:
- ✅ Android phones and tablets
- ✅ iOS devices (iPhone/iPad)
- ✅ Web browsers
- ✅ Windows desktop
- ✅ macOS desktop
- ✅ Linux desktop

### Quick Start with Flutter

1. **Install Flutter SDK**
   - Visit [flutter.dev](https://flutter.dev/docs/get-started/install)
   - Download and install Flutter for your platform
   - Add Flutter to your PATH

2. **Navigate to Flutter app**
   ```bash
   cd flutter_app
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run on your device**
   ```bash
   # Mobile (Android/iOS)
   flutter run
   
   # Web
   flutter run -d chrome
   
   # Windows
   flutter run -d windows
   
   # macOS
   flutter run -d macos
   
   # Linux
   flutter run -d linux
   ```

### Full Documentation

See [flutter_app/README.md](flutter_app/README.md) for complete setup instructions, building for production, and more details.

## 🖥️ Python CLI Version (Original)

The original Python CLI version still works great for terminal enthusiasts!

### Quick Start with Python

```bash
python3 workout_tracker.py
```

See the main [README.md](README.md) for full documentation.

## Which Version Should I Use?

### Use Flutter if you want:
- ✅ Mobile app experience
- ✅ Touch-friendly interface
- ✅ Cross-device compatibility
- ✅ Modern UI with animations
- ✅ Easy data visualization
- ✅ App you can use on the go

### Use Python CLI if you want:
- ✅ Lightweight, no dependencies
- ✅ Command-line workflow
- ✅ Quick terminal access
- ✅ Simple text-based interface
- ✅ Easy to modify and extend
- ✅ Minimal resource usage

## Data Compatibility

**Note:** The Python and Flutter versions use different storage formats:
- **Python**: JSON file (`workout_data.json`)
- **Flutter**: Platform-specific local storage (SharedPreferences)

They do not currently share data, but you can migrate manually if needed.

## Features Comparison

| Feature | Python CLI | Flutter |
|---------|-----------|---------|
| Push/Pull/Legs Split | ✅ | ✅ |
| Log Sets/Weight/Reps | ✅ | ✅ |
| Workout History | ✅ | ✅ |
| Exercise Breakdown | ✅ | ✅ |
| Missed Muscle Groups | ✅ | ✅ |
| Touch Interface | ❌ | ✅ |
| Mobile Support | ❌ | ✅ |
| Cross-Platform | ✅ Linux/Mac/Win | ✅ iOS/Android/Web/Desktop |
| Offline Storage | ✅ | ✅ |
| Dark Mode | ❌ | ✅ |
| Visual Analytics | ❌ | ✅ |

## Development

### Flutter App Structure
```
flutter_app/
├── lib/
│   ├── main.dart              # Entry point
│   ├── models/                # Data models
│   ├── services/              # Business logic
│   ├── screens/               # UI screens
│   └── widgets/               # Reusable components
├── android/                   # Android config
├── ios/                       # iOS config
├── web/                       # Web config
└── pubspec.yaml              # Dependencies
```

### Python CLI Structure
```
workout_tracker.py             # Main application
test_workout_tracker.py        # Tests
example.py                     # Usage examples
demo.py                        # Demo script
```

## Contributing

Contributions to both versions are welcome!

- For Flutter: Submit PRs to the `flutter_app/` directory
- For Python: Submit PRs to the root directory

## Support

For issues:
- Flutter app issues: Tag with `flutter`
- Python CLI issues: Tag with `python`

---

**Happy Training!** 💪
