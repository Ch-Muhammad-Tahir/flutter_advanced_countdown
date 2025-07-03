# Advanced Countdown Timer Package

A **professional, feature-rich countdown timer package** for Flutter with **multiple display styles**, **advanced animations**, **comprehensive theming**, and **full responsive design** for all devices (iPhone, iPad, Android, Desktop, Web).

## ✨ Features

### 🎨 **Professional Display Styles**
- **Compact**: Icon + time with controls
- **Detailed**: Title + large time display  
- **Circular**: Progress ring with time in center
- **Minimal**: Just the time
- **Bottom Bar**: Navigation bar style
- **Card**: Elevated card with rounded corners
- **Gradient**: Background gradient style
- **Digital**: Segmented digital display
- **Analog**: Clock-style display with hands
- **Progress Bar**: Linear progress with time overlay
- **Floating**: Circular floating action button style
- **Notification**: Badge-style notification display
- **Custom**: Complete custom builder support

### 📱 **Full Responsive Design**
- **Automatic adaptation** to iPhone, iPad, Android, and Desktop screen sizes
- **Smart breakpoints**: XS, SM, MD, LG, XL
- **Device detection**: Phone, tablet, desktop identification
- **Responsive sizing**: Fonts, padding, icons, spacing
- **Custom responsive themes** with breakpoint-specific configurations

### ⚡ **Advanced Animation System**
- **Pulse animation** when time is low
- **Shake animation** when timer finishes
- **Scale animations** on state changes
- **Fade transitions** for smooth UX
- **Custom animation curves** and durations
- **Custom animation builders** for complete control
- **Performance optimized** with proper disposal

### 🎯 **Professional Theming**
- **Light/Dark themes** with Material Design colors
- **Gradient themes** with custom color schemes
- **Glass morphism** with blur effects
- **Minimal themes** for clean designs
- **Professional themes** with shadows and animations
- **Custom responsive themes** with breakpoint configurations
- **Advanced styling** with custom decorations and transforms

### 🔧 **Advanced Customization**
- **Custom builders** for complete UI control
- **Advanced styling** with custom borders, shapes, and transforms
- **Custom constraints** and sizing options
- **Custom decorations** and foreground decorations
- **Semantic labels** for accessibility
- **Custom time formatters** and unit labels
- **Low time warnings** with custom thresholds

### 🎮 **Enhanced Interactions**
- **Haptic feedback** for better UX
- **Vibration feedback** (platform support)
- **Sound notifications** (audio plugin integration)
- **Auto-hide** when timer finishes
- **Progress tracking** with percentage display
- **State management** with ChangeNotifier provider
- **Error handling** and validation

### 📊 **Professional Features**
- **Multiple time formats**: HH:MM:SS, MM:SS, SS, milliseconds
- **Smart formatting**: Automatic format selection
- **Progress calculation**: Built-in progress tracking
- **Duration extensions**: Convenience methods and arithmetic
- **Responsive utilities**: Device detection and sizing
- **Comprehensive testing**: Unit and widget tests
- **Complete documentation**: API reference and examples

## 🚀 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_advanced_countdown: ^1.0.0
```

## 🎯 Quick Start

### Basic Usage

```dart
import 'package:flutter_advanced_countdown/flutter_advanced_countdown.dart';

// Simple responsive countdown timer
AdvancedCountdownTimer(
  duration: const Duration(minutes: 5),
  onFinish: () => print('Timer finished!'),
)
```

### Professional Theme

```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 2, seconds: 30),
  displayStyle: CountdownDisplayStyle.detailed,
  showControls: true,
  showReset: true,
  theme: CountdownTheme.professional(
    primaryColor: Colors.indigo,
    enableAnimations: true,
    enableShadows: true,
    enableRoundedCorners: true,
  ),
  onFinish: () => print('Timer finished!'),
)
```

### Advanced Animations

```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1, seconds: 30),
  displayStyle: CountdownDisplayStyle.circular,
  showControls: true,
  animationConfig: CountdownAnimationConfig(
    enabled: true,
    duration: const Duration(milliseconds: 500),
    curve: Curves.bounceOut,
    enablePulseAnimation: true,
    pulseThreshold: 15,
    enableShakeAnimation: true,
    enableScaleAnimation: true,
    enableFadeAnimation: true,
  ),
  onFinish: () => print('Timer finished!'),
)
```

## 🎨 Display Styles

### 1. Professional Theme
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 2),
  displayStyle: CountdownDisplayStyle.detailed,
  theme: CountdownTheme.professional(
    primaryColor: Colors.indigo,
    enableAnimations: true,
    enableShadows: true,
    enableRoundedCorners: true,
  ),
)
```

### 2. Glass Morphism Theme
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.purple, Colors.blue],
    ),
  ),
  child: AdvancedCountdownTimer(
    duration: const Duration(minutes: 1),
    displayStyle: CountdownDisplayStyle.circular,
    theme: CountdownTheme.glassMorphism(
      primaryColor: Colors.white,
      blurRadius: 15.0,
    ),
  ),
)
```

### 3. Digital Display
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1, seconds: 30),
  displayStyle: CountdownDisplayStyle.digital,
  showControls: true,
  theme: CountdownTheme.dark(primaryColor: Colors.cyan),
)
```

### 4. Analog Display
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 2),
  displayStyle: CountdownDisplayStyle.analog,
  showControls: true,
  theme: CountdownTheme.light(primaryColor: Colors.orange),
)
```

### 5. Progress Bar Display
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1, seconds: 45),
  displayStyle: CountdownDisplayStyle.progressBar,
  showControls: true,
  showLowTimeWarning: true,
  lowTimeWarningThreshold: 30,
  warningColor: Colors.red,
  theme: CountdownTheme.light(primaryColor: Colors.green),
)
```

### 6. Floating Display
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1),
  displayStyle: CountdownDisplayStyle.floating,
  showControls: true,
  theme: CountdownTheme.gradient(
    colors: [Colors.pink, Colors.purple],
    textColor: Colors.white,
  ),
)
```

### 7. Notification Display
```dart
AdvancedCountdownTimer(
  duration: const Duration(seconds: 45),
  displayStyle: CountdownDisplayStyle.notification,
  showControls: true,
  theme: CountdownTheme.light(primaryColor: Colors.red),
)
```

## ⚡ Advanced Animations

### Custom Animation Configuration
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1, seconds: 30),
  animationConfig: CountdownAnimationConfig(
    enabled: true,
    duration: const Duration(milliseconds: 500),
    curve: Curves.bounceOut,
    enablePulseAnimation: true,
    pulseThreshold: 15,
    enableShakeAnimation: true,
    enableScaleAnimation: true,
    enableFadeAnimation: true,
  ),
)
```

### Custom Animation Builder
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1),
  animationConfig: CountdownAnimationConfig(
    customAnimationBuilder: (child, animation) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  ),
)
```

## 🎯 Custom Builders

### Complete Custom UI
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1, seconds: 30),
  displayStyle: CountdownDisplayStyle.custom,
  customBuilderConfig: CountdownCustomBuilderConfig(
    timeBuilder: (context, remaining, isRunning, isPaused) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isRunning 
                ? [Colors.green, Colors.lightGreen]
                : [Colors.orange, Colors.deepOrange],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              isRunning ? Icons.play_circle : Icons.pause_circle,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              remaining.formattedSmart,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              isRunning ? 'Running' : 'Paused',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      );
    },
  ),
)
```

## 🔧 Advanced Styling

### Custom Decoration and Constraints
```dart
AdvancedCountdownTimer(
  duration: const Duration(minutes: 1),
  displayStyle: CountdownDisplayStyle.card,
  showControls: true,
  theme: CountdownTheme.light(primaryColor: Colors.blue).copyWith(
    width: 200,
    height: 120,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Colors.blue, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
  ),
  advancedStyle: const CountdownAdvancedStyle(
    alignment: Alignment.center,
    semanticLabel: 'Advanced styled countdown timer',
  ),
)
```

## 📱 Responsive Design

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
  showControls: true,
  useResponsiveSizing: true,
  theme: CountdownTheme.responsive(
    primaryColor: Colors.deepPurple,
    backgroundColor: Colors.deepPurple.shade50,
    textColor: Colors.deepPurple.shade900,
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
    animationConfig: CountdownAnimationConfig(
      enabled: true,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      enablePulseAnimation: true,
      enableShakeAnimation: true,
      enableScaleAnimation: true,
      enableFadeAnimation: true,
    ),
  ),
  onFinish: () => print('Timer finished!'),
)
```

## 🎮 Provider Integration

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

## 📊 Responsive Breakpoints

The package uses the following responsive breakpoints:

- **XS (Extra Small)**: < 480px (phones in portrait)
- **SM (Small)**: 480px - 768px (phones in landscape)
- **MD (Medium)**: 768px - 1024px (tablets in portrait)
- **LG (Large)**: 1024px - 1440px (tablets in landscape, small desktops)
- **XL (Extra Large)**: > 1440px (large desktops)

## 📱 Device Support

- ✅ **iPhone** (all sizes)
- ✅ **iPad** (all sizes)
- ✅ **Android Phones** (all sizes)
- ✅ **Android Tablets** (all sizes)
- ✅ **Desktop** (Windows, macOS, Linux)
- ✅ **Web** (responsive web design)

## 🎯 Professional Features

### Enhanced User Experience
- **Haptic feedback** for better interaction
- **Vibration feedback** for notifications
- **Sound notifications** for timer completion
- **Auto-hide** when timer finishes
- **Low time warnings** with visual indicators
- **Smooth animations** for state transitions

### Advanced Customization
- **Custom builders** for complete UI control
- **Advanced styling** with custom decorations
- **Custom constraints** and sizing
- **Semantic labels** for accessibility
- **Custom time formatters** and labels
- **Professional themes** with modern design

### Performance Optimizations
- **Efficient animations** with proper disposal
- **Memory management** for long-running timers
- **Responsive caching** for performance
- **Minimal rebuilds** with ChangeNotifier
- **Optimized rendering** for smooth UX

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 