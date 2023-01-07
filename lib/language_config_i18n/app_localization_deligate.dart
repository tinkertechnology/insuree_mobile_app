
import 'dart:async';
import 'package:flutter/material.dart';
import './app_translation.dart';
import './application.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  final Locale newLocale;

  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) async{
    final prefs = await SharedPreferences.getInstance();
    var __locale =  prefs.getString('language');
    switch (__locale) {
      case 'en':
        locale = Locale(__locale, 'US');
        break;
      case 'np':
        locale = Locale(__locale, 'ET');
        break;
      default:
    }

    return AppTranslations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) {
    return true;
  }
}