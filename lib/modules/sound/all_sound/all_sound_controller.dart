import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/modules/sound/sound_controller.dart';
import 'package:lavenz/widgets/mixin/admod_mixin.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';
import 'package:lavenz/data/models/sound.dart' as sound;

class AllSoundController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin, ADmodMixin {
  TextEditingController searchTE = TextEditingController();

  List<sound.Data> listAllMusic = [];
  List<sound.Data> listAllMusicResult = [];
  num? musicType;

  SoundController soundController = Get.find();

  @override
  Future<void> onInit() async {
    await getDataAllSound(musicType);
    loadingUI();
    changeUI();
    super.onInit();
  }

  Future<void> getDataAllSound(musicType) async {
    listAllMusic.addAll(soundController.listMusic
        .where((element) =>
            element.tag!.contains(num.tryParse(musicType.toString())))
        .toList());

    listAllMusicResult.addAll(listAllMusic);

    updateUI();
    changeUI();
  }

  void searchListMusic({required String search}) {
    listAllMusicResult = listAllMusic
        .where((element) =>
            element.name?.toLowerCase().contains(search.toLowerCase()) ?? false)
        .toList();
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
