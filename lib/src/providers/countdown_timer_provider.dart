import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/countdown_config.dart';
import '../utils/haptic_feedback.dart';
import '../extensions/duration_extensions.dart';

/// Provider for managing countdown timer state across the app
class CountdownTimerProvider extends ChangeNotifier {
  Timer? _timer;
  Duration _remaining = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isRunning = false;
  bool _isPaused = false;
  bool _isVisible = false;
  bool _isFinished = false;
  bool _hasError = false;
  String? _errorMessage;

  // Callbacks
  VoidCallback? _onFinishCallback;
  VoidCallback? _onPauseCallback;
  VoidCallback? _onResumeCallback;
  VoidCallback? _onResetCallback;
  void Function(Duration remaining)? _onTickCallback;
  void Function(String error)? _onErrorCallback;

  // Configuration
  CountdownConfig? _config;

  // Getters
  /// Current remaining time
  Duration get remaining => _remaining;

  /// Total duration of the timer
  Duration get totalDuration => _totalDuration;

  /// Whether the timer is currently running
  bool get isRunning => _isRunning;

  /// Whether the timer is paused
  bool get isPaused => _isPaused;

  /// Whether the timer should be visible
  bool get isVisible => _isVisible;

  /// Whether the timer has finished
  bool get isFinished => _isFinished;

  /// Whether there's an error
  bool get hasError => _hasError;

  /// Error message if any
  String? get errorMessage => _errorMessage;

  /// Current configuration
  CountdownConfig? get config => _config;

  /// Formatted remaining time string
  String get formattedTime => _remaining.formattedSmart;

  /// Progress value (0.0 to 1.0)
  double get progress => _remaining.getProgress(_totalDuration);

  /// Percentage remaining (0 to 100)
  double get percentageRemaining => (progress * 100).clamp(0.0, 100.0);

  /// Whether the timer is active (running or paused)
  bool get isActive => _isRunning || _isPaused;

  /// Time elapsed
  Duration get elapsed => _totalDuration - _remaining;

  /// Formatted elapsed time
  String get formattedElapsed => elapsed.formattedSmart;

  /// Start a countdown timer
  void startTimer({
    required Duration duration,
    VoidCallback? onFinish,
    VoidCallback? onPause,
    VoidCallback? onResume,
    VoidCallback? onReset,
    void Function(Duration remaining)? onTick,
    void Function(String error)? onError,
    Duration interval = const Duration(seconds: 1),
    bool autoStart = true,
  }) {
    _clearError();

    if (duration.isNegative || duration.isZero) {
      _setError('Duration must be positive');
      return;
    }

    stopTimer();

    _config = CountdownConfig(
      duration: duration,
      interval: interval,
      autoStart: autoStart,
      onFinish: onFinish,
      onPause: onPause,
      onResume: onResume,
      onReset: onReset,
      onTick: onTick,
    );

    _totalDuration = duration;
    _remaining = duration;
    _onFinishCallback = onFinish;
    _onPauseCallback = onPause;
    _onResumeCallback = onResume;
    _onResetCallback = onReset;
    _onTickCallback = onTick;
    _onErrorCallback = onError;
    _isFinished = false;
    _isVisible = true;

    if (autoStart) {
      _startTimerInternal();
    }

    notifyListeners();
  }

  /// Start timer with configuration
  void startTimerWithConfig(CountdownConfig config) {
    startTimer(
      duration: config.duration,
      onFinish: config.onFinish,
      onPause: config.onPause,
      onResume: config.onResume,
      onReset: config.onReset,
      onTick: config.onTick,
      interval: config.interval,
      autoStart: config.autoStart,
    );
  }

  /// Pause the current timer
  void pauseTimer() {
    if (!_isRunning || _isPaused) return;

    _timer?.cancel();
    _isPaused = true;
    _isRunning = false;

    _onPauseCallback?.call();
    HapticFeedback.forCountdownPause();

    notifyListeners();
  }

  /// Resume the paused timer
  void resumeTimer() {
    if (!_isPaused) return;

    _isPaused = false;
    _startTimerInternal();

    _onResumeCallback?.call();
    HapticFeedback.forCountdownResume();

    notifyListeners();
  }

  /// Stop the current timer
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
    _isPaused = false;
    _isVisible = false;
    _isFinished = false;
    _remaining = Duration.zero;
    _totalDuration = Duration.zero;
    _config = null;
    _clearCallbacks();
    _clearError();

    notifyListeners();
  }

  /// Reset the timer to its original duration
  void resetTimer() {
    if (_totalDuration.isZero) return;

    _timer?.cancel();
    _remaining = _totalDuration;
    _isRunning = false;
    _isPaused = false;
    _isFinished = false;
    _clearError();

    _onResetCallback?.call();
    HapticFeedback.forCountdownReset();

    if (_config?.autoStart == true) {
      _startTimerInternal();
    }

    notifyListeners();
  }

  /// Hide the timer without stopping it
  void hideTimer() {
    _isVisible = false;
    notifyListeners();
  }

  /// Show the timer if it was hidden
  void showTimer() {
    if (isActive) {
      _isVisible = true;
      notifyListeners();
    }
  }

  /// Add time to the current timer
  void addTime(Duration additionalTime) {
    if (additionalTime.isNegative) {
      _setError('Cannot add negative time');
      return;
    }

    _remaining = _remaining + additionalTime;
    _totalDuration = _totalDuration + additionalTime;
    _isFinished = false;

    notifyListeners();
  }

  /// Subtract time from the current timer
  void subtractTime(Duration timeToSubtract) {
    if (timeToSubtract.isNegative) {
      _setError('Cannot subtract negative time');
      return;
    }

    if (_remaining > timeToSubtract) {
      _remaining = _remaining - timeToSubtract;
      _totalDuration = _totalDuration - timeToSubtract;
    } else {
      _remaining = Duration.zero;
      _finishTimer();
    }

    notifyListeners();
  }

  /// Set remaining time directly
  void setRemainingTime(Duration time) {
    if (time.isNegative) {
      _setError('Remaining time cannot be negative');
      return;
    }

    _remaining = time;
    if (_remaining.isZero) {
      _finishTimer();
    }

    notifyListeners();
  }

  /// Set a custom callback for when the timer finishes
  void setOnFinishCallback(VoidCallback callback) {
    _onFinishCallback = callback;
  }

  /// Set a custom callback for every tick
  void setOnTickCallback(void Function(Duration remaining) callback) {
    _onTickCallback = callback;
  }

  /// Set a custom callback for errors
  void setOnErrorCallback(void Function(String error) callback) {
    _onErrorCallback = callback;
  }

  /// Get timer status as a string
  String get status {
    if (_hasError) return 'Error: $_errorMessage';
    if (_isFinished) return 'Finished';
    if (_isPaused) return 'Paused';
    if (_isRunning) return 'Running';
    return 'Stopped';
  }

  /// Check if timer is in warning state (less than 10% remaining)
  bool get isWarning =>
      percentageRemaining <= 10.0 && percentageRemaining > 0.0;

  /// Check if timer is in critical state (less than 5% remaining)
  bool get isCritical =>
      percentageRemaining <= 5.0 && percentageRemaining > 0.0;

  /// Get time remaining in different units
  int get remainingHours => _remaining.remainingHours;
  int get remainingMinutes => _remaining.remainingMinutes;
  int get remainingSeconds => _remaining.remainingSeconds;
  int get remainingMilliseconds => _remaining.remainingMilliseconds;

  // Private methods
  void _startTimerInternal() {
    if (_isRunning) return;

    _isRunning = true;
    _isPaused = false;

    final interval = _config?.interval ?? const Duration(seconds: 1);

    _timer = Timer.periodic(interval, (timer) {
      if (_remaining.inMilliseconds <= 0) {
        _finishTimer();
      } else {
        _remaining = _remaining - interval;
        _onTickCallback?.call(_remaining);
        notifyListeners();
      }
    });
  }

  void _finishTimer() {
    _timer?.cancel();
    _isRunning = false;
    _isPaused = false;
    _isFinished = true;
    _remaining = Duration.zero;

    _onFinishCallback?.call();
    HapticFeedback.forCountdownComplete();

    notifyListeners();
  }

  void _setError(String message) {
    _hasError = true;
    _errorMessage = message;
    _onErrorCallback?.call(message);
    notifyListeners();
  }

  void _clearError() {
    _hasError = false;
    _errorMessage = null;
  }

  void _clearCallbacks() {
    _onFinishCallback = null;
    _onPauseCallback = null;
    _onResumeCallback = null;
    _onResetCallback = null;
    _onTickCallback = null;
    _onErrorCallback = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
