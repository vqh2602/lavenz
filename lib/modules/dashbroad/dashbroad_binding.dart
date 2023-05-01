import 'package:get/get.dart';
import 'package:lavenz/modules/dashbroad/dashbroad_controller.dart';

class DashBroadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBroadController>(() => DashBroadController());
  }
}
