import '../utils/time_formatter.dart';

/// Extension methods for Duration class
extension DurationExtensions on Duration {
  /// Get formatted string representation as HH:MM:SS
  String get formattedHHMMSS => TimeFormatter.formatHHMMSS(this);

  /// Get formatted string representation as MM:SS
  String get formattedMMSS => TimeFormatter.formatMMSS(this);

  /// Get formatted string representation as SS
  String get formattedSS => TimeFormatter.formatSS(this);

  /// Get formatted string representation with milliseconds
  String get formattedWithMilliseconds => TimeFormatter.formatWithMilliseconds(this);

  /// Get formatted string representation with full milliseconds
  String get formattedWithFullMilliseconds => TimeFormatter.formatWithFullMilliseconds(this);

  /// Get formatted string representation with words
  String get formattedWords => TimeFormatter.formatWords(this);

  /// Get formatted string representation with short words
  String get formattedShortWords => TimeFormatter.formatShortWords(this);

  /// Get smart formatted string representation
  String get formattedSmart => TimeFormatter.formatSmart(this);

  /// Get countdown formatted string representation
  String get formattedCountdown => TimeFormatter.formatCountdown(this);

  /// Check if duration is zero
  bool get isZero => inMilliseconds == 0;

  /// Check if duration is positive
  bool get isPositive => inMilliseconds > 0;

  /// Check if duration is negative
  bool get isNegative => inMilliseconds < 0;

  /// Get duration in hours as double
  double get inHoursAsDouble => inMilliseconds / (1000 * 60 * 60);

  /// Get duration in minutes as double
  double get inMinutesAsDouble => inMilliseconds / (1000 * 60);

  /// Get duration in seconds as double
  double get inSecondsAsDouble => inMilliseconds / 1000;

  /// Get remaining hours
  int get remainingHours => inHours;

  /// Get remaining minutes (excluding hours)
  int get remainingMinutes => inMinutes % 60;

  /// Get remaining seconds (excluding minutes)
  int get remainingSeconds => inSeconds % 60;

  /// Get remaining milliseconds (excluding seconds)
  int get remainingMilliseconds => inMilliseconds % 1000;

  /// Get progress value (0.0 to 1.0) based on total duration
  double getProgress(Duration totalDuration) {
    if (totalDuration.isZero) return 1.0;
    return 1.0 - (inMilliseconds / totalDuration.inMilliseconds);
  }

  /// Add another duration
  Duration operator +(Duration other) => Duration(milliseconds: inMilliseconds + other.inMilliseconds);

  /// Subtract another duration
  Duration operator -(Duration other) => Duration(milliseconds: inMilliseconds - other.inMilliseconds);

  /// Multiply duration by a factor
  Duration operator *(double factor) => Duration(milliseconds: (inMilliseconds * factor).round());

  /// Divide duration by a factor
  Duration operator /(double factor) => Duration(milliseconds: (inMilliseconds / factor).round());

  /// Check if duration is greater than another
  bool operator >(Duration other) => inMilliseconds > other.inMilliseconds;

  /// Check if duration is less than another
  bool operator <(Duration other) => inMilliseconds < other.inMilliseconds;

  /// Check if duration is greater than or equal to another
  bool operator >=(Duration other) => inMilliseconds >= other.inMilliseconds;

  /// Check if duration is less than or equal to another
  bool operator <=(Duration other) => inMilliseconds <= other.inMilliseconds;

  /// Get the minimum of two durations
  Duration min(Duration other) => this < other ? this : other;

  /// Get the maximum of two durations
  Duration max(Duration other) => this > other ? this : other;

  /// Clamp duration between min and max values
  Duration clamp(Duration min, Duration max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Get duration as a human-readable string
  String get humanReadable {
    if (isZero) return '0 seconds';
    
    final parts = <String>[];
    
    if (inDays > 0) {
      parts.add('${inDays} ${inDays == 1 ? 'day' : 'days'}');
    }
    
    if (remainingHours > 0) {
      parts.add('$remainingHours ${remainingHours == 1 ? 'hour' : 'hours'}');
    }
    
    if (remainingMinutes > 0) {
      parts.add('$remainingMinutes ${remainingMinutes == 1 ? 'minute' : 'minutes'}');
    }
    
    if (remainingSeconds > 0 || parts.isEmpty) {
      parts.add('$remainingSeconds ${remainingSeconds == 1 ? 'second' : 'seconds'}');
    }
    
    return parts.join(' ');
  }

  /// Get duration as a short human-readable string
  String get humanReadableShort {
    if (isZero) return '0s';
    
    final parts = <String>[];
    
    if (inDays > 0) {
      parts.add('${inDays}d');
    }
    
    if (remainingHours > 0) {
      parts.add('${remainingHours}h');
    }
    
    if (remainingMinutes > 0) {
      parts.add('${remainingMinutes}m');
    }
    
    if (remainingSeconds > 0 || parts.isEmpty) {
      parts.add('${remainingSeconds}s');
    }
    
    return parts.join(' ');
  }
} 