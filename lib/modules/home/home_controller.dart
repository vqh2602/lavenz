import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/dialog_down.dart';
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';

class HomeController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  int selectItemScreen = 0;
  PageController pageController = PageController();
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  String message = 'Đang kết nối đến máy chủ'.tr;
  bool downloaded = false;

  @override
  Future<void> onInit() async {
    changeUI();
    // await _downloadAssets();
    super.onInit();
  }

  Future init() async {
    await downloadAssetsController.init();
    downloaded = await downloadAssetsController.assetsDirAlreadyExists();
    // if(downloaded){
    //   await downloadAssetsController.clearAssets();
    // }
    if (!downloaded) {
      //print('show down');
      Get.dialog(obx((state) => dialogDown(process: message)),
        barrierDismissible: false,);
      _downloadAssets();
    }
  }

  // Future _refresh() async {
  //   await downloadAssetsController.clearAssets();
  //   await _downloadAssets();
  // }

  Future _downloadAssets() async {
    final assetsDownloaded =
        await downloadAssetsController.assetsDirAlreadyExists();

    if (assetsDownloaded) {
      message = 'tải';
      //print(message);
      return;
    }

    try {
      await downloadAssetsController.startDownload(
          assetsUrl:
              'https://vqh2602.github.io/lavenz_music_data.github.io/release/data.zip',
          onProgress: (progressValue) {
            downloaded = false;
            if (progressValue < 100) {
              message = 'Đang tải - ${progressValue.toStringAsFixed(2)} %';
              updateUI();
             // print(message);
            } else {
              message =
                  'Tải xuống thành công';
              downloaded = true;
              Get.back();
            }
          });
    } on DownloadAssetsException catch (e) {
      //print(e.toString());
      downloaded = false;
      message = 'Error: ${e.toString()}';
    }
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
