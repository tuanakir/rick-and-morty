import 'package:get/get.dart';
import 'package:rick_and_morty_prj/core/models/episode_model.dart';
import 'episode_service.dart';

class EpisodeController extends GetxController {
  final EpisodeService _service = EpisodeService();
  RxList<Episode> episodes = <Episode>[].obs;
  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;

  String name = '';
  String episodeCode = '';

  @override
  void onInit() {
    super.onInit();
    fetchEpisodes();
  }

  Future<void> applyFilters() async {
    episodes.clear();
    page.value = 1;
    hasMore.value = true;
    await fetchEpisodes();
  }

  Future<void> fetchEpisodes() async {
    if (isLoading.value) return;
    isLoading.value = true;

    final newItems = await _service.fetchEpisodes(
      page: page.value,
      name: name,
      episode: episodeCode,
    );

    if (newItems != null && newItems.isNotEmpty) {
      episodes.addAll(newItems);
      page.value++;
    } else {
      hasMore.value = false;
    }

    isLoading.value = false;
  }
}
