import 'package:flutter/material.dart';

/// Configuration class for countdown timer behavior and appearance
class CountdownConfig {
  /// Duration for the countdown
  final Duration duration;

  /// Timer interval (default: 1 second)
  final Duration interval;

  /// Whether to auto-start the timer
  final bool autoStart;

  /// Whether to show pause/resume controls
  final bool showControls;

  /// Whether to show reset control
  final bool showReset;

  /// Whether to show milliseconds
  final bool showMilliseconds;

  /// Animation duration for transitions
  final Duration animationDuration;

  /// Whether to enable haptic feedback
  final bool enableHapticFeedback;

  /// Custom formatter for the time display
  final String Function(Duration)? customFormatter;

  /// Callback when countdown finishes
  final VoidCallback? onFinish;

  /// Callback when countdown is paused
  final VoidCallback? onPause;

  /// Callback when countdown is resumed
  final VoidCallback? onResume;

  /// Callback when countdown is reset
  final VoidCallback? onReset;

  /// Callback for every tick (optional)
  final void Function(Duration remaining)? onTick;

  const CountdownConfig({
    required this.duration,
    this.interval = const Duration(seconds: 1),
    this.autoStart = true,
    this.showControls = false,
    this.showReset = false,
    this.showMilliseconds = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableHapticFeedback = true,
    this.customFormatter,
    this.onFinish,
    this.onPause,
    this.onResume,
    this.onReset,
    this.onTick,
  });

  /// Creates a copy of this config with the given fields replaced
  CountdownConfig copyWith({
    Duration? duration,
    Duration? interval,
    bool? autoStart,
    bool? showControls,
    bool? showReset,
    bool? showMilliseconds,
    Duration? animationDuration,
    bool? enableHapticFeedback,
    String Function(Duration)? customFormatter,
    VoidCallback? onFinish,
    VoidCallback? onPause,
    VoidCallback? onResume,
    VoidCallback? onReset,
    void Function(Duration remaining)? onTick,
  }) {
    return CountdownConfig(
      duration: duration ?? this.duration,
      interval: interval ?? this.interval,
      autoStart: autoStart ?? this.autoStart,
      showControls: showControls ?? this.showControls,
      showReset: showReset ?? this.showReset,
      showMilliseconds: showMilliseconds ?? this.showMilliseconds,
      animationDuration: animationDuration ?? this.animationDuration,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      customFormatter: customFormatter ?? this.customFormatter,
      onFinish: onFinish ?? this.onFinish,
      onPause: onPause ?? this.onPause,
      onResume: onResume ?? this.onResume,
      onReset: onReset ?? this.onReset,
      onTick: onTick ?? this.onTick,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountdownConfig &&
        other.duration == duration &&
        other.interval == interval &&
        other.autoStart == autoStart &&
        other.showControls == showControls &&
        other.showReset == showReset &&
        other.showMilliseconds == showMilliseconds &&
        other.animationDuration == animationDuration &&
        other.enableHapticFeedback == enableHapticFeedback;
  }

  @override
  int get hashCode {
    return Object.hash(
      duration,
      interval,
      autoStart,
      showControls,
      showReset,
      showMilliseconds,
      animationDuration,
      enableHapticFeedback,
    );
  }

  @override
  String toString() {
    return 'CountdownConfig(duration: $duration, interval: $interval, autoStart: $autoStart, showControls: $showControls, showReset: $showReset, showMilliseconds: $showMilliseconds, animationDuration: $animationDuration, enableHapticFeedback: $enableHapticFeedback)';
  }
}
