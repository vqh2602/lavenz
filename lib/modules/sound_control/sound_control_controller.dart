import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lavenz/data/models/sound.dart' as sound;
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';
import 'package:video_player/video_player.dart';

class SoundControlController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  VideoPlayerController? videoPlayerController;
  List<AudioCustom> listAudio = [];
  List<AudioCustom> listMusic = [];
  Timer? debounce;
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();

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
    initLocalData();
    changeUI();
  }

  Future initLocalData() async {
    await downloadAssetsController.init();
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

  Future<void> playSoundControl(
      {required String path, required sound.Data data}) async {
    AudioPlayer audioPlayer =
        AudioPlayer(playerId: 'sound ${listAudio.length + 1}');
    listAudio.add(AudioCustom(
        audioPlayer: audioPlayer,
        volume: 0.5,
        title: data.name ?? '',
        data: data));
    // await audioPlayer.setSource(AssetSource('background/rain.ogg'));
    listAudio.last.audioPlayer.play(
      DeviceFileSource(File(path).path),
    );
    listAudio.last.audioPlayer.setReleaseMode(ReleaseMode.loop);
    listAudio.last.audioPlayer.setVolume(0.5);

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
  sound.Data data;

  AudioCustom(
      {required this.audioPlayer,
      required this.volume,
      required this.title,
      required this.data});
}
