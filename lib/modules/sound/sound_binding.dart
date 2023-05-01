import 'package:get/get.dart';
import 'package:lavenz/modules/sound/sound_controller.dart';

class SoundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SoundController>(() => SoundController());
  }
}
