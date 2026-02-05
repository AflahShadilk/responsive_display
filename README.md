# responsiveDisplay
[![pub package](https://img.shields.io/pub/v/responsive_display.svg)](https://pub.dev/packages/responsive_display)

A production-ready, zero-rework Flutter package for responsive design covering layout decisions, proportional scaling, and constraint-based responsiveness.

## Features

*   **Device Classification**: `xsmall`, `small`, `medium`, `large`, `xlarge`.
*   **Layout Responsiveness**: `ResponsiveBuilder` for switching widgets based on device type.
*   **Proportional Scaling**: `responsiveDisplay.scaleFont`, `scaleSpacing`, etc.
*   **Constraint Awareness**: `ResponsiveLayoutBuilder` for nested responsiveness.
*   **Grid System**: `ResponsiveGrid` for adaptive column layouts.
*   **Adaptive Scaffold**: `ResponsiveScaffold` for platform-appropriate navigation.
*   **Unified Namespace**: Access everything via `responsiveDisplay`.

## Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  responsive_display: ^1.0.0
```

Import the package:

```dart
import 'package:responsive_display/responsiveDisplay.dart';
```

## Usage

### 1. Device Detection

```dart
DeviceType type = responsiveDisplay.deviceType(context);
bool isPhone = responsiveDisplay.isPhone(context);
```

### 2. Layout Switching

Use `ResponsiveBuilder` to show different widgets for different screen sizes:

```dart
ResponsiveBuilder(
  xsmall: MobileLayout(),
  medium: TabletLayout(),
  large: DesktopLayout(),
  fallback: (type) => MobileLayout(), // Optional fallback
)
```

### 3. Responsive Values

Define values that change based on screen size without manual math:

```dart
double fontSize = ResponsiveValue<double>(
  context,
  xsmall: 14,
  medium: 18,
  large: 24,
  defaultValue: 16,
).value;
```

### 4. Proportional Scaling

Scale generic values based on the screen width with safe clamping:

```dart
Text(
  'Responsive Text',
  style: TextStyle(
    fontSize: responsiveDisplay.scaleFont(context, 20),
  ),
);

Container(
  padding: EdgeInsets.all(responsiveDisplay.scaleSpacing(context, 16)),
);
```

### 5. Responsive Grid

Automatically adjusts column count (1 for mobile, up to 6 for extra large screens):

```dart
ResponsiveGrid(
  children: items,
)
```

### 6. Configuration

Override global breakpoints or settings:

```dart
ResponsiveConfig(
  breakpoints: Breakpoints(xsmall: 400),
  child: MyApp(),
)
```

## Additional Information

This package follows a philosophy of coexistence between layout switching, proportional scaling, and constraint-based logic to handle real-world scenarios effectively.
