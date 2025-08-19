/// Utility class for formatting time durations
class TimeFormatter {
  /// Format duration as HH:MM:SS
  static String formatHHMMSS(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Format duration as MM:SS
  static String formatMMSS(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Format duration as SS (seconds only)
  static String formatSS(Duration duration) {
    return duration.inSeconds.toString();
  }

  /// Format duration with milliseconds as SS.MS
  static String formatWithMilliseconds(Duration duration) {
    final seconds = duration.inSeconds;
    final milliseconds = (duration.inMilliseconds % 1000) ~/ 10;
    return '${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(2, '0')}';
  }

  /// Format duration with milliseconds as SS.MSS
  static String formatWithFullMilliseconds(Duration duration) {
    final seconds = duration.inSeconds;
    final milliseconds = duration.inMilliseconds % 1000;
    return '${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(3, '0')}';
  }

  /// Format duration with words (e.g., "2 hours 30 minutes")
  static String formatWords(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    final parts = <String>[];

    if (hours > 0) {
      parts.add('$hours ${hours == 1 ? 'hour' : 'hours'}');
    }

    if (minutes > 0) {
      parts.add('$minutes ${minutes == 1 ? 'minute' : 'minutes'}');
    }

    if (seconds > 0 || parts.isEmpty) {
      parts.add('$seconds ${seconds == 1 ? 'second' : 'seconds'}');
    }

    return parts.join(' ');
  }

  /// Format duration with short words (e.g., "2h 30m")
  static String formatShortWords(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    final parts = <String>[];

    if (hours > 0) {
      parts.add('${hours}h');
    }

    if (minutes > 0) {
      parts.add('${minutes}m');
    }

    if (seconds > 0 || parts.isEmpty) {
      parts.add('${seconds}s');
    }

    return parts.join(' ');
  }

  /// Format duration with custom pattern
  /// Pattern can contain: {h} for hours, {m} for minutes, {s} for seconds, {ms} for milliseconds
  static String formatCustom(Duration duration, String pattern) {
    return pattern
        .replaceAll('{h}', duration.inHours.toString().padLeft(2, '0'))
        .replaceAll('{m}', (duration.inMinutes % 60).toString().padLeft(2, '0'))
        .replaceAll('{s}', (duration.inSeconds % 60).toString().padLeft(2, '0'))
        .replaceAll('{ms}',
            (duration.inMilliseconds % 1000).toString().padLeft(3, '0'));
  }

  /// Smart format - automatically chooses the best format based on duration
  static String formatSmart(Duration duration) {
    if (duration.inHours > 0) {
      return formatHHMMSS(duration);
    } else if (duration.inMinutes > 0) {
      return formatMMSS(duration);
    } else {
      return formatSS(duration);
    }
  }

  /// Format duration for countdown display
  static String formatCountdown(Duration duration,
      {bool showMilliseconds = false}) {
    if (showMilliseconds) {
      return formatWithMilliseconds(duration);
    }
    return formatSmart(duration);
  }

  /// Get the most appropriate format for a given duration
  static String Function(Duration) getFormatter({
    bool showHours = true,
    bool showMinutes = true,
    bool showSeconds = true,
    bool showMilliseconds = false,
    String? customPattern,
  }) {
    if (customPattern != null) {
      return (duration) => formatCustom(duration, customPattern);
    }

    if (showMilliseconds) {
      return formatWithMilliseconds;
    }

    if (showHours && showMinutes && showSeconds) {
      return formatHHMMSS;
    } else if (showMinutes && showSeconds) {
      return formatMMSS;
    } else if (showSeconds) {
      return formatSS;
    } else {
      return formatSmart;
    }
  }
}
