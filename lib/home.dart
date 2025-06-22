import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/views/character/character_view.dart';
import 'app/views/location/location_view.dart';
import 'app/views/episode/episode_view.dart';
import 'app/views/settings/settings_view.dart';
import 'core/constants/locale_keys.dart';
import 'app/common/widgets/custom_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final _pages = [CharacterView(), LocationView(), EpisodeView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: LocaleKeys.rickAndMorty.tr,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.to(() => SettingsView()),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        backgroundColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: LocaleKeys.characters.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: LocaleKeys.locations.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.tv),
            label: LocaleKeys.episodes.tr,
          ),
        ],
      ),
    );
  }
}
