import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lavenz/data/models/sound.dart' as sound;
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';

class SoundControlController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  // VideoPlayerController? videoPlayerController;
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
  bool countDown1 = true, isPlayMusic = false, isPlaySound = false;
  // var hours;
  // var mints;
  // var secs;

  @override
  Future<void> onInit() async {
    super.onInit();
    initLocalData();
    changeUI();
  }

  @override
  void dispose() {
    super.dispose();
    // videoPlayerController?.dispose();
    clearAllMusic();
    clearAllSound();
  }

  Future initLocalData() async {
    await downloadAssetsController.init();
    updateUI();
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

    if (listAudio.isNotEmpty) {
      isPlaySound = false;
      playAllSound(type: 1);
    }
    if (listMusic.isNotEmpty) {
      isPlayMusic = false;
      playAllSound(type: 2);
    }

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

      if (listAudio.isNotEmpty) {
        isPlaySound = true;
        playAllSound(type: 1);
      }
      if (listMusic.isNotEmpty) {
        isPlayMusic = true;
        playAllSound(type: 2);
      }
    } else {
      duration1 = Duration(seconds: seconds);
    }
    updateUI();
  }

  initVideoBackground() {
    // videoPlayerController =
    //     VideoPlayerController.asset('assets/background/vd4.mp4')
    //       ..initialize().then((_) {
    //         videoPlayerController?.play();
    //         videoPlayerController?.setLooping(true);
    //         videoPlayerController?.setVolume(0);
    //       });
  }

  Future<void> playSoundControl(
      {required String path, required sound.Data data}) async {
    AudioPlayer audioPlayer =
        AudioPlayer(userAgent: 'sound ${listAudio.length + 1}');
    if (data.type == 1) {
      isPlaySound = false;
      playAllSound(type: data.type);
      listAudio.add(AudioCustom(
          audioPlayer: audioPlayer,
          volume: 0.5,
          title: data.name ?? '',
          data: data));
      //await listAudio.last.audioPlayer.setFilePath(File(path).path);
      //  print('url sound:$path');
      // String a = 'sound:/Users/vuongquanghuy/Library/Developer/CoreSimulator/Devices/8E45B80C-0A53-4FB2-A778-9E8AE9428544/data/Containers/Data/Application/3695801F-7F20-4A2D-9C99-87C2BAF712E1/Documents/assets/sound/unspokenWords.mp3';
      File file = File(path);
      file.readAsBytesSync();

      await listAudio.last.audioPlayer.setFilePath(path);
      await listAudio.last.audioPlayer.setLoopMode(LoopMode.all);
      await listAudio.last.audioPlayer.setVolume(0.5);
      await listAudio.last.audioPlayer.play();
    } else {
      isPlayMusic = false;
      playAllSound(type: data.type);
      listMusic.add(AudioCustom(
          audioPlayer: audioPlayer,
          volume: 0.5,
          title: data.name ?? '',
          data: data));
      await listMusic[0].audioPlayer.setUrl(path);
      await listMusic[0].audioPlayer.setLoopMode(LoopMode.all);
      await listMusic[0].audioPlayer.setVolume(0.5);
      await listMusic[0].audioPlayer.play();
    }
    updateUI();
  }

  void clearAllSound() {
    Timer(const Duration(seconds: 0), () {
      for (var element in listAudio) {
        element.audioPlayer.dispose();
      }
      listAudio.clear();
      updateUI();
    });
  }

  Future<void> clearAllMusic() async {
    Timer(const Duration(seconds: 0), () {
      if (listMusic.isNotEmpty) {
        for (var element in listMusic) {
          element.audioPlayer.dispose();
          listMusic.remove(element);
          break;
        }
      }
      updateUI();
    });
  }

  Future<void> playAllSound({num? type = 1}) async {
    if (type == 1) {
      if (isPlaySound) {
        for (var element in listAudio) {
          element.audioPlayer.pause();
        }
        isPlaySound = false;
      } else {
        for (var element in listAudio) {
          element.audioPlayer.setVolume(0.5);
          element.volume = 0.5;
          element.audioPlayer.play();
        }
        isPlaySound = true;
      }
    } else {
      if (isPlayMusic) {
        for (var element in listMusic) {
          element.audioPlayer.pause();
        }
        isPlayMusic = false;
      } else {
        for (var element in listMusic) {
          element.audioPlayer.setVolume(0.5);
          element.volume = 0.5;
          element.audioPlayer.play();
        }
        isPlayMusic = true;
      }
    }
    updateUI();
  }

  Future<void> clearSoundWithId({required num? id}) async {
    for (var element in listAudio) {
      if (element.data.id == id) {
        element.audioPlayer.dispose();
        listAudio.remove(element);
        updateUI();
        break;
      }
    }
    updateUI();
    changeUI();
  }

  onSetVolume(AudioCustom audioCustom, double volume, {required int type}) {
    if (type == 1) {
      audioCustom.audioPlayer.setVolume(volume);
      audioCustom.volume = volume;
    } else {
      audioCustom.audioPlayer.setVolume(volume);
      audioCustom.volume = volume;
    }
    updateUI();
  }

  onPauseMP3(AudioCustom audioCustom, int index, {required int type}) {
    if (type == 1) {
      audioCustom.audioPlayer.dispose();
      listAudio.removeAt(index);
    } else {
      audioCustom.audioPlayer.dispose();
      listMusic.removeAt(index);
    }
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
