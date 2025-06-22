import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'episode_controller.dart';

class EpisodeView extends StatelessWidget {
  final controller = Get.put(EpisodeController());
  final ScrollController _scrollController = ScrollController();

  EpisodeView({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          controller.hasMore.value &&
          !controller.isLoading.value) {
        controller.fetchEpisodes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('episodes'.tr)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    onChanged: (val) {
                      controller.name = val;
                      controller.applyFilters();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Episode Code',
                    ),
                    onChanged: (val) {
                      controller.episodeCode = val;
                      controller.applyFilters();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () => controller.applyFilters(),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: controller.episodes.length,
                  itemBuilder: (_, index) {
                    final episode = controller.episodes[index];
                    return ListTile(
                      title: Text(episode.name ?? ''),
                      subtitle: Text('${episode.episode} | ${episode.airDate}'),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
