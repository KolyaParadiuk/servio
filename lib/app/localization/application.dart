import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:servio/constants/locale_constants.dart';

class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();

  String defaultLocaleCode = kRuCodeLocale;
  Locale defaultLocale = Locale(kRuCodeLocale, "");

  final List<String> supportedLanguages = [
    kRuLocale,
  ];

  final List<String> supportedLanguagesCodes = [
    kRuCodeLocale,
  ];

  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((languageCode) => Locale(languageCode, ""));

  ///Decides which locale will be used within the given [updatedDeviceLocaleList]
  Locale resolveLocale({required List<Locale> updatedDeviceLocaleList}) {
    if (updatedDeviceLocaleList.isNotEmpty &&
        supportedLanguagesCodes.contains(updatedDeviceLocaleList.first.languageCode))
      return updatedDeviceLocaleList.first;
    else
      return Locale(application.defaultLocaleCode, "");
  }
}

Application application = Application();

typedef void LocaleChangeCallback(Locale locale);
