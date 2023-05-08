import 'package:get/get.dart';
import 'package:lavenz/modules/vip/vip_controller.dart';

class VipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VipController>(() => VipController());
  }
}
