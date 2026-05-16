# Introduction to Flutter (Part 1)

Adapted from [orbital-react-native-2024](https://github.com/JCSnap/orbital-react-native-2024)

## About Me

-   Kwa Jian Quan
-   CEG Y3 (Poly)
-   Developed Flutter App in NOC Internship 
-   NUS Venture Initiation Programme (VIP) Flutter Companion App


## Overview

### Part 1

- Introduction to Flutter and Dart
- Setting up Flutter + emulator
- Intro to widgets
- Layout and styling
- State management with Flutter
- Let's build an app!

### Part 2
- Working with external APIs
- When and how to use packages
- Modular app architecture
- Persisting data and backend integration

## Setting expectations

- This workshop focuses on core concepts rather than full build pipelines.
- Assumes beginner-level familiarity with programming
- Goal: know what Flutter does and how to proceed to build apps.

## Format

- Short concept explanations followed by code examples and a demo.
- Checkpoint codes will be provided if you need!

## What we will be building

<img src="images/BusArrival.png" alt="Bus App" width="300">
<img src="images/nextbus.jpg" alt="Bus App" width="300">

## Why Flutter?

- Single codebase for Android & iOS.
- Fast development with hot reload.
- Rich widget set and good tooling (VS Code / Android Studio).

## Setting up Flutter

Follow the official docs for full setup: https://flutter.dev/docs/get-started/install

For this workshop, we will be using VS Code as our editor.

Quick steps (Windows):

```bash
# 1. Install Flutter SDK (follow the Windows guide on flutter.dev)
# 2. Add Flutter to PATH and restart terminal
flutter doctor
```

Run `flutter doctor` and follow its suggestions (Android SDK, platform-tools, etc.).

### Android emulator

- Install Android Studio and create an AVD (Android Virtual Device).
- Alternatively use a physical device with USB debugging enabled.

### iOS

- iOS development requires macOS; skip if on Windows.

### Editor

- Use VS Code or Android Studio. Install the Flutter and Dart plugins.

## Getting started

1. Create a new app:

```bash
flutter create nextbus_app
cd nextbus_app
```

2. Run the app on an emulator or device:

```bash
flutter run
```

3. Use hot reload to see changes immediately (`r` in the terminal or the hot-reload button in your editor).

## Intro to Dart & Widgets

- Flutter apps are written in Dart. UI is built with widgets.
- Everything is a widget: layout, text, buttons, images.

### Basic rules

- Use `StatelessWidget` for immutable UI and `StatefulWidget` for UI that changes over time.
- Use the `build()` method to return a widget tree.

### Example: Counter app

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Demo',
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _increment() {
    setState(() => _counter++);
  }

  void _decrement() {
    setState(() => _counter--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Counter value', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('$_counter', style: TextStyle(fontSize: 48)),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(onPressed: _decrement, child: Text('-')),
                SizedBox(width: 12),
                ElevatedButton(onPressed: _increment, child: Text('+')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## Common Flutter widgets

- `Scaffold`: Basic page layout (appBar, body, floatingActionButton).
- `ListView`: Scrollable list.
- `Text`, `Image`, `ElevatedButton`, `TextField`.
More available at: https://docs.flutter.dev/ui/widgets/

## Layout & Styling

- `Row`, `Column`: Horizontal and vertical layout.
- Align with `MainAxisAlignment` and `CrossAxisAlignment`.
- `Container`: A box with padding, margin, decoration.
- Use `padding`/`margin` via `EdgeInsets`.

## Passing data between widgets (Props)

- Widgets receive values via constructor parameters (immutable `final` fields).
- Example:

```dart
class Greeting extends StatelessWidget {
  Greeting({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text('Hello, $name');
  }
}
```

## State management

- Simple apps: use `setState` in `StatefulWidget`.

## Let's build the NUS NextBUS App!

Use the same app concept but implement UI with Flutter widgets and fetch bus data via HTTP.

## Part 2
## Organising code

- Break UI into small widgets (files under `lib/`), create `services/` for API clients, `models/` for data types, and `screens/` for pages.

## Working with packages

- Add dependencies in `pubspec.yaml` and run `flutter pub get`.
- Common packages: `http` (network), `provider` (state), `shared_preferences` (local storage).

## Dealing with external APIs

- Use the `http` package or `dio` for network calls.
- Perform network I/O asynchronously with `async`/`await` and `FutureBuilder` to render results.

## Save data in memory

- Use the `shared_preferences` package for simple key-value storage.

