import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:servio/constants/locale_constants.dart';

import 'application.dart';

String tr(String key) => LocalTranslations._translate(key);

class LocalTranslations {
  static LocalTranslations currentAppTranslations = LocalTranslations(locale: application.defaultLocale);

  static LocalTranslations of(BuildContext context) {
    return Localizations.of<LocalTranslations>(context, LocalTranslations)!;
  }

  static Future<LocalTranslations> load(Locale locale) async {
    currentLocaleCode = locale.languageCode;

    currentAppTranslations = LocalTranslations(locale: locale);

    final jsonContent = await rootBundle.loadString("localization/localization_${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);

    final defaultJsonContent = await rootBundle.loadString("localization/localization_ru.json");
    _defaultLocalisedValues = json.decode(defaultJsonContent);

    return currentAppTranslations;
  }

  Locale locale;
  static late Map<String, dynamic> _localisedValues;
  static late Map<dynamic, dynamic> _defaultLocalisedValues;

  static Map<String, dynamic> get localisedValues => _localisedValues;
  static String currentLocaleCode = application.defaultLocaleCode;

  LocalTranslations({required this.locale});

  String get currentLanguage => locale.languageCode;

  Locale get dateTimePickerLocale {
    switch (currentLanguage) {
      case kRuCodeLocale:
        return Locale.fromSubtags(languageCode: kRuCodeLocale);
    }

    return locale;
  }

  static String _translate(String key) {
    // return _localisedValues[key] ?? "$key not found";
    if (_localisedValues[key] == null) {
      return "$key not found";
    } else {
      return (_localisedValues[key] as String).isEmpty ? _defaultLocalisedValues[key] : _localisedValues[key];
    }
  }
}
