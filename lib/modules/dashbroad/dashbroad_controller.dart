import 'dart:async';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/widgets/mixin/admod_mixin.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';

class DashBroadController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin, ADmodMixin {
  User? user;
  NativeAd? myNative;
  bool isAdLoad = false;

  @override
  Future<void> onInit() async {
    initData();
    super.onInit();
  }

  

  @override
  void dispose() {
    super.dispose();
    myNative?.dispose();
  }

  initData() async {
    loadingUI();
    user = getUserInBox();
    myNative = await createADNative(onLoad: () {
      isAdLoad = true;
      updateUI();
    }, onFaile: () {
      isAdLoad = false;
      updateUI();
    });

    changeUI();
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
