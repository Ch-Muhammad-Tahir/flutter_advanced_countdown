import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_advanced_countdown/flutter_advanced_countdown.dart';

void main() {
  group('CountdownTimerProvider Tests', () {
    late CountdownTimerProvider provider;

    setUp(() {
      provider = CountdownTimerProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('should initialize with default values', () {
      expect(provider.remaining, Duration.zero);
      expect(provider.isRunning, false);
      expect(provider.isPaused, false);
      expect(provider.isVisible, false);
      expect(provider.isFinished, false);
      expect(provider.hasError, false);
      expect(provider.errorMessage, null);
    });

    test('should start timer correctly', () {
      provider.startTimer(duration: const Duration(minutes: 2));
      
      expect(provider.remaining, const Duration(minutes: 2));
      expect(provider.isRunning, true);
      expect(provider.isVisible, true);
      expect(provider.isFinished, false);
    });

    test('should pause and resume timer', () {
      provider.startTimer(duration: const Duration(minutes: 1));
      expect(provider.isRunning, true);
      
      provider.pauseTimer();
      expect(provider.isPaused, true);
      expect(provider.isRunning, false);
      
      provider.resumeTimer();
      expect(provider.isPaused, false);
      expect(provider.isRunning, true);
    });

    test('should reset timer', () {
      provider.startTimer(duration: const Duration(minutes: 2), autoStart: false);
      provider.pauseTimer();
      
      provider.resetTimer();
      expect(provider.remaining, const Duration(minutes: 2));
      expect(provider.isPaused, false);
      expect(provider.isRunning, false);
    });

    test('should stop timer', () {
      provider.startTimer(duration: const Duration(minutes: 1));
      provider.stopTimer();
      
      expect(provider.remaining, Duration.zero);
      expect(provider.isRunning, false);
      expect(provider.isPaused, false);
      expect(provider.isVisible, false);
    });

    test('should add and subtract time', () {
      provider.startTimer(duration: const Duration(minutes: 1));
      
      provider.addTime(const Duration(seconds: 30));
      expect(provider.remaining, const Duration(minutes: 1, seconds: 30));
      
      provider.subtractTime(const Duration(seconds: 15));
      expect(provider.remaining, const Duration(minutes: 1, seconds: 15));
    });

    test('should handle errors correctly', () {
      provider.startTimer(duration: const Duration(seconds: -1));
      expect(provider.hasError, true);
      expect(provider.errorMessage, 'Duration must be positive');
    });

    test('should calculate progress correctly', () {
      provider.startTimer(duration: const Duration(minutes: 2));
      expect(provider.progress, 0.0);
      
      // Simulate time passing
      provider.setRemainingTime(const Duration(minutes: 1));
      expect(provider.progress, 0.5);
      
      provider.setRemainingTime(Duration.zero);
      expect(provider.progress, 1.0);
    });

    test('should format time correctly', () {
      provider.startTimer(duration: const Duration(hours: 1, minutes: 30, seconds: 45));
      expect(provider.formattedTime, '01:30:45');
      
      provider.setRemainingTime(const Duration(minutes: 5, seconds: 30));
      expect(provider.formattedTime, '05:30');
      
      provider.setRemainingTime(const Duration(seconds: 45));
      expect(provider.formattedTime, '45');
    });
  });

  group('TimeFormatter Tests', () {
    test('should format HH:MM:SS correctly', () {
      final duration = const Duration(hours: 2, minutes: 30, seconds: 45);
      expect(TimeFormatter.formatHHMMSS(duration), '02:30:45');
    });

    test('should format MM:SS correctly', () {
      final duration = const Duration(minutes: 5, seconds: 30);
      expect(TimeFormatter.formatMMSS(duration), '05:30');
    });

    test('should format SS correctly', () {
      final duration = const Duration(seconds: 45);
      expect(TimeFormatter.formatSS(duration), '45');
    });

    test('should format with milliseconds correctly', () {
      final duration = const Duration(seconds: 5, milliseconds: 500);
      expect(TimeFormatter.formatWithMilliseconds(duration), '05.50');
    });

    test('should format with words correctly', () {
      final duration = const Duration(hours: 1, minutes: 30, seconds: 45);
      expect(TimeFormatter.formatWords(duration), '1 hour 30 minutes 45 seconds');
    });

    test('should format with short words correctly', () {
      final duration = const Duration(hours: 1, minutes: 30, seconds: 45);
      expect(TimeFormatter.formatShortWords(duration), '1h 30m 45s');
    });

    test('should format custom pattern correctly', () {
      final duration = const Duration(hours: 2, minutes: 30, seconds: 45);
      expect(TimeFormatter.formatCustom(duration, '{h}:{m}:{s}'), '02:30:45');
    });

    test('should format smart correctly', () {
      expect(TimeFormatter.formatSmart(const Duration(hours: 1, minutes: 30)), '01:30:00');
      expect(TimeFormatter.formatSmart(const Duration(minutes: 5, seconds: 30)), '05:30');
      expect(TimeFormatter.formatSmart(const Duration(seconds: 45)), '45');
    });
  });

  group('Duration Extensions Tests', () {
    test('should format duration correctly', () {
      final duration = const Duration(hours: 1, minutes: 30, seconds: 45);
      expect(duration.formattedHHMMSS, '01:30:45');
      expect(duration.formattedMMSS, '90:45');
      expect(duration.formattedSS, '5445');
    });

    test('should check duration properties correctly', () {
      expect(Duration.zero.isZero, true);
      expect(const Duration(seconds: 1).isPositive, true);
      expect(const Duration(seconds: -1).isNegative, true);
    });

    test('should calculate progress correctly', () {
      final duration = const Duration(minutes: 2);
      final total = const Duration(minutes: 4);
      expect(duration.getProgress(total), 0.5);
    });

    test('should perform arithmetic operations correctly', () {
      final d1 = const Duration(minutes: 2);
      final d2 = const Duration(minutes: 1);
      
      expect(d1 + d2, const Duration(minutes: 3));
      expect(d1 - d2, const Duration(minutes: 1));
      expect(d1 * 2, const Duration(minutes: 4));
      expect(d1 / 2, const Duration(minutes: 1));
    });

    test('should compare durations correctly', () {
      final d1 = const Duration(minutes: 2);
      final d2 = const Duration(minutes: 1);
      
      expect(d1 > d2, true);
      expect(d1 < d2, false);
      expect(d1 >= d2, true);
      expect(d1 <= d2, false);
    });

    test('should find min and max correctly', () {
      final d1 = const Duration(minutes: 2);
      final d2 = const Duration(minutes: 1);
      
      expect(d1.min(d2), d2);
      expect(d1.max(d2), d1);
    });

    test('should clamp duration correctly', () {
      final duration = const Duration(minutes: 2);
      final min = const Duration(minutes: 1);
      final max = const Duration(minutes: 3);
      
      expect(duration.clamp(min, max), duration);
      expect(duration.clamp(max, max), max);
      expect(duration.clamp(min, min), min);
    });

    test('should format human readable correctly', () {
      final duration = const Duration(hours: 1, minutes: 30, seconds: 45);
      expect(duration.humanReadable, '1 hour 30 minutes 45 seconds');
      expect(duration.humanReadableShort, '1h 30m 45s');
    });
  });

  group('CountdownConfig Tests', () {
    test('should create config with required parameters', () {
      final config = CountdownConfig(
        duration: const Duration(minutes: 5),
        onFinish: () {},
      );
      
      expect(config.duration, const Duration(minutes: 5));
      expect(config.interval, const Duration(seconds: 1));
      expect(config.autoStart, true);
      expect(config.showControls, false);
      expect(config.showReset, false);
      expect(config.showMilliseconds, false);
    });

    test('should copy config correctly', () {
      final original = CountdownConfig(
        duration: const Duration(minutes: 5),
        showControls: true,
      );
      
      final copied = original.copyWith(
        duration: const Duration(minutes: 10),
        showReset: true,
      );
      
      expect(copied.duration, const Duration(minutes: 10));
      expect(copied.showControls, true);
      expect(copied.showReset, true);
    });

    test('should compare configs correctly', () {
      final config1 = CountdownConfig(duration: const Duration(minutes: 5));
      final config2 = CountdownConfig(duration: const Duration(minutes: 5));
      final config3 = CountdownConfig(duration: const Duration(minutes: 10));
      
      expect(config1 == config2, true);
      expect(config1 == config3, false);
    });
  });

  group('CountdownTheme Tests', () {
    test('should create theme with default values', () {
      final theme = CountdownTheme();
      
      expect(theme.primaryColor, Colors.blue);
      expect(theme.borderRadius, 8.0);
      expect(theme.borderWidth, 1.0);
      expect(theme.progressStrokeWidth, 6.0);
    });

    test('should create light theme correctly', () {
      final theme = CountdownTheme.light(primaryColor: Colors.red);
      
      expect(theme.primaryColor, Colors.red);
      expect(theme.backgroundColor, Colors.white);
      expect(theme.textColor, Colors.black87);
      expect(theme.boxShadow, isNotNull);
    });

    test('should create dark theme correctly', () {
      final theme = CountdownTheme.dark(primaryColor: Colors.green);
      
      expect(theme.primaryColor, Colors.green);
      expect(theme.backgroundColor, Colors.grey.shade900);
      expect(theme.textColor, Colors.white);
      expect(theme.boxShadow, isNotNull);
    });

    test('should create gradient theme correctly', () {
      final gradient = LinearGradient(colors: [Colors.purple, Colors.blue]);
      final theme = CountdownTheme.gradient(gradient: gradient);
      
      expect(theme.gradient, gradient);
      expect(theme.primaryColor, Colors.white);
      expect(theme.borderColor, Colors.transparent);
    });

    test('should copy theme correctly', () {
      final original = CountdownTheme(primaryColor: Colors.red);
      final copied = original.copyWith(primaryColor: Colors.blue);
      
      expect(copied.primaryColor, Colors.blue);
      expect(copied.borderRadius, original.borderRadius);
    });
  });
} 