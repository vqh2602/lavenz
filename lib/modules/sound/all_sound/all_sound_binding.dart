import 'package:get/get.dart';
import 'package:lavenz/modules/sound/all_sound/all_sound_controller.dart';

class AllSoundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllSoundController>(() => AllSoundController());
  }
}
