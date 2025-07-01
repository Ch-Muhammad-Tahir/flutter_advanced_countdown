import 'package:flutter/services.dart';

/// Utility class for haptic feedback
class HapticFeedback {
  /// Trigger light impact haptic feedback
  static Future<void> lightImpact() async {
    try {
      await SystemChannels.platform.invokeMethod('HapticFeedback.lightImpact');
    } catch (e) {
      // Ignore errors on platforms that don't support haptic feedback
    }
  }

  /// Trigger medium impact haptic feedback
  static Future<void> mediumImpact() async {
    try {
      await SystemChannels.platform.invokeMethod('HapticFeedback.mediumImpact');
    } catch (e) {
      // Ignore errors on platforms that don't support haptic feedback
    }
  }

  /// Trigger heavy impact haptic feedback
  static Future<void> heavyImpact() async {
    try {
      await SystemChannels.platform.invokeMethod('HapticFeedback.heavyImpact');
    } catch (e) {
      // Ignore errors on platforms that don't support haptic feedback
    }
  }

  /// Trigger selection change haptic feedback
  static Future<void> selectionChanged() async {
    try {
      await SystemChannels.platform.invokeMethod('HapticFeedback.selectionChanged');
    } catch (e) {
      // Ignore errors on platforms that don't support haptic feedback
    }
  }

  /// Trigger vibrate haptic feedback
  static Future<void> vibrate() async {
    try {
      await SystemChannels.platform.invokeMethod('HapticFeedback.vibrate');
    } catch (e) {
      // Ignore errors on platforms that don't support haptic feedback
    }
  }

  /// Trigger haptic feedback based on timer state
  static Future<void> forTimerState({
    required bool isFinished,
    bool isPaused = false,
    bool isResumed = false,
  }) async {
    if (isFinished) {
      await heavyImpact();
    } else if (isPaused) {
      await mediumImpact();
    } else if (isResumed) {
      await lightImpact();
    }
  }

  /// Trigger haptic feedback for countdown completion
  static Future<void> forCountdownComplete() async {
    await heavyImpact();
  }

  /// Trigger haptic feedback for countdown pause
  static Future<void> forCountdownPause() async {
    await mediumImpact();
  }

  /// Trigger haptic feedback for countdown resume
  static Future<void> forCountdownResume() async {
    await lightImpact();
  }

  /// Trigger haptic feedback for countdown reset
  static Future<void> forCountdownReset() async {
    await selectionChanged();
  }
} 