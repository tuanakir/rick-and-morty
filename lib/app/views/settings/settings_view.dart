import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:rick_and_morty_prj/core/services/theme_service.dart';
import 'package:rick_and_morty_prj/core/constants/locale_keys.dart';
import 'package:rick_and_morty_prj/app/common/widgets/language_toggle_button.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final themeService = ThemeService();
  final isDarkMode = Get.isDarkMode.obs;

  @override
  Widget build(BuildContext context) {
    final languageCode =
        (Hive.box('settings').get('language_code', defaultValue: 'en')
                as String)
            .obs;

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.settings.tr), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
              () => SwitchListTile(
                title: Text(LocaleKeys.dark.tr),
                value: isDarkMode.value,
                onChanged: (_) {
                  themeService.switchTheme();
                  isDarkMode.value = !isDarkMode.value;
                },
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => ListTile(
                title: Text(LocaleKeys.language.tr),
                subtitle: Text(
                  languageCode.value == 'tr' ? 'Türkçe' : 'English',
                ),
                trailing: const LanguageToggleButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
