import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class SoundController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  VideoPlayerController? videoPlayerController;
  List<AudioPlayer> listAudio = [];
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
    AudioPlayer audioPlayer =
        AudioPlayer(playerId: 'aaaa ${listAudio.length + 1}');
    listAudio.add(audioPlayer);
    // await audioPlayer.setSource(AssetSource('background/rain.ogg'));
    listAudio[0].play(
      AssetSource('background/rain.ogg'),
    );
    listAudio[0].setReleaseMode(ReleaseMode.loop);
    Future.delayed(const Duration(seconds: 5), () async {
      AudioPlayer audioPlayer1 =
          AudioPlayer(playerId: 'aaaa ${listAudio.length + 1}');
      listAudio.add(audioPlayer1);
      listAudio[1].play(
        AssetSource('background/bird1.ogg'),
      );
      listAudio[1].setReleaseMode(ReleaseMode.loop);
    });
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
