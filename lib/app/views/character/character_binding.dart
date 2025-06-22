import 'package:get/get.dart';
import 'character_controller.dart';

class CharacterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CharacterController());
  }
}
