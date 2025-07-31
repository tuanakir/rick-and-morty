import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty_prj/core/services/theme_service.dart';
import 'package:rick_and_morty_prj/core/services/locale_service.dart';

class SettingsController extends GetxController {
  final themeService = ThemeService();
  final localeService = LocaleService();

  var isDarkMode = false.obs;
  var languageCode = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    final box = Hive.box('settings');
    isDarkMode.value = Get.isDarkMode;
    languageCode.value = box.get('language_code', defaultValue: 'en');
  }

  void toggleTheme() {
    themeService.switchTheme();
    isDarkMode.value = !isDarkMode.value;
  }

  void toggleLanguage() {
    final newLang = languageCode.value == 'en' ? 'tr' : 'en';
    localeService.changeLocale(newLang);
    languageCode.value = newLang;
  }
}
