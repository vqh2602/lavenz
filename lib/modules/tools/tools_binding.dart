
import 'package:get/get.dart';
import 'package:lavenz/modules/tools/tools_controller.dart';

class ToolsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToolsController>(() => ToolsController());
  }
}
