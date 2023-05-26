
import 'package:get/get.dart';
import 'package:lavenz/modules/tools/breath/breath_controller.dart';

class BreathBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BreathController>(() => BreathController());
  }
}
