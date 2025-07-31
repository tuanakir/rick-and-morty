import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rick_and_morty_prj/core/constants/locale_keys.dart';
import 'package:rick_and_morty_prj/app/common/widgets/language_toggle_button.dart';
import 'package:rick_and_morty_prj/app/common/controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.settings.tr), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
              () => SwitchListTile(
                title: Text(LocaleKeys.dark.tr),
                value: controller.isDarkMode.value,
                onChanged: (_) {
                  controller.toggleTheme();
                },
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => ListTile(
                title: Text(LocaleKeys.language.tr),
                subtitle: Text(
                  controller.languageCode.value == 'tr' ? 'Türkçe' : 'English',
                ),
                trailing: LanguageToggleButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
