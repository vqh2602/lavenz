import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/modules/sound/sound_controller.dart';
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';
import 'package:lavenz/widgets/mixin/admod_mixin.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';
import 'package:lavenz/data/models/sound.dart' as sound;
import 'package:lavenz/data/models/tag.dart' as tag;
import 'package:lavenz/widgets/share_function/share_funciton.dart';

class AllSoundController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin, ADmodMixin {
  TextEditingController searchTE = TextEditingController();

  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();

  tag.Tag tagData = tag.Tag();
  sound.Sound soundData = sound.Sound();

  List<sound.Data> listAllMusicResult = [];
  List<sound.Data> listAllMusic = [];
  List<tag.Data> listTagMusic = [];
  List<tag.Data?> listTagMusicChoices = [];

  num? musicType;

  SoundController soundController = Get.find();

  @override
  Future<void> onInit() async {
    await initLocalData();
    loadingUI();
    changeUI();
    super.onInit();
  }

  Future initLocalData() async {
    await downloadAssetsController.init();
    try {
      String dataTag = await File(
              '${downloadAssetsController.assetsDir}/json_data/tag_${getLocalConvertString()}.json')
          .readAsString();
      tagData = tag.Tag.fromJson(jsonDecode(dataTag));
      listTagMusic = tagData.data
              ?.where((element) => num.parse(element.type.toString()) == 2)
              .toList() ??
          [];
    } catch (_) {}

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

  void searchListSoundInTag() {
    listAllMusicResult.clear();

    if (listTagMusicChoices.isEmpty) {
      listAllMusicResult.addAll(listAllMusic);
      return;
    }

    for (var item1 in listAllMusic) {
      for (var item3 in listTagMusicChoices) {
        if (item1.tag!.contains(num.tryParse((item3?.id).toString()))) {
          listAllMusicResult.add(item1);
        }
      }
    }

    listAllMusicResult = listAllMusicResult.toSet().toList();

    changeUI();
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
