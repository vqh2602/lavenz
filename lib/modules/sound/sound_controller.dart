import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lavenz/modules/sound_control/sound_control_controller.dart';
import 'package:video_player/video_player.dart';

class SoundController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  SoundControlController soundControlController =
      Get.put(SoundControlController());
  GetStorage box = GetStorage();
  VideoPlayerController? videoPlayerController;
  @override
  Future<void> onInit() async {
    super.onInit();
    changeUI();
  }

  initVideoBackground() {
    videoPlayerController =
        VideoPlayerController.asset('assets/background/vd2.mp4')
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

  Future<void> playSound() async {
    soundControlController.playSoundControl();
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
