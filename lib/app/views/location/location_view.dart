import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'location_controller.dart';

class LocationView extends StatelessWidget {
  final controller = Get.put(LocationController());
  final ScrollController _scrollController = ScrollController();

  LocationView({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          controller.hasMore.value &&
          !controller.isLoading.value) {
        controller.fetchLocations();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('locations'.tr)),
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
                    decoration: const InputDecoration(labelText: 'Type'),
                    onChanged: (val) {
                      controller.type = val;
                      controller.applyFilters();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Dimension'),
                    onChanged: (val) {
                      controller.dimension = val;
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
                  itemCount: controller.locations.length,
                  itemBuilder: (_, index) {
                    final location = controller.locations[index];
                    return ListTile(
                      title: Text(location.name ?? ''),
                      subtitle: Text(
                        '${location.type} - ${location.dimension}',
                      ),
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
