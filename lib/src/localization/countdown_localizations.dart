import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

/// Simple localisations for countdown timer unit labels.
/// Only a subset of strings is exposed for demo purposes.
class CountdownLocalizations {
  CountdownLocalizations(this.locale);

  final Locale locale;

  /// Accessor
  static CountdownLocalizations of(BuildContext context) {
    return Localizations.of<CountdownLocalizations>(
      context,
      CountdownLocalizations,
    )!;
  }

  /// Map of default unit abbreviations used by the timer when
  /// `showTimeUnits` is enabled and the caller did not override
  /// [AdvancedCountdownTimer.timeUnitLabels].
  Map<String, String> get timeUnitLabels {
    switch (locale.languageCode) {
      case 'es':
        return const {'h': 'h', 'm': 'm', 's': 's'};
      case 'fr':
        return const {'h': 'h', 'm': 'm', 's': 's'};
      case 'en':
      default:
        return const {'h': 'h', 'm': 'm', 's': 's'};
    }
  }

  // Example of pluralised label that could be expanded later.
  String hours(int value) => intl.Intl.plural(
        value,
        zero: '0 hrs',
        one: '1 hr',
        other: '$value hrs',
        locale: locale.toString(),
      );

  // -- Delegate -------------------------------------------------------------
  static const LocalizationsDelegate<CountdownLocalizations> delegate =
      _CountdownLocalizationsDelegate();
}

class _CountdownLocalizationsDelegate
    extends LocalizationsDelegate<CountdownLocalizations> {
  const _CountdownLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  Future<CountdownLocalizations> load(Locale locale) async {
    intl.Intl.defaultLocale = locale.toString();
    return CountdownLocalizations(locale);
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<CountdownLocalizations> old) =>
      false;
}
