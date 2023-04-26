import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lavenz/data/models/sound.dart' as sound;
import 'package:lavenz/modules/sound_control/sound_control_controller.dart';
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';
import 'package:video_player/video_player.dart';

class SoundController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  SoundControlController soundControlController =
      Get.put(SoundControlController());
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  GetStorage box = GetStorage();
  VideoPlayerController? videoPlayerController;
  sound.Sound soundData = sound.Sound();

  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    await initLocalData();
    changeUI();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
  }

  initVideoBackground() {
    videoPlayerController =
        VideoPlayerController.asset('assets/background/vd1.mp4')
          ..initialize().then((_) {
            videoPlayerController?.play();
            videoPlayerController?.setLooping(true);
            videoPlayerController?.setVolume(0);
          });
  }

  Future initLocalData() async {
    await downloadAssetsController.init();
    String data =
        await File('${downloadAssetsController.assetsDir}/json_data/data.json')
            .readAsString();
    soundData = sound.Sound.fromJson(jsonDecode(data));
    // print(sound.data.length);
    // print('sond path ${downloadAssetsController.assetsDir}');
    // if(downloaded){
    //   await downloadAssetsController.clearAssets();
    // }
  }

  Future<void> playSound({required String sound, required sound.Data data}) async {
    soundControlController.playSoundControl(
        path: '${downloadAssetsController.assetsDir}/sound/$sound',data: data);
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
