import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/views/character/character_binding.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/themes.dart';
import 'core/services/theme_service.dart';
import 'core/services/locale_service.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');

  final localeService = LocaleService();
  await localeService.loadJsons();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = ThemeService();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      translations: LocaleService(),
      locale: LocaleService().getCurrentLocale(),
      fallbackLocale: const Locale('en', 'US'),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeService.theme,
      initialBinding: CharacterBinding(),
      home: const HomeView(),
    );
  }
}
