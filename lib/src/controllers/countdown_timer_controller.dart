import 'package:flutter/widgets.dart';

/// An imperative controller that gives outside code the ability to start,
/// pause, resume, reset, or seek an [AdvancedCountdownTimer] instance.
///
/// The widget binds itself to the controller during [State.initState] and
/// cleans up during [State.dispose]. If no widget is attached the methods
/// become no-ops.
class CountdownTimerController {
  VoidCallback? _start;
  VoidCallback? _pause;
  VoidCallback? _resume;
  VoidCallback? _reset;
  void Function(Duration)? _seek;

  /// Whether a widget is currently attached.
  bool get isAttached => _start != null;

  // -------------------------------------------------------------------------
  // Public API – these forward to the bound widget if present.
  // -------------------------------------------------------------------------
  void start() => _start?.call();
  void pause() => _pause?.call();
  void resume() => _resume?.call();
  void reset() => _reset?.call();
  void seek(Duration remaining) => _seek?.call(remaining);

  // -------------------------------------------------------------------------
  // Internal – used by the widget to register callbacks.
  // -------------------------------------------------------------------------
  // Called by the widget – not intended for app code.
  void attachInternal({
    required VoidCallback start,
    required VoidCallback pause,
    required VoidCallback resume,
    required VoidCallback reset,
    required void Function(Duration) seek,
  }) {
    _start = start;
    _pause = pause;
    _resume = resume;
    _reset = reset;
    _seek = seek;
  }

  void detachInternal() {
    _start = null;
    _pause = null;
    _resume = null;
    _reset = null;
    _seek = null;
  }
}
