import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/countdown_config.dart';
import '../models/countdown_style.dart';
import '../utils/time_formatter.dart';
import '../utils/haptic_feedback.dart';
import '../utils/responsive_utils.dart';
import '../extensions/duration_extensions.dart';

/// Advanced Countdown Timer Widget
/// A professional, reusable countdown timer with multiple display options
class AdvancedCountdownTimer extends StatefulWidget {
  /// Configuration for the countdown timer
  final CountdownConfig config;
  
  /// Display style for the timer
  final CountdownDisplayStyle displayStyle;
  
  /// Theme configuration for the timer appearance
  final CountdownTheme? theme;
  
  /// Custom text style for the timer
  final TextStyle? textStyle;
  
  /// Custom text style for the title (in detailed mode)
  final TextStyle? titleTextStyle;
  
  /// Custom widget builder for complete customization
  final Widget Function(BuildContext, Duration, bool, bool, VoidCallback?)? customBuilder;
  
  /// Whether to show milliseconds
  final bool showMilliseconds;
  
  /// Custom formatter for the time display
  final String Function(Duration)? customFormatter;
  
  /// Animation duration for transitions
  final Duration animationDuration;
  
  /// Whether to enable haptic feedback
  final bool enableHapticFeedback;
  
  /// Custom title text for detailed mode
  final String? titleText;
  
  /// Custom subtitle text
  final String? subtitleText;
  
  /// Whether to show progress indicator
  final bool showProgress;
  
  /// Progress indicator stroke width (for circular style)
  final double? progressStrokeWidth;
  
  /// Progress indicator background color
  final Color? progressBackgroundColor;
  
  /// Progress indicator value color
  final Color? progressValueColor;

  /// Whether to use responsive sizing (default: true)
  final bool useResponsiveSizing;

  /// Custom animation configuration
  final CountdownAnimationConfig? animationConfig;

  /// Custom builder configuration
  final CountdownCustomBuilderConfig? customBuilderConfig;

  /// Advanced styling configuration
  final CountdownAdvancedStyle? advancedStyle;

  /// Custom decoration
  final Decoration? decoration;

  /// Custom foreground decoration
  final Decoration? foregroundDecoration;

  /// Custom width
  final double? width;

  /// Custom height
  final double? height;

  /// Custom min width
  final double? minWidth;

  /// Custom min height
  final double? minHeight;

  /// Custom max width
  final double? maxWidth;

  /// Custom max height
  final double? maxHeight;

  /// Whether to show time units (hours, minutes, seconds)
  final bool showTimeUnits;

  /// Custom time unit labels
  final Map<String, String>? timeUnitLabels;

  /// Whether to enable sound notifications
  final bool enableSoundNotifications;

  /// Custom sound file path
  final String? customSoundPath;

  /// Whether to show warning when time is low
  final bool showLowTimeWarning;

  /// Low time warning threshold (seconds)
  final int lowTimeWarningThreshold;

  /// Custom warning color
  final Color? warningColor;

  /// Whether to enable auto-hide when finished
  final bool autoHideWhenFinished;

  /// Auto-hide delay
  final Duration autoHideDelay;

  /// Whether to enable vibration feedback
  final bool enableVibrationFeedback;

  /// Custom vibration pattern
  final List<int>? vibrationPattern;

  AdvancedCountdownTimer({
    Key? key,
    CountdownConfig? config,
    Duration? duration,
    VoidCallback? onFinish,
    VoidCallback? onPause,
    VoidCallback? onResume,
    VoidCallback? onReset,
    void Function(Duration remaining)? onTick,
    Duration interval = const Duration(seconds: 1),
    bool autoStart = true,
    bool showControls = false,
    bool showReset = false,
    this.displayStyle = CountdownDisplayStyle.compact,
    this.theme,
    this.textStyle,
    this.titleTextStyle,
    this.customBuilder,
    this.showMilliseconds = false,
    this.customFormatter,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableHapticFeedback = true,
    this.titleText,
    this.subtitleText,
    this.showProgress = true,
    this.progressStrokeWidth,
    this.progressBackgroundColor,
    this.progressValueColor,
    this.useResponsiveSizing = true,
    this.animationConfig,
    this.customBuilderConfig,
    this.advancedStyle,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.showTimeUnits = false,
    this.timeUnitLabels,
    this.enableSoundNotifications = false,
    this.customSoundPath,
    this.showLowTimeWarning = true,
    this.lowTimeWarningThreshold = 10,
    this.warningColor,
    this.autoHideWhenFinished = false,
    this.autoHideDelay = const Duration(seconds: 3),
    this.enableVibrationFeedback = false,
    this.vibrationPattern,
  }) : config = config ?? CountdownConfig(
         duration: duration ?? const Duration(minutes: 1),
         interval: interval,
         autoStart: autoStart,
         showControls: showControls,
         showReset: showReset,
         onFinish: onFinish,
         onPause: onPause,
         onResume: onResume,
         onReset: onReset,
         onTick: onTick,
       ),
       super(key: key);

  /// Constructor with individual parameters for backward compatibility
  AdvancedCountdownTimer.legacy({
    Key? key,
    required Duration duration,
    VoidCallback? onFinish,
    VoidCallback? onPause,
    VoidCallback? onResume,
    VoidCallback? onReset,
    void Function(Duration remaining)? onTick,
    Duration interval = const Duration(seconds: 1),
    bool autoStart = true,
    bool showControls = false,
    bool showReset = false,
    this.displayStyle = CountdownDisplayStyle.compact,
    this.theme,
    this.textStyle,
    this.titleTextStyle,
    this.customBuilder,
    this.showMilliseconds = false,
    this.customFormatter,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableHapticFeedback = true,
    this.titleText,
    this.subtitleText,
    this.showProgress = true,
    this.progressStrokeWidth,
    this.progressBackgroundColor,
    this.progressValueColor,
    this.useResponsiveSizing = true,
    this.animationConfig,
    this.customBuilderConfig,
    this.advancedStyle,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.showTimeUnits = false,
    this.timeUnitLabels,
    this.enableSoundNotifications = false,
    this.customSoundPath,
    this.showLowTimeWarning = true,
    this.lowTimeWarningThreshold = 10,
    this.warningColor,
    this.autoHideWhenFinished = false,
    this.autoHideDelay = const Duration(seconds: 3),
    this.enableVibrationFeedback = false,
    this.vibrationPattern,
  }) : config = CountdownConfig(
         duration: duration,
         interval: interval,
         autoStart: autoStart,
         showControls: showControls,
         showReset: showReset,
         onFinish: onFinish,
         onPause: onPause,
         onResume: onResume,
         onReset: onReset,
         onTick: onTick,
       ),
       super(key: key);

  @override
  State<AdvancedCountdownTimer> createState() => _AdvancedCountdownTimerState();
}

class _AdvancedCountdownTimerState extends State<AdvancedCountdownTimer>
    with TickerProviderStateMixin {
  late Timer _timer;
  late Duration _remaining;
  bool _isRunning = false;
  bool _isPaused = false;
  bool _isFinished = false;
  bool _isVisible = true;
  bool _isLowTime = false;
  
  // Animation controllers
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late AnimationController _shakeController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  
  // Animations
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _remaining = widget.config.duration;
    _setupAnimations();
    _checkLowTime();
    
    if (widget.config.autoStart) {
      _startTimer();
    }
  }

  void _setupAnimations() {
    final animationConfig = _effectiveAnimationConfig;
    
    if (!animationConfig.enabled) return;
    
    _animationController = AnimationController(
      duration: animationConfig.duration,
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: animationConfig.duration,
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: animationConfig.duration,
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: animationConfig.curve,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));
    
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.forward();
    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    _pulseController.dispose();
    _shakeController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning) return;
    
    setState(() {
      _isRunning = true;
      _isPaused = false;
    });
    
    _timer = Timer.periodic(widget.config.interval, (timer) {
      setState(() {
        if (_remaining.inMilliseconds <= 0) {
          _timer.cancel();
          _isRunning = false;
          _isFinished = true;
          _handleTimerFinish();
        } else {
          _remaining = _remaining - widget.config.interval;
          _checkLowTime();
          widget.config.onTick?.call(_remaining);
        }
      });
    });
  }

  void _handleTimerFinish() {
    widget.config.onFinish?.call();
    
    if (widget.enableHapticFeedback) {
      HapticFeedback.forCountdownComplete();
    }
    
    if (widget.enableVibrationFeedback) {
      _triggerVibration();
    }
    
    if (widget.enableSoundNotifications) {
      _playSound();
    }
    
    if (_effectiveAnimationConfig.enableShakeAnimation) {
      _shakeController.repeat(reverse: true);
      Future.delayed(const Duration(seconds: 2), () {
        _shakeController.stop();
      });
    }
    
    if (widget.autoHideWhenFinished) {
      Future.delayed(widget.autoHideDelay, () {
        if (mounted) {
          setState(() {
            _isVisible = false;
          });
        }
      });
    }
  }

  void _checkLowTime() {
    final wasLowTime = _isLowTime;
    _isLowTime = _remaining.inSeconds <= widget.lowTimeWarningThreshold;
    
    if (_isLowTime && !wasLowTime && _effectiveAnimationConfig.enablePulseAnimation) {
      _pulseController.repeat(reverse: true);
    } else if (!_isLowTime && wasLowTime) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  void _triggerVibration() {
    // Implementation for vibration feedback
    // This would require platform-specific code
  }

  void _playSound() {
    // Implementation for sound notifications
    // This would require audio plugin integration
  }

  void _pauseTimer() {
    if (!_isRunning || _isPaused) return;
    
    _timer.cancel();
    setState(() {
      _isPaused = true;
      _isRunning = false;
    });
    
    if (_effectiveAnimationConfig.enableScaleAnimation) {
      _scaleController.reverse();
    }
    
    widget.config.onPause?.call();
    if (widget.enableHapticFeedback) {
      HapticFeedback.forCountdownPause();
    }
  }

  void _resumeTimer() {
    if (!_isPaused) return;
    
    setState(() {
      _isPaused = false;
    });
    
    if (_effectiveAnimationConfig.enableScaleAnimation) {
      _scaleController.forward();
    }
    
    widget.config.onResume?.call();
    if (widget.enableHapticFeedback) {
      HapticFeedback.forCountdownResume();
    }
    _startTimer();
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _remaining = widget.config.duration;
      _isRunning = false;
      _isPaused = false;
      _isFinished = false;
      _isVisible = true;
      _isLowTime = false;
    });
    
    _pulseController.stop();
    _pulseController.reset();
    
    if (_effectiveAnimationConfig.enableScaleAnimation) {
      _scaleController.forward();
    }
    
    widget.config.onReset?.call();
    if (widget.enableHapticFeedback) {
      HapticFeedback.forCountdownReset();
    }
  }

  String _formatDuration(Duration duration) {
    if (widget.customFormatter != null) {
      return widget.customFormatter!(duration);
    }
    
    if (widget.showMilliseconds) {
      return TimeFormatter.formatWithMilliseconds(duration);
    }
    
    return TimeFormatter.formatSmart(duration);
  }

  CountdownTheme get _effectiveTheme {
    return widget.theme ?? CountdownTheme.light();
  }

  CountdownAnimationConfig get _effectiveAnimationConfig {
    return widget.animationConfig ?? 
           _effectiveTheme.animationConfig ?? 
           const CountdownAnimationConfig();
  }

  CountdownCustomBuilderConfig get _effectiveCustomBuilderConfig {
    return widget.customBuilderConfig ?? 
           _effectiveTheme.customBuilderConfig ?? 
           const CountdownCustomBuilderConfig();
  }

  CountdownAdvancedStyle get _effectiveAdvancedStyle {
    return widget.advancedStyle ?? 
           _effectiveTheme.advancedStyle ?? 
           const CountdownAdvancedStyle();
  }

  /// Get responsive font size for timer text
  double _getResponsiveFontSize(BuildContext context, {double? baseSize}) {
    if (!widget.useResponsiveSizing) {
      return baseSize ?? 16.0;
    }
    
    switch (widget.displayStyle) {
      case CountdownDisplayStyle.compact:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 16.0);
      case CountdownDisplayStyle.detailed:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 24.0);
      case CountdownDisplayStyle.circular:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 12.0);
      case CountdownDisplayStyle.minimal:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 18.0);
      case CountdownDisplayStyle.bottomBar:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 14.0);
      case CountdownDisplayStyle.card:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 28.0);
      case CountdownDisplayStyle.gradient:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 24.0);
      case CountdownDisplayStyle.digital:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 32.0);
      case CountdownDisplayStyle.analog:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 16.0);
      case CountdownDisplayStyle.progressBar:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 14.0);
      case CountdownDisplayStyle.floating:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 18.0);
      case CountdownDisplayStyle.notification:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 12.0);
      case CountdownDisplayStyle.custom:
        return ResponsiveUtils.getResponsiveFontSize(context, base: baseSize ?? 16.0);
    }
  }

  /// Get responsive font size for title text
  double _getResponsiveTitleFontSize(BuildContext context) {
    if (!widget.useResponsiveSizing) return 14.0;
    return ResponsiveUtils.getResponsiveFontSize(context, base: 14.0);
  }

  /// Get responsive font size for subtitle text
  double _getResponsiveSubtitleFontSize(BuildContext context) {
    if (!widget.useResponsiveSizing) return 12.0;
    return ResponsiveUtils.getResponsiveFontSize(context, base: 12.0);
  }

  /// Get responsive icon size
  double _getResponsiveIconSize(BuildContext context) {
    if (!widget.useResponsiveSizing) {
      switch (widget.displayStyle) {
        case CountdownDisplayStyle.compact:
        case CountdownDisplayStyle.bottomBar:
          return 20.0;
        case CountdownDisplayStyle.detailed:
          return 24.0;
        case CountdownDisplayStyle.card:
        case CountdownDisplayStyle.gradient:
          return 32.0;
        case CountdownDisplayStyle.digital:
          return 24.0;
        case CountdownDisplayStyle.analog:
          return 20.0;
        case CountdownDisplayStyle.progressBar:
          return 16.0;
        case CountdownDisplayStyle.floating:
          return 24.0;
        case CountdownDisplayStyle.notification:
          return 16.0;
        case CountdownDisplayStyle.custom:
          return 20.0;
        default:
          return 20.0;
      }
    }
    
    return ResponsiveUtils.getResponsiveIconSize(context);
  }

  /// Get responsive circular progress size
  double _getResponsiveCircularSize(BuildContext context) {
    if (!widget.useResponsiveSizing) return 80.0;
    return ResponsiveUtils.getResponsiveCircularSize(context);
  }

  /// Get responsive stroke width for circular progress
  double _getResponsiveStrokeWidth(BuildContext context) {
    if (!widget.useResponsiveSizing) {
      return widget.progressStrokeWidth ?? 6.0;
    }
    return widget.progressStrokeWidth ?? ResponsiveUtils.getResponsiveStrokeWidth(context);
  }

  /// Get responsive padding
  EdgeInsetsGeometry _getResponsivePadding(BuildContext context) {
    if (!widget.useResponsiveSizing) {
      return _effectiveTheme.padding ?? const EdgeInsets.all(12.0);
    }
    
    final basePadding = ResponsiveUtils.getResponsivePadding(context);
    return _effectiveTheme.padding ?? basePadding;
  }

  /// Get responsive border radius
  double _getResponsiveBorderRadius(BuildContext context) {
    if (!widget.useResponsiveSizing) {
      return _effectiveTheme.borderRadius;
    }
    return ResponsiveUtils.getResponsiveBorderRadius(context);
  }

  /// Get responsive spacing
  double _getResponsiveSpacing(BuildContext context) {
    if (!widget.useResponsiveSizing) return 8.0;
    
    final screenSize = ResponsiveUtils.getScreenSize(context);
    switch (screenSize) {
      case ScreenSize.xs:
        return 4.0;
      case ScreenSize.sm:
        return 6.0;
      case ScreenSize.md:
        return 8.0;
      case ScreenSize.lg:
        return 12.0;
      case ScreenSize.xl:
        return 16.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();
    
    if (widget.customBuilder != null) {
      return widget.customBuilder!(
        context,
        _remaining,
        _isRunning,
        _isPaused,
        _isRunning && !_isPaused ? _pauseTimer : _resumeTimer,
      );
    }

    Widget timerWidget = _buildTimerWidget();
    
    // Apply custom builders
    if (_effectiveCustomBuilderConfig.backgroundBuilder != null) {
      timerWidget = _effectiveCustomBuilderConfig.backgroundBuilder!(context, timerWidget);
    }
    
    if (_effectiveCustomBuilderConfig.containerBuilder != null) {
      timerWidget = _effectiveCustomBuilderConfig.containerBuilder!(context, timerWidget);
    }
    
    // Apply animations
    if (_effectiveAnimationConfig.enabled) {
      timerWidget = _buildAnimatedWidget(timerWidget);
    }
    
    // Apply advanced styling
    timerWidget = _applyAdvancedStyling(timerWidget);
    
    return timerWidget;
  }

  Widget _buildTimerWidget() {
    switch (widget.displayStyle) {
      case CountdownDisplayStyle.compact:
        return _buildCompactDisplay();
      case CountdownDisplayStyle.detailed:
        return _buildDetailedDisplay();
      case CountdownDisplayStyle.circular:
        return _buildCircularDisplay();
      case CountdownDisplayStyle.minimal:
        return _buildMinimalDisplay();
      case CountdownDisplayStyle.bottomBar:
        return _buildBottomBarDisplay();
      case CountdownDisplayStyle.card:
        return _buildCardDisplay();
      case CountdownDisplayStyle.gradient:
        return _buildGradientDisplay();
      case CountdownDisplayStyle.digital:
        return _buildDigitalDisplay();
      case CountdownDisplayStyle.analog:
        return _buildAnalogDisplay();
      case CountdownDisplayStyle.progressBar:
        return _buildProgressBarDisplay();
      case CountdownDisplayStyle.floating:
        return _buildFloatingDisplay();
      case CountdownDisplayStyle.notification:
        return _buildNotificationDisplay();
      case CountdownDisplayStyle.custom:
        return _buildCustomDisplay();
    }
  }

  Widget _buildAnimatedWidget(Widget child) {
    final animationConfig = _effectiveAnimationConfig;
    
    if (animationConfig.customAnimationBuilder != null) {
      return animationConfig.customAnimationBuilder!(child, _fadeAnimation);
    }
    
    Widget animatedChild = child;
    
    if (animationConfig.enableFadeAnimation) {
      animatedChild = FadeTransition(
        opacity: _fadeAnimation,
        child: animatedChild,
      );
    }
    
    if (animationConfig.enableScaleAnimation) {
      animatedChild = ScaleTransition(
        scale: _scaleAnimation,
        child: animatedChild,
      );
    }
    
    if (_isLowTime && animationConfig.enablePulseAnimation) {
      animatedChild = ScaleTransition(
        scale: _pulseAnimation,
        child: animatedChild,
      );
    }
    
    if (_isFinished && animationConfig.enableShakeAnimation) {
      animatedChild = AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          final shakeOffset = math.sin(_shakeAnimation.value * math.pi * 8) * 4;
          return Transform.translate(
            offset: Offset(shakeOffset, 0),
            child: animatedChild,
          );
        },
      );
    }
    
    return animatedChild;
  }

  Widget _applyAdvancedStyling(Widget child) {
    final advancedStyle = _effectiveAdvancedStyle;
    final theme = _effectiveTheme;
    
    Widget styledChild = child;
    
    // Apply custom decoration
    if (theme.decoration != null) {
      styledChild = DecoratedBox(
        decoration: theme.decoration!,
        child: styledChild,
      );
    }
    
    // Apply custom shape
    if (advancedStyle.shape != null) {
      styledChild = ClipPath(
        clipper: ShapeBorderClipper(shape: advancedStyle.shape!),
        child: styledChild,
      );
    }
    
    // Apply custom border
    if (advancedStyle.border != null) {
      styledChild = Container(
        decoration: BoxDecoration(border: advancedStyle.border),
        child: styledChild,
      );
    }
    
    // Apply custom constraints
    if (theme.width != null || theme.height != null || 
        theme.minWidth != null || theme.minHeight != null ||
        theme.maxWidth != null || theme.maxHeight != null) {
      styledChild = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: theme.minWidth ?? 0.0,
          minHeight: theme.minHeight ?? 0.0,
          maxWidth: theme.maxWidth ?? double.infinity,
          maxHeight: theme.maxHeight ?? double.infinity,
        ),
        child: SizedBox(
          width: theme.width,
          height: theme.height,
          child: styledChild,
        ),
      );
    }
    
    // Apply custom alignment
    if (advancedStyle.alignment != null) {
      styledChild = Align(
        alignment: advancedStyle.alignment!,
        child: styledChild,
      );
    }
    
    // Apply custom transform
    if (advancedStyle.transform != null) {
      styledChild = Transform(
        transform: advancedStyle.transform!,
        alignment: advancedStyle.transformAlignment,
        child: styledChild,
      );
    }
    
    // Apply foreground decoration
    if (theme.foregroundDecoration != null) {
      styledChild = DecoratedBox(
        decoration: theme.foregroundDecoration!,
        child: styledChild,
      );
    }
    
    // Apply semantic properties
    if (advancedStyle.semanticLabel != null) {
      styledChild = Semantics(
        label: advancedStyle.semanticLabel!,
        excludeSemantics: advancedStyle.excludeFromSemantics ?? false,
        child: styledChild,
      );
    }
    
    return styledChild;
  }

  Widget _buildCompactDisplay() {
    final spacing = _getResponsiveSpacing(context);
    
    return Container(
      padding: _getResponsivePadding(context),
      margin: _effectiveTheme.margin,
      decoration: BoxDecoration(
        color: _effectiveTheme.backgroundColor,
        borderRadius: BorderRadius.circular(_getResponsiveBorderRadius(context)),
        border: _effectiveTheme.borderColor != null
            ? Border.all(
                color: _effectiveTheme.borderColor!,
                width: _effectiveTheme.borderWidth,
              )
            : null,
        boxShadow: _effectiveTheme.boxShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.timer,
            color: _effectiveTheme.iconColor ?? _effectiveTheme.primaryColor,
            size: _getResponsiveIconSize(context),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Text(
              _formatDuration(_remaining),
              style: widget.textStyle ?? _effectiveTheme.textStyle ?? TextStyle(
                fontSize: _getResponsiveFontSize(context),
                fontWeight: FontWeight.bold,
                color: _effectiveTheme.textColor ?? _effectiveTheme.primaryColor,
              ),
            ),
          ),
          if (widget.config.showControls) ...[
            SizedBox(width: spacing),
            _buildControlButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailedDisplay() {
    final spacing = _getResponsiveSpacing(context);
    
    return Container(
      padding: _getResponsivePadding(context),
      margin: _effectiveTheme.margin,
      decoration: BoxDecoration(
        color: _effectiveTheme.backgroundColor,
        borderRadius: BorderRadius.circular(_getResponsiveBorderRadius(context)),
        border: _effectiveTheme.borderColor != null
            ? Border.all(
                color: _effectiveTheme.borderColor!,
                width: _effectiveTheme.borderWidth,
              )
            : null,
        boxShadow: _effectiveTheme.boxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer_outlined,
                color: _effectiveTheme.iconColor ?? _effectiveTheme.primaryColor,
                size: _getResponsiveIconSize(context),
              ),
              SizedBox(width: spacing),
              Text(
                widget.titleText ?? 'Time Remaining',
                style: widget.titleTextStyle ?? _effectiveTheme.titleTextStyle ?? TextStyle(
                  fontSize: _getResponsiveTitleFontSize(context),
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          Text(
            _formatDuration(_remaining),
            style: widget.textStyle ?? _effectiveTheme.textStyle ?? TextStyle(
              fontSize: _getResponsiveFontSize(context),
              fontWeight: FontWeight.bold,
              color: _effectiveTheme.textColor ?? _effectiveTheme.primaryColor,
            ),
          ),
          if (widget.subtitleText != null) ...[
            SizedBox(height: spacing / 2),
            Text(
              widget.subtitleText!,
              style: TextStyle(
                fontSize: _getResponsiveSubtitleFontSize(context),
                color: Colors.grey[500],
              ),
            ),
          ],
          if (widget.config.showControls) ...[
            SizedBox(height: spacing * 1.5),
            _buildControlButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildCircularDisplay() {
    final progress = _remaining.getProgress(widget.config.duration);
    final circularSize = _getResponsiveCircularSize(context);
    final spacing = _getResponsiveSpacing(context);
    
    return Container(
      padding: _getResponsivePadding(context),
      margin: _effectiveTheme.margin,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: circularSize,
            height: circularSize,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: _getResponsiveStrokeWidth(context),
              backgroundColor: widget.progressBackgroundColor ?? Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.progressValueColor ?? _effectiveTheme.primaryColor,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatDuration(_remaining),
                style: widget.textStyle ?? _effectiveTheme.textStyle ?? TextStyle(
                  fontSize: _getResponsiveFontSize(context),
                  fontWeight: FontWeight.bold,
                  color: _effectiveTheme.textColor ?? _effectiveTheme.primaryColor,
                ),
              ),
              if (widget.config.showControls) ...[
                SizedBox(height: spacing / 2),
                _buildControlButtons(),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalDisplay() {
    return Text(
      _formatDuration(_remaining),
      style: widget.textStyle ?? _effectiveTheme.textStyle ?? TextStyle(
        fontSize: _getResponsiveFontSize(context),
        fontWeight: FontWeight.w600,
        color: _effectiveTheme.textColor ?? _effectiveTheme.primaryColor,
      ),
    );
  }

  Widget _buildBottomBarDisplay() {
    final spacing = _getResponsiveSpacing(context);
    
    return Container(
      width: double.infinity,
      padding: _getResponsivePadding(context),
      margin: _effectiveTheme.margin,
      decoration: BoxDecoration(
        color: _effectiveTheme.backgroundColor ?? _effectiveTheme.primaryColor,
        boxShadow: _effectiveTheme.boxShadow ?? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer,
            color: _effectiveTheme.iconColor ?? Colors.white,
            size: _getResponsiveIconSize(context),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Text(
              '${widget.titleText ?? ''} ${_formatDuration(_remaining)}',
              style: widget.textStyle ?? _effectiveTheme.textStyle ?? TextStyle(
                fontSize: _getResponsiveFontSize(context),
                fontWeight: FontWeight.w500,
                color: _effectiveTheme.textColor ?? Colors.white,
              ),
            ),
          ),
          if (widget.config.showControls) _buildControlButtons(),
        ],
      ),
    );
  }

  Widget _buildCardDisplay() {
    final spacing = _getResponsiveSpacing(context);
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_getResponsiveBorderRadius(context)),
      ),
      child: Container(
        padding: _getResponsivePadding(context),
        margin: _effectiveTheme.margin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer_outlined,
              color: _effectiveTheme.iconColor ?? _effectiveTheme.primaryColor,
              size: _getResponsiveIconSize(context),
            ),
            SizedBox(height: spacing),
            Text(
              _formatDuration(_remaining),
              style: widget.textStyle ?? _effectiveTheme.textStyle ?? TextStyle(
                fontSize: _getResponsiveFontSize(context),
                fontWeight: FontWeight.bold,
                color: _effectiveTheme.textColor ?? _effectiveTheme.primaryColor,
              ),
            ),
            if (widget.subtitleText != null) ...[
              SizedBox(height: spacing / 2),
              Text(
                widget.subtitleText!,
                style: TextStyle(
                  fontSize: _getResponsiveSubtitleFontSize(context),
                  color: Colors.grey[600],
                ),
              ),
            ],
            if (widget.config.showControls) ...[
              SizedBox(height: spacing * 2),
              _buildControlButtons(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGradientDisplay() {
    final gradient = _effectiveTheme.gradient ?? LinearGradient(
      colors: [_effectiveTheme.primaryColor, _effectiveTheme.secondaryColor ?? _effectiveTheme.primaryColor],
    );
    final spacing = _getResponsiveSpacing(context);
    
    return Container(
      padding: _getResponsivePadding(context),
      margin: _effectiveTheme.margin,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(_getResponsiveBorderRadius(context)),
        boxShadow: _effectiveTheme.boxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer,
            color: _effectiveTheme.iconColor ?? Colors.white,
            size: _getResponsiveIconSize(context),
          ),
          SizedBox(height: spacing),
          Text(
            _formatDuration(_remaining),
            style: widget.textStyle ?? _effectiveTheme.textStyle ?? TextStyle(
              fontSize: _getResponsiveFontSize(context),
              fontWeight: FontWeight.bold,
              color: _effectiveTheme.textColor ?? Colors.white,
            ),
          ),
          if (widget.subtitleText != null) ...[
            SizedBox(height: spacing / 2),
            Text(
              widget.subtitleText!,
              style: TextStyle(
                fontSize: _getResponsiveSubtitleFontSize(context),
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
          if (widget.config.showControls) ...[
            SizedBox(height: spacing * 1.5),
            _buildControlButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildDigitalDisplay() {
    final spacing = _getResponsiveSpacing(context);
    final timeString = _formatDuration(_remaining);
    final segments = timeString.split(':');
    
    return Container(
      padding: _getResponsivePadding(context),
      margin: _effectiveTheme.margin,
      decoration: BoxDecoration(
        color: _effectiveTheme.backgroundColor ?? Colors.black,
        borderRadius: BorderRadius.circular(_getResponsiveBorderRadius(context)),
        boxShadow: _effectiveTheme.boxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: segments.asMap().entries.map((entry) {
              final index = entry.key;
              final segment = entry.value;
              
              return Row(
                children: [
                  _buildDigitalSegment(segment),
                  if (index < segments.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: spacing / 2),
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontSize: _getResponsiveFontSize(context, baseSize: 24.0),
                          fontWeight: FontWeight.bold,
                          color: _effectiveTheme.textColor ?? Colors.white,
                        ),
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
          if (widget.config.showControls) ...[
            SizedBox(height: spacing),
            _buildControlButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildDigitalSegment(String segment) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: _effectiveTheme.primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        segment,
        style: TextStyle(
          fontSize: _getResponsiveFontSize(context, baseSize: 20.0),
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _buildAnalogDisplay() {
    final spacing = _getResponsiveSpacing(context);
    final size = _getResponsiveCircularSize(context) * 1.5;
    final progress = _remaining.getProgress(widget.config.duration);
    final angle = 2 * math.pi * progress;
    
    return Container(
      padding: _getResponsivePadding(context),
      margin: _effectiveTheme.margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Clock face
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _effectiveTheme.backgroundColor ?? Colors.grey.shade100,
                    border: Border.all(
                      color: _effectiveTheme.borderColor ?? Colors.grey.shade300,
                      width: 2.0,
                    ),
                  ),
                ),
                // Progress arc
                CustomPaint(
                  size: Size(size, size),
                  painter: AnalogClockPainter(
                    progress: progress,
                    color: _effectiveTheme.primaryColor,
                    strokeWidth: _getResponsiveStrokeWidth(context),
                  ),
                ),
                // Clock hands
                Transform.rotate(
                  angle: angle,
                  child: Container(
                    width: 4.0,
                    height: size / 2 - 20,
                    decoration: BoxDecoration(
                      color: _effectiveTheme.primaryColor,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                // Center dot
                Container(
                  width: 12.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _effectiveTheme.primaryColor,
                  ),
                ),
                // Time text
                Text(
                  _formatDuration(_remaining),
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, baseSize: 14.0),
                    fontWeight: FontWeight.bold,
                    color: _effectiveTheme.textColor ?? _effectiveTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if (widget.config.showControls) ...[
            SizedBox(height: spacing),
            _buildControlButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBarDisplay() {
    final spacing = _getResponsiveSpacing(context);
    final progress = _remaining.getProgress(widget.config.duration);
    final progressColor = _isLowTime 
        ? (widget.warningColor ?? Colors.red)
        : (_effectiveTheme.progressValueColor ?? _effectiveTheme.primaryColor);
    
    return Container(
      padding: _getResponsivePadding(context),
      margin: _effectiveTheme.margin,
      decoration: BoxDecoration(
        color: _effectiveTheme.backgroundColor,
        borderRadius: BorderRadius.circular(_getResponsiveBorderRadius(context)),
        boxShadow: _effectiveTheme.boxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar
          Container(
            height: 8.0,
            decoration: BoxDecoration(
              color: _effectiveTheme.progressBackgroundColor ?? Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          SizedBox(height: spacing),
          // Time overlay
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(_remaining),
                style: TextStyle(
                  fontSize: _getResponsiveFontSize(context, baseSize: 16.0),
                  fontWeight: FontWeight.bold,
                  color: _effectiveTheme.textColor ?? _effectiveTheme.primaryColor,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: TextStyle(
                  fontSize: _getResponsiveFontSize(context, baseSize: 12.0),
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          if (widget.config.showControls) ...[
            SizedBox(height: spacing),
            _buildControlButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildFloatingDisplay() {
    final spacing = _getResponsiveSpacing(context);
    
    return Container(
      padding: _getResponsivePadding(context),
      margin: _effectiveTheme.margin,
      decoration: BoxDecoration(
        color: _effectiveTheme.backgroundColor ?? _effectiveTheme.primaryColor,
        shape: BoxShape.circle,
        boxShadow: _effectiveTheme.boxShadow ?? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer,
            color: _effectiveTheme.iconColor ?? Colors.white,
            size: _getResponsiveIconSize(context),
          ),
          SizedBox(height: spacing / 2),
          Text(
            _formatDuration(_remaining),
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, baseSize: 14.0),
              fontWeight: FontWeight.bold,
              color: _effectiveTheme.textColor ?? Colors.white,
            ),
          ),
          if (widget.config.showControls) ...[
            SizedBox(height: spacing / 2),
            _buildControlButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildNotificationDisplay() {
    final spacing = _getResponsiveSpacing(context);
    
    return Container(
      padding: _getResponsivePadding(context),
      margin: _effectiveTheme.margin,
      decoration: BoxDecoration(
        color: _effectiveTheme.backgroundColor ?? Colors.red,
        borderRadius: BorderRadius.circular(_getResponsiveBorderRadius(context)),
        boxShadow: _effectiveTheme.boxShadow ?? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _effectiveTheme.textColor ?? Colors.white,
            ),
          ),
          SizedBox(width: spacing),
          Text(
            _formatDuration(_remaining),
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, baseSize: 12.0),
              fontWeight: FontWeight.w500,
              color: _effectiveTheme.textColor ?? Colors.white,
            ),
          ),
          if (widget.config.showControls) ...[
            SizedBox(width: spacing),
            _buildControlButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomDisplay() {
    final customConfig = _effectiveCustomBuilderConfig;
    
    // Use custom time builder if provided
    if (customConfig.timeBuilder != null) {
      return customConfig.timeBuilder!(
        context,
        _remaining,
        _isRunning,
        _isPaused,
      );
    }
    
    // Fallback to minimal display
    return _buildMinimalDisplay();
  }

  Widget _buildControlButtons() {
    final iconSize = widget.useResponsiveSizing 
        ? ResponsiveUtils.getResponsiveIconSize(context, base: 16.0)
        : 16.0;
    final spacing = _getResponsiveSpacing(context);
    
    // Use custom controls builder if provided
    final customConfig = _effectiveCustomBuilderConfig;
    if (customConfig.controlsBuilder != null) {
      return customConfig.controlsBuilder!(
        context,
        _isRunning && !_isPaused ? _pauseTimer : null,
        _isPaused ? _resumeTimer : null,
        widget.config.showReset ? _resetTimer : null,
      );
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isRunning && !_isPaused)
          IconButton(
            onPressed: _pauseTimer,
            icon: Icon(Icons.pause, size: iconSize),
            color: _effectiveTheme.iconColor ?? _effectiveTheme.primaryColor,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          )
        else if (_isPaused)
          IconButton(
            onPressed: _resumeTimer,
            icon: Icon(Icons.play_arrow, size: iconSize),
            color: _effectiveTheme.iconColor ?? _effectiveTheme.primaryColor,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        if (widget.config.showReset) ...[
          SizedBox(width: spacing / 2),
          IconButton(
            onPressed: _resetTimer,
            icon: Icon(Icons.refresh, size: iconSize),
            color: _effectiveTheme.iconColor ?? _effectiveTheme.primaryColor,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ],
    );
  }
}

/// Custom painter for analog clock display
class AnalogClockPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  AnalogClockPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      -2 * math.pi * progress, // Negative for clockwise
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(AnalogClockPainter oldDelegate) {
    return oldDelegate.progress != progress ||
           oldDelegate.color != color ||
           oldDelegate.strokeWidth != strokeWidth;
  }
} 