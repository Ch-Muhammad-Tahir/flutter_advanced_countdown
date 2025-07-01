# Countdown Timer Package

A professional, feature-rich countdown timer package for Flutter with multiple display styles, themes, and **full responsive design** for all devices (iPhone, iPad, Android, Desktop).

## Features

- 🎨 **Multiple Display Styles**: Compact, detailed, circular, minimal, bottom bar, card, and gradient styles
- 📱 **Fully Responsive**: Automatically adapts to iPhone, iPad, Android, and Desktop screen sizes
- 🎯 **Theme Support**: Light, dark, gradient themes with full customization
- ⏱️ **Flexible Timing**: Support for hours, minutes, seconds, and milliseconds
- 🎮 **Interactive Controls**: Pause, resume, and reset functionality
- 📱 **Haptic Feedback**: Built-in haptic feedback for better user experience
- 🔧 **Provider Integration**: State management with ChangeNotifier
- 🎨 **Custom Styling**: Complete control over colors, fonts, and layouts
- 📊 **Progress Tracking**: Built-in progress calculation and percentage display
- 🔄 **Auto-start Options**: Configurable auto-start behavior
- 📝 **Custom Formatters**: Support for custom time formatting
- 🎯 **Error Handling**: Comprehensive error handling and validation
- 📐 **Responsive Utils**: Built-in responsive utilities for device detection and sizing

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  countdown_timer_package: ^1.0.0
```

## Quick Start

### Basic Usage

```dart
import 'package:countdown_timer_package/countdown_timer_package.dart';

// Simple responsive countdown timer
AdvancedCountdownTimer(
  duration: const Duration(minutes: 5),
  onFinish: () => print('Timer finished!'),
)
```

### With Controls

```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 2, seconds: 30),
  displayStyle: CountdownDisplayStyle.compact,
  showControls: true,
  showReset: true,
  useResponsiveSizing: true, // Enable responsive design (default: true)
  onFinish: () => print('Timer finished!'),
  onPause: () => print('Timer paused'),
  onResume: () => print('Timer resumed'),
  onReset: () => print('Timer reset'),
)
```

## Responsive Design

The package automatically adapts to different screen sizes and devices:

### Device Detection
```dart
// Get current device type
DeviceType deviceType = ResponsiveUtils.getDeviceType(context);
// Returns: DeviceType.phone, DeviceType.tablet, or DeviceType.desktop

// Get screen size category
ScreenSize screenSize = ResponsiveUtils.getScreenSize(context);
// Returns: ScreenSize.xs, ScreenSize.sm, ScreenSize.md, ScreenSize.lg, or ScreenSize.xl
```

### Responsive Sizing
```dart
// Get responsive font size
double fontSize = ResponsiveUtils.getResponsiveFontSize(context, base: 16.0);

// Get responsive padding
EdgeInsets padding = ResponsiveUtils.getResponsivePadding(context);

// Get responsive icon size
double iconSize = ResponsiveUtils.getResponsiveIconSize(context);

// Get responsive circular progress size
double circularSize = ResponsiveUtils.getResponsiveCircularSize(context);
```

### Custom Responsive Theme
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 2),
  displayStyle: CountdownDisplayStyle.detailed,
  useResponsiveSizing: true,
  theme: CountdownTheme.responsive(
    primaryColor: Colors.deepPurple,
    backgroundColor: Colors.deepPurple.shade50,
    fontConfig: const ResponsiveFontConfig(
      xs: 14.0,
      sm: 16.0,
      md: 18.0,
      lg: 20.0,
      xl: 22.0,
    ),
    paddingConfig: const ResponsivePaddingConfig(
      xs: EdgeInsets.all(8.0),
      sm: EdgeInsets.all(12.0),
      md: EdgeInsets.all(16.0),
      lg: EdgeInsets.all(20.0),
      xl: EdgeInsets.all(24.0),
    ),
    iconConfig: const ResponsiveIconConfig(
      xs: 16.0,
      sm: 18.0,
      md: 20.0,
      lg: 24.0,
      xl: 28.0,
    ),
  ),
  onFinish: () => print('Timer finished!'),
)
```

## Display Styles

### 1. Compact Style
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 2),
  displayStyle: CountdownDisplayStyle.compact,
  showControls: true,
  useResponsiveSizing: true,
)
```

### 2. Detailed Style
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1, seconds: 30),
  displayStyle: CountdownDisplayStyle.detailed,
  showControls: true,
  useResponsiveSizing: true,
)
```

### 3. Circular Style
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1),
  displayStyle: CountdownDisplayStyle.circular,
  showControls: true,
  useResponsiveSizing: true,
)
```

### 4. Minimal Style
```dart
AdvancedCountdownTimer(
  duration: const Duration(seconds: 45),
  displayStyle: CountdownDisplayStyle.minimal,
  useResponsiveSizing: true,
)
```

### 5. Bottom Bar Style
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 3),
  displayStyle: CountdownDisplayStyle.bottomBar,
  showControls: true,
  useResponsiveSizing: true,
)
```

### 6. Card Style
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1, seconds: 30),
  displayStyle: CountdownDisplayStyle.card,
  showControls: true,
  useResponsiveSizing: true,
)
```

### 7. Gradient Style
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1),
  displayStyle: CountdownDisplayStyle.gradient,
  useResponsiveSizing: true,
  onFinish: () => print('Timer finished!'),
)
```

## Theming

### Light Theme
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 2),
  theme: CountdownTheme.light(primaryColor: Colors.blue),
  useResponsiveSizing: true,
)
```

### Dark Theme
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1, seconds: 30),
  theme: CountdownTheme.dark(primaryColor: Colors.blue),
  useResponsiveSizing: true,
)
```

### Gradient Theme
```dart
Container(
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [Colors.purple, Colors.blue],
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  child: AdvancedCountdownTimer(
    duration: const Duration(minutes: 1),
    useResponsiveSizing: true,
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
)
```

## Provider Usage

### Setup Provider
```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final CountdownTimerProvider _provider = CountdownTimerProvider();

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<CountdownTimerProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Text(
                provider.formattedTime,
                style: TextStyle(
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, base: 32.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: provider.isRunning
                    ? provider.pauseTimer
                    : provider.resumeTimer,
                child: Text(provider.isRunning ? 'Pause' : 'Resume'),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

### Provider Methods
```dart
// Start timer
provider.startTimer(
  duration: const Duration(minutes: 5),
  onFinish: () => print('Finished!'),
);

// Pause timer
provider.pauseTimer();

// Resume timer
provider.resumeTimer();

// Reset timer
provider.resetTimer();

// Get formatted time
String time = provider.formattedTime;

// Check if timer is running
bool isRunning = provider.isRunning;
```

## Responsive Breakpoints

The package uses the following responsive breakpoints:

- **XS (Extra Small)**: < 480px (phones in portrait)
- **SM (Small)**: 480px - 768px (phones in landscape)
- **MD (Medium)**: 768px - 1024px (tablets in portrait)
- **LG (Large)**: 1024px - 1440px (tablets in landscape, small desktops)
- **XL (Extra Large)**: > 1440px (large desktops)

## Device Support

- ✅ **iPhone** (all sizes)
- ✅ **iPad** (all sizes)
- ✅ **Android Phones** (all sizes)
- ✅ **Android Tablets** (all sizes)
- ✅ **Desktop** (Windows, macOS, Linux)
- ✅ **Web** (responsive web design)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 