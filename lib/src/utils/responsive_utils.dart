import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math' as math;

/// Device type enumeration
enum DeviceType {
  /// Mobile phone (iPhone, Android phone)
  phone,

  /// Tablet (iPad, Android tablet)
  tablet,

  /// Desktop (Windows, macOS, Linux)
  desktop,
}

/// Screen size breakpoints
enum ScreenSize {
  /// Extra small screens (phones in portrait)
  xs,

  /// Small screens (phones in landscape)
  sm,

  /// Medium screens (tablets in portrait)
  md,

  /// Large screens (tablets in landscape, small desktops)
  lg,

  /// Extra large screens (large desktops)
  xl,
}

/// Responsive utilities for the countdown timer package
class ResponsiveUtils {
  static DeviceType? _deviceType;
  static ScreenSize? _screenSize;
  static Size? _screenSizeData;

  /// Get the current device type
  static DeviceType getDeviceType(BuildContext context) {
    if (_deviceType != null) return _deviceType!;

    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final pixelRatio = mediaQuery.devicePixelRatio;

    // Update cached values
    _screenSizeData = size;

    // Determine device type based on screen size and pixel ratio
    if (Platform.isAndroid || Platform.isIOS) {
      // Mobile device detection
      if (_isTablet(size, pixelRatio)) {
        _deviceType = DeviceType.tablet;
      } else {
        _deviceType = DeviceType.phone;
      }
    } else {
      // Desktop detection
      _deviceType = DeviceType.desktop;
    }

    return _deviceType!;
  }

  /// Get the current screen size category
  static ScreenSize getScreenSize(BuildContext context) {
    if (_screenSize != null && _screenSizeData == MediaQuery.of(context).size) {
      return _screenSize!;
    }

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isPortrait = height > width;

    // Update cached values
    _screenSizeData = size;

    // Determine screen size based on width and orientation
    if (isPortrait) {
      if (width < 480) {
        _screenSize = ScreenSize.xs;
      } else if (width < 768) {
        _screenSize = ScreenSize.sm;
      } else if (width < 1024) {
        _screenSize = ScreenSize.md;
      } else if (width < 1440) {
        _screenSize = ScreenSize.lg;
      } else {
        _screenSize = ScreenSize.xl;
      }
    } else {
      // Landscape orientation
      if (width < 768) {
        _screenSize = ScreenSize.xs;
      } else if (width < 1024) {
        _screenSize = ScreenSize.sm;
      } else if (width < 1440) {
        _screenSize = ScreenSize.md;
      } else if (width < 1920) {
        _screenSize = ScreenSize.lg;
      } else {
        _screenSize = ScreenSize.xl;
      }
    }

    return _screenSize!;
  }

  /// Check if the device is a tablet
  static bool _isTablet(Size size, double pixelRatio) {
    // iOS tablet detection
    if (Platform.isIOS) {
      return (size.width >= 768 && size.height >= 1024) ||
          (size.width >= 1024 && size.height >= 768);
    }

    // Android tablet detection
    if (Platform.isAndroid) {
      // Use diagonal size calculation
      final diagonalInches = _calculateDiagonalInches(size, pixelRatio);
      return diagonalInches >= 7.0;
    }

    return false;
  }

  /// Calculate diagonal screen size in inches
  static double _calculateDiagonalInches(Size size, double pixelRatio) {
    final widthInches = size.width / (pixelRatio * _getPPI());
    final heightInches = size.height / (pixelRatio * _getPPI());
    return math.sqrt(widthInches * widthInches + heightInches * heightInches);
  }

  /// Get pixels per inch for the platform
  static int _getPPI() {
    if (Platform.isAndroid) return 160;
    if (Platform.isIOS) return 150;
    return 96; // Default for desktop
  }

  /// Get responsive font size based on screen size
  static double getResponsiveFontSize(
    BuildContext context, {
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? base,
  }) {
    final screenSize = getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.xs:
        return xs ?? base ?? 14.0;
      case ScreenSize.sm:
        return sm ?? xs ?? base ?? 16.0;
      case ScreenSize.md:
        return md ?? sm ?? xs ?? base ?? 18.0;
      case ScreenSize.lg:
        return lg ?? md ?? sm ?? xs ?? base ?? 20.0;
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? base ?? 22.0;
    }
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    EdgeInsets? xs,
    EdgeInsets? sm,
    EdgeInsets? md,
    EdgeInsets? lg,
    EdgeInsets? xl,
    EdgeInsets? base,
  }) {
    final screenSize = getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.xs:
        return xs ?? base ?? const EdgeInsets.all(8.0);
      case ScreenSize.sm:
        return sm ?? xs ?? base ?? const EdgeInsets.all(12.0);
      case ScreenSize.md:
        return md ?? sm ?? xs ?? base ?? const EdgeInsets.all(16.0);
      case ScreenSize.lg:
        return lg ?? md ?? sm ?? xs ?? base ?? const EdgeInsets.all(20.0);
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? base ?? const EdgeInsets.all(24.0);
    }
  }

  /// Get responsive icon size based on screen size
  static double getResponsiveIconSize(
    BuildContext context, {
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? base,
  }) {
    final screenSize = getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.xs:
        return xs ?? base ?? 16.0;
      case ScreenSize.sm:
        return sm ?? xs ?? base ?? 18.0;
      case ScreenSize.md:
        return md ?? sm ?? xs ?? base ?? 20.0;
      case ScreenSize.lg:
        return lg ?? md ?? sm ?? xs ?? base ?? 24.0;
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? base ?? 28.0;
    }
  }

  /// Get responsive circular progress size based on screen size
  static double getResponsiveCircularSize(
    BuildContext context, {
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? base,
  }) {
    final screenSize = getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.xs:
        return xs ?? base ?? 60.0;
      case ScreenSize.sm:
        return sm ?? xs ?? base ?? 70.0;
      case ScreenSize.md:
        return md ?? sm ?? xs ?? base ?? 80.0;
      case ScreenSize.lg:
        return lg ?? md ?? sm ?? xs ?? base ?? 100.0;
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? base ?? 120.0;
    }
  }

  /// Get responsive stroke width for circular progress
  static double getResponsiveStrokeWidth(
    BuildContext context, {
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? base,
  }) {
    final screenSize = getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.xs:
        return xs ?? base ?? 4.0;
      case ScreenSize.sm:
        return sm ?? xs ?? base ?? 5.0;
      case ScreenSize.md:
        return md ?? sm ?? xs ?? base ?? 6.0;
      case ScreenSize.lg:
        return lg ?? md ?? sm ?? xs ?? base ?? 8.0;
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? base ?? 10.0;
    }
  }

  /// Get responsive border radius based on screen size
  static double getResponsiveBorderRadius(
    BuildContext context, {
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? base,
  }) {
    final screenSize = getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.xs:
        return xs ?? base ?? 6.0;
      case ScreenSize.sm:
        return sm ?? xs ?? base ?? 8.0;
      case ScreenSize.md:
        return md ?? sm ?? xs ?? base ?? 10.0;
      case ScreenSize.lg:
        return lg ?? md ?? sm ?? xs ?? base ?? 12.0;
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? base ?? 16.0;
    }
  }

  /// Check if the device is in landscape orientation
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if the device is in portrait orientation
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get the screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get the screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get the screen size
  static Size getScreenDimensions(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Clear cached values (useful for testing or when screen changes)
  static void clearCache() {
    _deviceType = null;
    _screenSize = null;
    _screenSizeData = null;
  }
}
