import 'package:get/get.dart';
import 'package:rick_and_morty_prj/core/models/character_model.dart';
import 'character_service.dart';

class CharacterController extends GetxController {
  final CharacterService _service = CharacterService();
  RxList<Character> characters = <Character>[].obs;
  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;

  String selectedStatus = '';
  String selectedGender = '';
  String selectedSpecies = '';
  String searchName = '';

  @override
  void onInit() {
    super.onInit();
    fetchCharacters();
  }

  Future<void> applyFilters() async {
    characters.clear();
    page.value = 1;
    hasMore.value = true;
    await fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    if (isLoading.value) return;
    isLoading.value = true;

    final newCharacters = await _service.fetchCharacters(
      page: page.value,
      name: searchName,
      status: selectedStatus,
      gender: selectedGender,
      species: selectedSpecies,
    );

    if (newCharacters != null && newCharacters.isNotEmpty) {
      characters.addAll(newCharacters);
      page.value++;
    } else {
      hasMore.value = false;
    }

    isLoading.value = false;
  }
}
