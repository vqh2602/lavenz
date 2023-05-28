
import 'package:get/get.dart';
import 'package:lavenz/modules/tools/horoscope/horoscope_controller.dart';

class HoroscopeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HoroscopeController>(() => HoroscopeController());
  }
}
