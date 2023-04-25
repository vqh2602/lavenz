import 'dart:async';
import 'dart:developer';
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

  // static var countdownDuration = const Duration(minutes: 10);
  // static var countdownDuration1 = const Duration(minutes: 10);
  // Duration duration = const Duration();
  Duration duration1 = const Duration();
  // Timer? timer;
  Timer? timer1;
  //bool countDown = true;
  bool countDown1 = true;
  // var hours;
  // var mints;
  // var secs;

  @override
  Future<void> onInit() async {
    super.onInit();
    changeUI();
  }

  // void test() {
  //   hours = int.parse("00");
  //   mints = int.parse("00");
  //   secs = int.parse("00");
  //   countdownDuration = Duration(hours: hours, minutes: mints, seconds: secs);
  //   startTimer();
  //   reset();
  //   // var hours1;
  //   // var mints1;
  //   // var secs1;
  //   // hours1 = int.parse("10");
  //   // mints1 = int.parse("0");
  //   // secs1 = int.parse("00");
  //   // countdownDuration1 =
  //   //     Duration(minutes: mints1,);
  //   startTimer1();
  //   reset1();
  // }

  // void reset() {
  //   if (countDown) {
  //     duration = countdownDuration;
  //   } else {
  //     duration = Duration();
  //   }
  //   updateUI();
  // }

  void resetDownTime() {
    timer1?.cancel();
    duration1 = const Duration();
    updateUI();
  }

  // void startTimer() {
  //   timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  //   updateUI();
  // }

  void startTimer1({required Duration duration}) {
    duration1 = duration;
    if (timer1 != null) timer1?.cancel();
    timer1 =
        Timer.periodic(const Duration(seconds: 1), (_) => addTimeDownTime());
    updateUI();
  }

  // void addTime() {
  //   final addSeconds = 1;
  //   final seconds = duration.inSeconds + addSeconds;
  //   if (seconds < 0) {
  //     timer?.cancel();
  //   } else {
  //     duration = Duration(seconds: seconds);
  //   }
  //   updateUI();
  // }

  void addTimeDownTime() {
    const addSeconds = 1;
    final seconds = duration1.inSeconds - addSeconds;
    if (seconds < 0) {
      timer1?.cancel();
      log('tắt nhạc');
    } else {
      duration1 = Duration(seconds: seconds);
    }
    updateUI();
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

    updateUI();
  }

  Future<void> clearAllSound() async {
      Timer(const Duration(seconds: 3), () {
        for (var element in listAudio) {
          element.audioPlayer.dispose();
        }
        listAudio.clear();
        updateUI();
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
