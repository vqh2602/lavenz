import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lavenz/modules/sound_control/sound_control_controller.dart';

class MeditationController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  SoundControlController soundControlController = Get.find();
  GetStorage box = GetStorage();
  late AudioPlayer audioPlayer;
  Timer? debounce;
  Duration duration = const Duration();
  Duration duration1 = const Duration();
  late AnimationController controller;
  Timer? timer;
  Timer? timer1;
  bool inhale = false;
  @override
  Future<void> onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer(userAgent: 'sound inhale');
    initAnimation();
    changeUI();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    audioPlayer.dispose();
  }

  initAnimation() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        controller.forward();
        updateUI();
      }
    });
    // controller.addListener(() {
    //   //0->1
    //   //print(controller.view.value);
    //   if (controller.view.value.toStringAsFixed(2) == '0.00') {
    //     inhale = true;
    //     playSound();
    //     updateUI();
    //   }
    //   if (controller.view.value.toStringAsFixed(2) == '0.50') {
    //     inhale = false;
    //     playSound(inhale: false);
    //     updateUI();
    //   }
    //       if(controller.view.value == 0.01) {
    //   playSound();
    // }
    // });
  }

  playSound({bool inhale = true, String? url}) async {
    // print('play sound');
    // await audioPlayer.pause();
    // await audioPlayer.dispose();
    audioPlayer = AudioPlayer(userAgent: 'sound meditation');
    if (url == null) {
      inhale
          ? await audioPlayer.setAsset('assets/sound/inhale1.mp3')
          : await audioPlayer.setAsset('assets/sound/exhale.mp3');
    } else {
      await audioPlayer.setAsset(url);
    }
    await audioPlayer.setLoopMode(LoopMode.off);
    await audioPlayer.setVolume(1);
    await audioPlayer.play();
  }

  playStartTime() {
    startTimer();
    if (debounce != null) {
      debounce?.cancel();
    }
    if (duration1 != Duration.zero) {
      debounce = Timer(const Duration(milliseconds: 300), () {
        startTimer1(duration: duration1);
      });
    }
    // phát tất cả nhạc
    soundControlController.playAll();
  }

  closeStartTime() {
    timer?.cancel();
    if (debounce != null) {
      debounce?.cancel();
    }
    duration1 = Duration.zero;
    playSound(url: 'assets/sound/notification.mp3');
    //huỷ tất cả nhạc
    soundControlController.pauseAll();
  }

  void startTimer() {
    duration = Duration.zero;
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    updateUI();
  }

//đếm ngược
  void startTimer1({required Duration duration}) {
    duration1 = duration;
    if (timer1 != null) {
      timer1?.cancel();
      //timer?.cancel();
    }
    timer1 =
        Timer.periodic(const Duration(seconds: 1), (_) => addTimeDownTime());
    updateUI();
  }

// đếm xuôi
  void addTime() {
    const addSeconds = 1;
    final seconds = duration.inSeconds + addSeconds;
    // if (seconds < 0) {
    //   timer?.cancel();
    // } else {
    duration = Duration(seconds: seconds);
    // }
    updateUI();
  }

  void addTimeDownTime() {
    const addSeconds = 1;
    final seconds = duration1.inSeconds - addSeconds;
    if (seconds < 0) {
      timer1?.cancel();
      timer?.cancel();
      controller.stop();
      soundControlController.pauseAll();
      playSound(url: 'assets/sound/notification.mp3');
    } else {
      duration1 = Duration(seconds: seconds);
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
