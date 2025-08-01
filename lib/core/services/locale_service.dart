import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_prj/app/common/controllers/settings_controller.dart';

class LocaleService extends Translations {
  static final LocaleService _instance = LocaleService._internal();
  factory LocaleService() => _instance;
  LocaleService._internal();

  final _box = Hive.box('settings');
  static const _key = 'language_code';

  final Map<String, Map<String, String>> _localizedStrings = {};

  Future<void> loadJsons() async {
    final enJson = await rootBundle.loadString('assets/locales/en.json');
    final trJson = await rootBundle.loadString('assets/locales/tr.json');

    _localizedStrings['en'] = Map<String, String>.from(json.decode(enJson));
    _localizedStrings['tr'] = Map<String, String>.from(json.decode(trJson));
  }

  Locale getCurrentLocale() {
    String code = _box.get(_key, defaultValue: 'en');
    return Locale(code);
  }

  void toggleLanguage() {
    final current = _box.get(_key, defaultValue: 'en');
    final newLang = current == 'en' ? 'tr' : 'en';
    _box.put(_key, newLang);
    Get.updateLocale(Locale(newLang));

    if (Get.isRegistered<SettingsController>()) {
      Get.find<SettingsController>().languageCode.value = newLang;
    }
  }

  @override
  Map<String, Map<String, String>> get keys => _localizedStrings;
}
