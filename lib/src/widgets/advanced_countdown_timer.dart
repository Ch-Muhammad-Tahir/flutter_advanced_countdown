import 'dart:async';
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
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _remaining = widget.config.duration;
    _setupAnimations();
    
    if (widget.config.autoStart) {
      _startTimer();
    }
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
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
          widget.config.onFinish?.call();
          if (widget.enableHapticFeedback) {
            HapticFeedback.forCountdownComplete();
          }
        } else {
          _remaining = _remaining - widget.config.interval;
          widget.config.onTick?.call(_remaining);
        }
      });
    });
  }

  void _pauseTimer() {
    if (!_isRunning || _isPaused) return;
    
    _timer.cancel();
    setState(() {
      _isPaused = true;
      _isRunning = false;  // Add this line to fix the resume issue
    });
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
    });
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
    if (widget.customBuilder != null) {
      return widget.customBuilder!(
        context,
        _remaining,
        _isRunning,
        _isPaused,
        _isPaused ? _resumeTimer : _pauseTimer,
      );
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: _buildTimerWidget(),
          ),
        );
      },
    );
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
    }
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
              'Auto-close in ${_formatDuration(_remaining)}',
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

  Widget _buildControlButtons() {
    final iconSize = widget.useResponsiveSizing 
        ? ResponsiveUtils.getResponsiveIconSize(context, base: 16.0)
        : 16.0;
    final spacing = _getResponsiveSpacing(context);
    
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