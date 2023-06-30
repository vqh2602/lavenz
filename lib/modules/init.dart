import 'package:get/get.dart';
import 'package:lavenz/modules/dashbroad/dashbroad_controller.dart';
import 'package:lavenz/modules/home/home_controller.dart';
import 'package:lavenz/modules/setting/setting_controller.dart';
import 'package:lavenz/modules/sound/sound_controller.dart';
import 'package:lavenz/modules/sound_control/sound_control_controller.dart';
import 'package:lavenz/modules/tools/tools_controller.dart';

Future<void> initialize() async {
//hinh anh

  //controller
  Get.lazyPut<HomeController>(
    () => HomeController(),
  );
  // Get.lazyPut<VipController>(
  //   () => VipController(),
  // );
  Get.lazyPut<DashBroadController>(
    () => DashBroadController(),
  );
  Get.lazyPut<SoundControlController>(
    () => SoundControlController(),
  );
  Get.lazyPut<SoundController>(
    () => SoundController(),
  );
  Get.lazyPut<SettingController>(
    () => SettingController(),
  );
    Get.lazyPut<ToolsController>(
    () => ToolsController(),
  );
}
