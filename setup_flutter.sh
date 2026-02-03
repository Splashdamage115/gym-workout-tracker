#!/bin/bash

# Flutter Gym Workout Tracker Setup Script

echo "🏋️ Gym Workout Tracker - Flutter Setup"
echo "======================================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed!"
    echo ""
    echo "Please install Flutter first:"
    echo "1. Visit https://flutter.dev/docs/get-started/install"
    echo "2. Download Flutter for your platform"
    echo "3. Add Flutter to your PATH"
    echo "4. Run 'flutter doctor' to verify installation"
    exit 1
fi

echo "✅ Flutter found!"
flutter --version
echo ""

# Navigate to flutter_app directory
cd flutter_app || exit 1

echo "📦 Installing dependencies..."
flutter pub get

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Setup complete!"
    echo ""
    echo "🚀 You can now run the app:"
    echo ""
    echo "  Mobile (Android/iOS):  flutter run"
    echo "  Web:                   flutter run -d chrome"
    echo "  Windows:               flutter run -d windows"
    echo "  macOS:                 flutter run -d macos"
    echo "  Linux:                 flutter run -d linux"
    echo ""
    echo "📱 To list available devices: flutter devices"
    echo ""
else
    echo ""
    echo "❌ Setup failed. Please check the error messages above."
    exit 1
fi
