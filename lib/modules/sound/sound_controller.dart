import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/data/models/sound.dart' as sound;
import 'package:lavenz/data/models/tag.dart' as tag;
import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/modules/sound_control/sound_control_controller.dart';
import 'package:lavenz/widgets/build_toast.dart';
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';
import 'package:lavenz/widgets/share_function/share_funciton.dart';

class SoundController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin {
  SoundControlController soundControlController =
      Get.put(SoundControlController());
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  //VideoPlayerController? videoPlayerController;
  late TabController tabController, tabControllerMin;
  sound.Sound soundData = sound.Sound();
  tag.Tag tagData = tag.Tag();
  List<sound.Data> listSound = [];
  List<sound.Data> listMusic = [];
  List<tag.Data> listTagSound = [];
  List<String> dataTab = [
    'Tất cả'.tr,
  ];
  User? user;
  @override
  Future<void> onInit() async {
    super.onInit();
    loadingUI();
    initUserData();
    await initLocalData();
    initTabbar();
    changeUI();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    tabControllerMin.dispose();
  }

  initVideoBackground() {
    // videoPlayerController =
    //     VideoPlayerController.asset('assets/background/vd1.mp4')
    //       ..initialize().then((_) {
    //         videoPlayerController?.play();
    //         videoPlayerController?.setLooping(true);
    //         videoPlayerController?.setVolume(0);
    //       });
  }
  initTabbar() {
    tabController = TabController(length: 2, vsync: this);
    tabControllerMin =
        TabController(length: listTagSound.length + 1, vsync: this);
    tabControllerMin.addListener(() {
      updateUI();
    });
    tabController.addListener(() {
      updateUI();
    });
  }

  initUserData() {
    user = getUserInBox();
  }

  Future initLocalData() async {
    await downloadAssetsController.init();
    try {
      String data = await File(
              '${downloadAssetsController.assetsDir}/json_data/data_${getLocalConvertString()}.json')
          .readAsString();
      String dataTag = await File(
              '${downloadAssetsController.assetsDir}/json_data/tag_${getLocalConvertString()}.json')
          .readAsString();
      soundData = sound.Sound.fromJson(jsonDecode(data));
      tagData = tag.Tag.fromJson(jsonDecode(dataTag));
      listSound =
          soundData.data?.where((element) => element.type == 1).toList() ?? [];
      listMusic =
          soundData.data?.where((element) => element.type == 2).toList() ?? [];
      listTagSound = tagData.data
              ?.where((element) => num.parse(element.type.toString()) == 1)
              .toList() ??
          [];
      dataTab.addAll(listTagSound.map((e) => e.name ?? '').toList());
    } catch (_) {}
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

  onPlaySound(String? sound, sound.Data? data,
      {bool isPlaying = false, num? id}) async {
    // if ((data?.vip ?? false) && !checkExpiry(user: user!)) {
    //   Get.toNamed(VipScreen.routeName);
    // } else {
      if (isPlaying) {
        await soundControlController.clearSoundWithId(id: id);
        soundControlController.updateUI();
        updateUI();
      } else {
        await playSound(sound: sound ?? '', data: data!);
        soundControlController.updateUI();
        updateUI();
      }
    // }
  }

  Future<void> onPlayMusic(String sound, sound.Data data) async {
    // if ((data.vip ?? false) && !checkExpiry(user: user!)) {
    //   Get.toNamed(VipScreen.routeName);
    // } else {
      buildToast(
        status: TypeToast.toastDefault,
        message: 'Đang tải và phát: ${data.name}...'.tr,
      );
      soundControlController.loadingUI();
      // loadingUI();
      await soundControlController.clearAllMusic();
      Future.delayed(const Duration(seconds: 1), () async {
        await playSound(sound: sound, data: data);
        soundControlController.changeUI();
        //changeUI();
        updateUI();
      });
      soundControlController.updateUI();
    // }
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
