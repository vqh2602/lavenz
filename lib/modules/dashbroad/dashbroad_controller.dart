import 'dart:async';
import 'package:get/get.dart';
import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';
import 'package:video_player/video_player.dart';

class DashBroadController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin {
  VideoPlayerController? videoPlayerController;
  User? user;

  @override
  Future<void> onInit() async {
    initData();
    changeUI();
    super.onInit();
  }

  initVideoBackground() {
    videoPlayerController =
        VideoPlayerController.asset('assets/background/vd3.mp4')
          ..initialize().then((_) {
            videoPlayerController?.play();
            videoPlayerController?.setLooping(true);
            videoPlayerController?.setVolume(0);
          });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
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
