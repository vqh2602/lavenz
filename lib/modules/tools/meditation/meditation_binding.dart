
import 'package:get/get.dart';
import 'package:lavenz/modules/tools/meditation/meditation_controller.dart';

class MeditationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeditationController>(() => MeditationController());
  }
}
