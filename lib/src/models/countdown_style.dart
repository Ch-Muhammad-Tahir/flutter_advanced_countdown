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
    this.boxShadow,
    this.gradient,
    this.progressStrokeWidth = 6.0,
    this.progressBackgroundColor,
    this.progressValueColor,
    this.useResponsiveSizing = true,
    this.responsiveFontConfig,
    this.responsivePaddingConfig,
    this.responsiveIconConfig,
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
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    double? progressStrokeWidth,
    Color? progressBackgroundColor,
    Color? progressValueColor,
    bool? useResponsiveSizing,
    ResponsiveFontConfig? responsiveFontConfig,
    ResponsivePaddingConfig? responsivePaddingConfig,
    ResponsiveIconConfig? responsiveIconConfig,
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
      boxShadow: boxShadow ?? this.boxShadow,
      gradient: gradient ?? this.gradient,
      progressStrokeWidth: progressStrokeWidth ?? this.progressStrokeWidth,
      progressBackgroundColor: progressBackgroundColor ?? this.progressBackgroundColor,
      progressValueColor: progressValueColor ?? this.progressValueColor,
      useResponsiveSizing: useResponsiveSizing ?? this.useResponsiveSizing,
      responsiveFontConfig: responsiveFontConfig ?? this.responsiveFontConfig,
      responsivePaddingConfig: responsivePaddingConfig ?? this.responsivePaddingConfig,
      responsiveIconConfig: responsiveIconConfig ?? this.responsiveIconConfig,
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
    required Gradient gradient,
    Color primaryColor = Colors.white,
  }) {
    return CountdownTheme(
      primaryColor: primaryColor,
      gradient: gradient,
      textColor: primaryColor,
      iconColor: primaryColor,
      borderColor: Colors.transparent,
    );
  }

  /// Creates a responsive theme optimized for different screen sizes
  factory CountdownTheme.responsive({
    Color primaryColor = Colors.blue,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    ResponsiveFontConfig? fontConfig,
    ResponsivePaddingConfig? paddingConfig,
    ResponsiveIconConfig? iconConfig,
  }) {
    return CountdownTheme(
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      useResponsiveSizing: true,
      responsiveFontConfig: fontConfig,
      responsivePaddingConfig: paddingConfig,
      responsiveIconConfig: iconConfig,
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

/// Configuration for responsive font sizes
class ResponsiveFontConfig {
  final double? xs;
  final double? sm;
  final double? md;
  final double? lg;
  final double? xl;
  final double? base;

  const ResponsiveFontConfig({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.base,
  });
}

/// Configuration for responsive padding
class ResponsivePaddingConfig {
  final EdgeInsets? xs;
  final EdgeInsets? sm;
  final EdgeInsets? md;
  final EdgeInsets? lg;
  final EdgeInsets? xl;
  final EdgeInsets? base;

  const ResponsivePaddingConfig({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.base,
  });
}

/// Configuration for responsive icon sizes
class ResponsiveIconConfig {
  final double? xs;
  final double? sm;
  final double? md;
  final double? lg;
  final double? xl;
  final double? base;

  const ResponsiveIconConfig({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.base,
  });
} 