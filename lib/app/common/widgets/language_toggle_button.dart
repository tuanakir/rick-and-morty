import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty_prj/core/services/locale_service.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Get.locale?.languageCode ?? 'en';
    return ElevatedButton(
      onPressed: () {
        LocaleService().toggleLanguage();
      },
      child: Text(lang == 'tr' ? 'EN' : 'TR'),
    );
  }
}
