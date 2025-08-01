import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'character_controller.dart';
import 'package:rick_and_morty_prj/core/utils/utils.dart';

class CharacterView extends StatelessWidget {
  final controller = Get.put(CharacterController());
  final ScrollController _scrollController = ScrollController();

  CharacterView({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          controller.hasMore.value &&
          !controller.isLoading.value) {
        controller.fetchCharacters();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('characters'.tr)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Utils.normalPadding),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (val) {
                      controller.searchName = val;
                      controller.applyFilters();
                    },
                  ),
                ),
                SizedBox(width: Utils.smallSpace),
                DropdownButton<String>(
                  value:
                      controller.selectedStatus.isEmpty
                          ? null
                          : controller.selectedStatus,
                  hint: const Text("Status"),
                  items:
                      ['alive', 'dead', 'unknown']
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
                          .toList(),
                  onChanged: (val) {
                    controller.selectedStatus = val ?? '';
                    controller.applyFilters();
                  },
                ),
                SizedBox(width: Utils.smallSpace),
                DropdownButton<String>(
                  value:
                      controller.selectedGender.isEmpty
                          ? null
                          : controller.selectedGender,
                  hint: const Text("Gender"),
                  items:
                      ['male', 'female', 'genderless', 'unknown']
                          .map(
                            (g) => DropdownMenuItem(value: g, child: Text(g)),
                          )
                          .toList(),
                  onChanged: (val) {
                    controller.selectedGender = val ?? '';
                    controller.applyFilters();
                  },
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
                  itemCount: controller.characters.length,
                  itemBuilder: (_, index) {
                    final character = controller.characters[index];
                    return ListTile(
                      leading:
                          character.image != null
                              ? Image.network(
                                character.image!,
                                width: Utils.avatarSize,
                                height: Utils.avatarSize,
                                fit: BoxFit.cover,
                              )
                              : null,
                      title: Text(character.name ?? ''),
                      subtitle: Text(character.status ?? ''),
                      trailing: Text(character.gender ?? ''),
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
