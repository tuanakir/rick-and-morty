import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class LocaleService extends Translations {
  static const String _localeKey = 'locale';
  final Box _box = Hive.box('settings');

  static const supportedLocales = [Locale('en', 'US'), Locale('tr', 'TR')];

  static final Locale fallbackLocale = Locale('en', 'US');

  static final Map<String, Map<String, String>> _localizedValues = {};

  LocaleService() {
    _init();
  }

  Future<void> _init() async {
    _localizedValues.addAll(await loadTranslations());
  }

  @override
  Map<String, Map<String, String>> get keys => _localizedValues;

  Future<Map<String, Map<String, String>>> loadTranslations() async {
    final enJson = await rootBundle.loadString('assets/locales/en.json');
    final trJson = await rootBundle.loadString('assets/locales/tr.json');

    return {
      'en_US': Map<String, String>.from(json.decode(enJson)),
      'tr_TR': Map<String, String>.from(json.decode(trJson)),
    };
  }

  Locale getCurrentLocale() {
    final localeCode = _box.get(_localeKey, defaultValue: 'en_US');
    final parts = localeCode.split('_');
    return Locale(parts[0], parts[1]);
  }

  void toggleLanguage() {
    Locale newLocale;
    if (Get.locale?.languageCode == 'en') {
      newLocale = const Locale('tr', 'TR');
      _box.put(_localeKey, 'tr_TR');
    } else {
      newLocale = const Locale('en', 'US');
      _box.put(_localeKey, 'en_US');
    }
    Get.updateLocale(newLocale);
  }
}
