import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class SoundControlController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  VideoPlayerController? videoPlayerController;
  List<AudioCustom> listAudio = [];
  Timer? debounce;

  @override
  Future<void> onInit() async {
    super.onInit();
    changeUI();
  }

  initVideoBackground() {
    videoPlayerController =
        VideoPlayerController.asset('assets/background/vd4.mp4')
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

  Future<void> playSoundControl() async {
    AudioPlayer audioPlayer =
        AudioPlayer(playerId: 'aaaa ${listAudio.length + 1}');
    listAudio.add(AudioCustom(audioPlayer, 0.5, 'hdhsdhfsadhfjh jksdhfbh', ''));
    // await audioPlayer.setSource(AssetSource('background/rain.ogg'));
    listAudio[0].audioPlayer.play(
          AssetSource('background/rain.ogg'),
        );
    listAudio[0].audioPlayer.setReleaseMode(ReleaseMode.loop);
    listAudio[0].audioPlayer.setVolume(0.5);

    Future.delayed(const Duration(seconds: 5), () async {
      AudioPlayer audioPlayer1 =
          AudioPlayer(playerId: 'aaaa ${listAudio.length + 1}');
      listAudio
          .add(AudioCustom(audioPlayer1, 0.5, 'hdhsdhfsadhfjh jksdhfbh', ''));
      listAudio[1].audioPlayer.play(
            AssetSource('background/bird1.ogg'),
          );
      listAudio[1].audioPlayer.setReleaseMode(ReleaseMode.loop);
      listAudio[1].audioPlayer.setVolume(0.5);
      updateUI();
    });

    Future.delayed(const Duration(seconds: 15), () async {
      clearAllSound();
    });
    updateUI();
  }

  Future<void> clearAllSound() async {
    if (debounce != null) debounce?.cancel();
    debounce = Timer(const Duration(seconds: 2), () {
      Timer(const Duration(minutes: 1), () {
        for (var element in listAudio) {
          element.audioPlayer.dispose();
        }
        listAudio.clear();
        updateUI();
      });
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

class AudioCustom {
  AudioPlayer audioPlayer;
  double volume;
  String title;
  dynamic data;

  AudioCustom(this.audioPlayer, this.volume, this.title, this.data);
}
