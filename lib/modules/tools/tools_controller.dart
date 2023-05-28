import 'dart:async';
import 'package:get/get.dart';
import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';

class ToolsController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin {
  User user = User();
  @override
  Future<void> onInit() async {
    super.onInit();
    initData();
    changeUI();
  }

  initData() async {
    user = getUserInBox();
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
