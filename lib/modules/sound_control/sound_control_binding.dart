
import 'package:get/get.dart';
import 'package:lavenz/modules/sound_control/sound_control_controller.dart';

class SoundControlBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SoundControlController>(() => SoundControlController());
  }
}