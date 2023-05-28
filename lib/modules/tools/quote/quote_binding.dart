import 'package:get/get.dart';
import 'package:lavenz/modules/tools/quote/quote_controller.dart';

class QuoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuoteController>(() => QuoteController());
  }
}
