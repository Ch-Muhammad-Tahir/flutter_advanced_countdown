import 'package:flutter/material.dart';

/// Display styles for the countdown timer
enum CountdownDisplayStyle {
  /// Compact display with icon and time
  compact,
  
  /// Detailed display with title and larger time
  detailed,
  
  /// Circular progress indicator with time in center
  circular,
  
  /// Minimal display - just the time
  minimal,
  
  /// Bottom bar style for navigation bars
  bottomBar,
  
  /// Card style with elevation and rounded corners
  card,
  
  /// Gradient style with background gradient
  gradient,
  
  /// Digital display with segmented digits
  digital,
  
  /// Analog clock style display
  analog,
  
  /// Progress bar style with time overlay
  progressBar,
  
  /// Floating action button style
  floating,
  
  /// Notification badge style
  notification,
  
  /// Custom style using custom builder
  custom,
}

/// Animation configuration for countdown timer
class CountdownAnimationConfig {
  /// Whether to enable animations
  final bool enabled;
  
  /// Animation duration for transitions
  final Duration duration;
  
  /// Animation curve for transitions
  final Curve curve;
  
  /// Whether to enable pulse animation when time is low
  final bool enablePulseAnimation;
  
  /// Pulse animation threshold (seconds remaining)
  final int pulseThreshold;
  
  /// Whether to enable shake animation when timer finishes
  final bool enableShakeAnimation;
  
  /// Whether to enable scale animation on state changes
  final bool enableScaleAnimation;
  
  /// Whether to enable fade animation on state changes
  final bool enableFadeAnimation;
  
  /// Custom animation builder
  final Widget Function(Widget child, Animation<double> animation)? customAnimationBuilder;

  const CountdownAnimationConfig({
    this.enabled = true,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.enablePulseAnimation = true,
    this.pulseThreshold = 10,
    this.enableShakeAnimation = true,
    this.enableScaleAnimation = true,
    this.enableFadeAnimation = true,
    this.customAnimationBuilder,
  });

  CountdownAnimationConfig copyWith({
    bool? enabled,
    Duration? duration,
    Curve? curve,
    bool? enablePulseAnimation,
    int? pulseThreshold,
    bool? enableShakeAnimation,
    bool? enableScaleAnimation,
    bool? enableFadeAnimation,
    Widget Function(Widget child, Animation<double> animation)? customAnimationBuilder,
  }) {
    return CountdownAnimationConfig(
      enabled: enabled ?? this.enabled,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      enablePulseAnimation: enablePulseAnimation ?? this.enablePulseAnimation,
      pulseThreshold: pulseThreshold ?? this.pulseThreshold,
      enableShakeAnimation: enableShakeAnimation ?? this.enableShakeAnimation,
      enableScaleAnimation: enableScaleAnimation ?? this.enableScaleAnimation,
      enableFadeAnimation: enableFadeAnimation ?? this.enableFadeAnimation,
      customAnimationBuilder: customAnimationBuilder ?? this.customAnimationBuilder,
    );
  }
}

/// Custom builder configuration for complete customization
class CountdownCustomBuilderConfig {
  /// Custom time display builder
  final Widget Function(BuildContext context, Duration remaining, bool isRunning, bool isPaused)? timeBuilder;
  
  /// Custom control buttons builder
  final Widget Function(BuildContext context, VoidCallback? onPause, VoidCallback? onResume, VoidCallback? onReset)? controlsBuilder;
  
  /// Custom progress indicator builder
  final Widget Function(BuildContext context, double progress, Duration remaining, Duration total)? progressBuilder;
  
  /// Custom background builder
  final Widget Function(BuildContext context, Widget child)? backgroundBuilder;
  
  /// Custom container builder
  final Widget Function(BuildContext context, Widget child)? containerBuilder;
  
  /// Custom icon builder
  final Widget Function(BuildContext context, IconData icon, Color? color, double? size)? iconBuilder;

  const CountdownCustomBuilderConfig({
    this.timeBuilder,
    this.controlsBuilder,
    this.progressBuilder,
    this.backgroundBuilder,
    this.containerBuilder,
    this.iconBuilder,
  });

  CountdownCustomBuilderConfig copyWith({
    Widget Function(BuildContext context, Duration remaining, bool isRunning, bool isPaused)? timeBuilder,
    Widget Function(BuildContext context, VoidCallback? onPause, VoidCallback? onResume, VoidCallback? onReset)? controlsBuilder,
    Widget Function(BuildContext context, double progress, Duration remaining, Duration total)? progressBuilder,
    Widget Function(BuildContext context, Widget child)? backgroundBuilder,
    Widget Function(BuildContext context, Widget child)? containerBuilder,
    Widget Function(BuildContext context, IconData icon, Color? color, double? size)? iconBuilder,
  }) {
    return CountdownCustomBuilderConfig(
      timeBuilder: timeBuilder ?? this.timeBuilder,
      controlsBuilder: controlsBuilder ?? this.controlsBuilder,
      progressBuilder: progressBuilder ?? this.progressBuilder,
      backgroundBuilder: backgroundBuilder ?? this.backgroundBuilder,
      containerBuilder: containerBuilder ?? this.containerBuilder,
      iconBuilder: iconBuilder ?? this.iconBuilder,
    );
  }
}

/// Advanced styling configuration
class CountdownAdvancedStyle {
  /// Custom border configuration
  final Border? border;
  
  /// Custom shape configuration
  final OutlinedBorder? shape;
  
  /// Custom clip behavior
  final Clip clipBehavior;
  
  /// Custom alignment
  final AlignmentGeometry? alignment;
  
  /// Custom constraints
  final BoxConstraints? constraints;
  
  /// Custom transform
  final Matrix4? transform;
  
  /// Custom transform alignment
  final AlignmentGeometry? transformAlignment;
  
  /// Custom hit test behavior
  final HitTestBehavior? hitTestBehavior;
  
  /// Custom semantic label
  final String? semanticLabel;
  
  /// Custom exclude from semantics
  final bool? excludeFromSemantics;

  const CountdownAdvancedStyle({
    this.border,
    this.shape,
    this.clipBehavior = Clip.none,
    this.alignment,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.hitTestBehavior,
    this.semanticLabel,
    this.excludeFromSemantics,
  });

  CountdownAdvancedStyle copyWith({
    Border? border,
    OutlinedBorder? shape,
    Clip? clipBehavior,
    AlignmentGeometry? alignment,
    BoxConstraints? constraints,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    HitTestBehavior? hitTestBehavior,
    String? semanticLabel,
    bool? excludeFromSemantics,
  }) {
    return CountdownAdvancedStyle(
      border: border ?? this.border,
      shape: shape ?? this.shape,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      alignment: alignment ?? this.alignment,
      constraints: constraints ?? this.constraints,
      transform: transform ?? this.transform,
      transformAlignment: transformAlignment ?? this.transformAlignment,
      hitTestBehavior: hitTestBehavior ?? this.hitTestBehavior,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      excludeFromSemantics: excludeFromSemantics ?? this.excludeFromSemantics,
    );
  }
}

/// Theme configuration for countdown timer appearance
class CountdownTheme {
  /// Primary color for the timer
  final Color primaryColor;
  
  /// Secondary color for the timer
  final Color? secondaryColor;
  
  /// Background color for the timer container
  final Color? backgroundColor;
  
  /// Text color for the timer
  final Color? textColor;
  
  /// Icon color for the timer
  final Color? iconColor;
  
  /// Border color for the timer
  final Color? borderColor;
  
  /// Border radius for the timer container
  final double borderRadius;
  
  /// Border width for the timer
  final double borderWidth;
  
  /// Padding for the timer container
  final EdgeInsetsGeometry? padding;
  
  /// Margin for the timer container
  final EdgeInsetsGeometry? margin;
  
  /// Custom text style for the timer
  final TextStyle? textStyle;
  
  /// Custom text style for the title (in detailed mode)
  final TextStyle? titleTextStyle;
  
  /// Custom text style for the subtitle
  final TextStyle? subtitleTextStyle;
  
  /// Box shadow for the timer container
  final List<BoxShadow>? boxShadow;
  
  /// Gradient for gradient style
  final Gradient? gradient;
  
  /// Progress indicator stroke width (for circular style)
  final double progressStrokeWidth;
  
  /// Progress indicator background color (for circular style)
  final Color? progressBackgroundColor;
  
  /// Progress indicator value color (for circular style)
  final Color? progressValueColor;

  /// Whether to use responsive sizing (default: true)
  final bool useResponsiveSizing;

  /// Responsive font size configuration
  final ResponsiveFontConfig? responsiveFontConfig;

  /// Responsive padding configuration
  final ResponsivePaddingConfig? responsivePaddingConfig;

  /// Responsive icon size configuration
  final ResponsiveIconConfig? responsiveIconConfig;

  /// Animation configuration
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

  const CountdownTheme({
    this.primaryColor = Colors.blue,
    this.secondaryColor,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.padding,
    this.margin,
    this.textStyle,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.boxShadow,
    this.gradient,
    this.progressStrokeWidth = 6.0,
    this.progressBackgroundColor,
    this.progressValueColor,
    this.useResponsiveSizing = true,
    this.responsiveFontConfig,
    this.responsivePaddingConfig,
    this.responsiveIconConfig,
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
  });

  /// Creates a copy of this theme with the given fields replaced
  CountdownTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    Color? borderColor,
    double? borderRadius,
    double? borderWidth,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    TextStyle? textStyle,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    double? progressStrokeWidth,
    Color? progressBackgroundColor,
    Color? progressValueColor,
    bool? useResponsiveSizing,
    ResponsiveFontConfig? responsiveFontConfig,
    ResponsivePaddingConfig? responsivePaddingConfig,
    ResponsiveIconConfig? responsiveIconConfig,
    CountdownAnimationConfig? animationConfig,
    CountdownCustomBuilderConfig? customBuilderConfig,
    CountdownAdvancedStyle? advancedStyle,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    double? minWidth,
    double? minHeight,
    double? maxWidth,
    double? maxHeight,
  }) {
    return CountdownTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      textStyle: textStyle ?? this.textStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      boxShadow: boxShadow ?? this.boxShadow,
      gradient: gradient ?? this.gradient,
      progressStrokeWidth: progressStrokeWidth ?? this.progressStrokeWidth,
      progressBackgroundColor: progressBackgroundColor ?? this.progressBackgroundColor,
      progressValueColor: progressValueColor ?? this.progressValueColor,
      useResponsiveSizing: useResponsiveSizing ?? this.useResponsiveSizing,
      responsiveFontConfig: responsiveFontConfig ?? this.responsiveFontConfig,
      responsivePaddingConfig: responsivePaddingConfig ?? this.responsivePaddingConfig,
      responsiveIconConfig: responsiveIconConfig ?? this.responsiveIconConfig,
      animationConfig: animationConfig ?? this.animationConfig,
      customBuilderConfig: customBuilderConfig ?? this.customBuilderConfig,
      advancedStyle: advancedStyle ?? this.advancedStyle,
      decoration: decoration ?? this.decoration,
      foregroundDecoration: foregroundDecoration ?? this.foregroundDecoration,
      width: width ?? this.width,
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      minHeight: minHeight ?? this.minHeight,
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
    );
  }

  /// Creates a theme from Material Design colors
  factory CountdownTheme.fromColors({
    required Color primary,
    Color? secondary,
    Color? background,
    Color? text,
    Color? icon,
    Color? border,
  }) {
    return CountdownTheme(
      primaryColor: primary,
      secondaryColor: secondary,
      backgroundColor: background,
      textColor: text,
      iconColor: icon,
      borderColor: border,
    );
  }

  /// Creates a theme with light mode colors
  factory CountdownTheme.light({
    Color primaryColor = Colors.blue,
  }) {
    return CountdownTheme(
      primaryColor: primaryColor,
      backgroundColor: Colors.white,
      textColor: Colors.black87,
      iconColor: primaryColor,
      borderColor: Colors.grey.shade300,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// Creates a theme with dark mode colors
  factory CountdownTheme.dark({
    Color primaryColor = Colors.blue,
  }) {
    return CountdownTheme(
      primaryColor: primaryColor,
      backgroundColor: Colors.grey.shade900,
      textColor: Colors.white,
      iconColor: primaryColor,
      borderColor: Colors.grey.shade700,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// Creates a theme with gradient background
  factory CountdownTheme.gradient({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    Color? textColor,
    Color? iconColor,
  }) {
    return CountdownTheme(
      gradient: LinearGradient(
        colors: colors,
        begin: begin,
        end: end,
      ),
      textColor: textColor ?? Colors.white,
      iconColor: iconColor ?? Colors.white,
    );
  }

  /// Creates a responsive theme with custom configurations
  factory CountdownTheme.responsive({
    Color primaryColor = Colors.blue,
    Color? backgroundColor,
    Color? textColor,
    ResponsiveFontConfig? fontConfig,
    ResponsivePaddingConfig? paddingConfig,
    ResponsiveIconConfig? iconConfig,
    CountdownAnimationConfig? animationConfig,
  }) {
    return CountdownTheme(
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      useResponsiveSizing: true,
      responsiveFontConfig: fontConfig,
      responsivePaddingConfig: paddingConfig,
      responsiveIconConfig: iconConfig,
      animationConfig: animationConfig,
    );
  }

  /// Creates a professional theme with advanced styling
  factory CountdownTheme.professional({
    Color primaryColor = Colors.blue,
    bool enableAnimations = true,
    bool enableShadows = true,
    bool enableRoundedCorners = true,
  }) {
    return CountdownTheme(
      primaryColor: primaryColor,
      backgroundColor: Colors.white,
      textColor: Colors.black87,
      iconColor: primaryColor,
      borderRadius: enableRoundedCorners ? 12.0 : 0.0,
      boxShadow: enableShadows ? [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ] : null,
      animationConfig: CountdownAnimationConfig(
        enabled: enableAnimations,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        enablePulseAnimation: true,
        enableShakeAnimation: true,
        enableScaleAnimation: true,
        enableFadeAnimation: true,
      ),
    );
  }

  /// Creates a minimal theme with clean design
  factory CountdownTheme.minimal({
    Color primaryColor = Colors.blue,
    bool enableBorders = false,
  }) {
    return CountdownTheme(
      primaryColor: primaryColor,
      backgroundColor: Colors.transparent,
      textColor: primaryColor,
      iconColor: primaryColor,
      borderRadius: 0.0,
      borderWidth: enableBorders ? 1.0 : 0.0,
      borderColor: enableBorders ? primaryColor.withValues(alpha: 0.3) : null,
      boxShadow: null,
      animationConfig: const CountdownAnimationConfig(
        enabled: false,
      ),
    );
  }

  /// Creates a glass morphism theme
  factory CountdownTheme.glassMorphism({
    Color primaryColor = Colors.blue,
    double blurRadius = 10.0,
  }) {
    return CountdownTheme(
      primaryColor: primaryColor,
      backgroundColor: Colors.white.withValues(alpha: 0.1),
      textColor: Colors.white,
      iconColor: Colors.white,
      borderRadius: 16.0,
      borderWidth: 1.0,
      borderColor: Colors.white.withValues(alpha: 0.2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: blurRadius,
          offset: const Offset(0, 4),
        ),
      ],
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountdownTheme &&
        other.primaryColor == primaryColor &&
        other.secondaryColor == secondaryColor &&
        other.backgroundColor == backgroundColor &&
        other.textColor == textColor &&
        other.iconColor == iconColor &&
        other.borderColor == borderColor &&
        other.borderRadius == borderRadius &&
        other.borderWidth == borderWidth &&
        other.useResponsiveSizing == useResponsiveSizing;
  }

  @override
  int get hashCode {
    return Object.hash(
      primaryColor,
      secondaryColor,
      backgroundColor,
      textColor,
      iconColor,
      borderColor,
      borderRadius,
      borderWidth,
      useResponsiveSizing,
    );
  }

  @override
  String toString() {
    return 'CountdownTheme(primaryColor: $primaryColor, secondaryColor: $secondaryColor, backgroundColor: $backgroundColor, textColor: $textColor, iconColor: $iconColor, borderColor: $borderColor, borderRadius: $borderRadius, borderWidth: $borderWidth, useResponsiveSizing: $useResponsiveSizing)';
  }
}

/// Responsive font configuration
class ResponsiveFontConfig {
  final double? xs;
  final double? sm;
  final double? md;
  final double? lg;
  final double? xl;

  const ResponsiveFontConfig({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });
}

/// Responsive padding configuration
class ResponsivePaddingConfig {
  final EdgeInsets? xs;
  final EdgeInsets? sm;
  final EdgeInsets? md;
  final EdgeInsets? lg;
  final EdgeInsets? xl;

  const ResponsivePaddingConfig({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });
}

/// Responsive icon configuration
class ResponsiveIconConfig {
  final double? xs;
  final double? sm;
  final double? md;
  final double? lg;
  final double? xl;

  const ResponsiveIconConfig({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });
} 