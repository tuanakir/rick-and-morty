import 'package:get/get.dart';
import 'package:rick_and_morty_prj/core/models/location_model.dart';
import 'location_service.dart';

class LocationController extends GetxController {
  final LocationService _service = LocationService();
  RxList<Location> locations = <Location>[].obs;
  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;

  String name = '';
  String type = '';
  String dimension = '';

  @override
  void onInit() {
    super.onInit();
    fetchLocations();
  }

  Future<void> applyFilters() async {
    locations.clear();
    page.value = 1;
    hasMore.value = true;
    await fetchLocations();
  }

  Future<void> fetchLocations() async {
    if (isLoading.value) return;
    isLoading.value = true;

    final newItems = await _service.fetchLocations(
      page: page.value,
      name: name,
      type: type,
      dimension: dimension,
    );

    if (newItems != null && newItems.isNotEmpty) {
      locations.addAll(newItems);
      page.value++;
    } else {
      hasMore.value = false;
    }

    isLoading.value = false;
  }
}
