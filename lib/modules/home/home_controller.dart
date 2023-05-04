import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:get/get.dart';
import 'package:lavenz/data/models/down.dart' as down;
import 'package:lavenz/data/repositories/new_ver_repo.dart';
import 'package:lavenz/widgets/build_toast.dart';
import 'package:lavenz/widgets/dialog_down.dart';
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';
import 'package:lavenz/widgets/text_custom.dart';

class HomeController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  int selectItemScreen = 0;
  PageController pageController = PageController();
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  String message = 'Đang kết nối đến máy chủ'.tr;
  String speedInternet = '0';
  bool downloaded = false;
  final speedTest = FlutterInternetSpeedTest();
  down.Down downLink = down.Down();
  NewVersionRepo newVersionRepo = NewVersionRepo();
  List<Widget> choiseSever = [];
  down.Link? linkSelect;

  @override
  Future<void> onInit() async {
    changeUI();
    // await _downloadAssets();
    initData();
    super.onInit();
  }

  @override
  void dispose() {
    speedTest.disableLog();
    super.dispose();
  }

  Future init() async {
    await downloadAssetsController.init();
    await initDown();
  }

  Future initData() async {
    loadingUI();
    downLink = down.Down.fromJson(await newVersionRepo.getNewVersion());
    choiseSever.addAll(downLink.link
            ?.map((e) => obx(
                  (state) => FilterChip(
                    onSelected: (b) {
                      linkSelect = e;
                      updateUI();
                    },
                    label: textBodySmall(text: e.name ?? ''),
                    selected: e.name == linkSelect?.name,
                  ),
                ))
            .toList() ??
        []);
    linkSelect = downLink.link?.first;
    changeUI();
  }

  Future initDown() async {
    downloaded = await downloadAssetsController.assetsDirAlreadyExists();
    var checkAllFile =
        await File('${downloadAssetsController.assetsDir}/svg_icons/river.svg')
            .exists();
    log('check down: $downloaded | $checkAllFile | ${downloadAssetsController.assetsDir}');

    // if(downloaded){
    //   await downloadAssetsController.clearAssets();
    // }
    if (!downloaded || !checkAllFile) {
      //print('show down');
      await Get.dialog(
        obx((state) => dialogChoseSever(choise: choiseSever)),
        barrierDismissible: true,
      );
      Get.dialog(
        obx((state) => dialogDown(process: message, speed: speedInternet)),
        barrierDismissible: false,
      );
      _downloadAssets();
    }
  }

  // Future _refresh() async {
  //   await downloadAssetsController.clearAssets();
  //   await _downloadAssets();
  // }

  Future clearDown() async {
    //message = 'tải';
    await downloadAssetsController.clearAssets();
    //print(message);
    // return;
  }

  Future _downloadAssets() async {
    final assetsDownloaded =
        await downloadAssetsController.assetsDirAlreadyExists();

    if (assetsDownloaded) {
      //message = 'tải';
      await downloadAssetsController.clearAssets();
      //print(message);
      // return;
    }

    try {
      testInternetSpeed();
      await downloadAssetsController.startDownload(
          assetsUrl: linkSelect?.url ?? '',
          onProgress: (progressValue) {
            downloaded = false;
            if (progressValue < 100) {
              message = 'Đang tải - ${progressValue.toStringAsFixed(2)} %';
              updateUI();
              // print(message);
            } else {
              message =
                  'Tải xuống thành công\n Đóng và khởi động lại ứng dụng để cập nhật dữ liệu mới';
              downloaded = true;
              //Get.back();
            }
          });
    } on DownloadAssetsException catch (e) {
      //print(e.toString());
      downloaded = false;
      buildToast(message: 'Lỗi tải xuống', status: TypeToast.toastError);
      message = 'Error: ${e.toString()}';
    }
  }

  void testInternetSpeed() {
    speedTest.startTesting(
      useFastApi: false, //true(default)
      downloadTestServer:
          'https://vqh2602.github.io/lavenz_music_data.github.io', //Your download test server URL goes here,//Your upload test server URL goes here,//File size to be tested
      onStarted: () {},
      onCompleted: (TestResult download, TestResult upload) {},
      onProgress: (double percent, TestResult data) {
        speedInternet =
            '${data.transferRate} ${data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps'}';
      },
      onError: (String errorMessage, String speedTestError) {},
      onDefaultServerSelectionInProgress: () {
        //Only when you use useFastApi parameter as true(default)
      },
      onDefaultServerSelectionDone: (Client? client) {
        ///Only when you use useFastApi parameter as true(default)
      },
      onDownloadComplete: (TestResult data) {},
      onUploadComplete: (TestResult data) {},
      onCancel: () {},
    );
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
