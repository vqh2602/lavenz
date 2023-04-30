import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lavenz/data/models/sound.dart' as sound;
import 'package:lavenz/modules/sound_control/sound_control_controller.dart';
import 'package:lavenz/widgets/build_toast.dart';
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
  List<sound.Data> listSound = [];
  List<sound.Data> listMusic = [];
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
    listSound =
        soundData.data?.where((element) => element.type == 1).toList() ?? [];
    listMusic =
        soundData.data?.where((element) => element.type == 2).toList() ?? [];

    //print('listMusic: ${listMusic.length}');
    // print('sond path ${downloadAssetsController.assetsDir}');
    // if(downloaded){
    //   await downloadAssetsController.clearAssets();
    // }
    updateUI();
  }

  Future<void> playSound(
      {required String sound, required sound.Data data}) async {
    if (data.type == 1) {
      soundControlController.playSoundControl(
          path: '${downloadAssetsController.assetsDir}/sound/$sound',
          data: data);
    } else {
      soundControlController.playSoundControl(
          path:
              'https://vqh2602.github.io/lavenz_music_data.github.io/data/music/$sound',
          data: data);
    }
  }

  onPlaySound(String? sound, dynamic data, {bool isPlaying = false}) {
    if (isPlaying) {
      soundControlController.clearSoundWithId(id: data);
      soundControlController.updateUI();
      updateUI();
    } else {
      playSound(sound: sound ?? '', data: data);
      soundControlController.updateUI();
      updateUI();
    }
  }

  Future<void> onPlayMusic(String sound, dynamic data) async {
    buildToast(
      status: TypeToast.toastDefault,
      message: 'Đang tải và phát...',
    );
    soundControlController.loadingUI();
    loadingUI();
    await soundControlController.clearAllMusic();
    Future.delayed(const Duration(seconds: 1), () async {
      await playSound(sound: sound, data: data);
      soundControlController.changeUI();
      changeUI();
    });
    soundControlController.updateUI();
    updateUI();
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
