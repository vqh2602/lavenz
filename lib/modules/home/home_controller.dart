import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';

class HomeController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  int selectItemScreen = 0;
  PageController pageController = PageController();
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  String message = 'Press the download button to start the download';
  bool downloaded = false;

  @override
  Future<void> onInit() async {
    changeUI();
    // await _init();
    //await _downloadAssets();
    super.onInit();
  }

  // Future _init() async {
  //   await downloadAssetsController.init();
  //   downloaded = await downloadAssetsController.assetsDirAlreadyExists();
  // }
  //
  // Future _refresh() async {
  //   await downloadAssetsController.clearAssets();
  //   await _downloadAssets();
  // }

  // Future _downloadAssets() async {
  //   final assetsDownloaded =
  //       await downloadAssetsController.assetsDirAlreadyExists();
  //
  //   if (assetsDownloaded) {
  //     message = 'Click in refresh button to force download';
  //     print(message);
  //     return;
  //   }

  //   try {
  //     await downloadAssetsController.startDownload(
  //         assetsUrl:
  //             'https://vqh2602.github.io/lavenz_music_data.github.io/release/data.zip',
  //         onProgress: (progressValue) {
  //           downloaded = false;
  //           if (progressValue < 100) {
  //             message = 'Downloading - ${progressValue.toStringAsFixed(2)}';
  //             print(message);
  //           } else {
  //             message =
  //                 'Download completed\nClick in refresh button to force download';
  //             print(message);
  //             downloaded = true;
  //           }
  //         });
  //   } on DownloadAssetsException catch (e) {
  //     print(e.toString());
  //     downloaded = false;
  //     message = 'Error: ${e.toString()}';
  //   }
  // }

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
