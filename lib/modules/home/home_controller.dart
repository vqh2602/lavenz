import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:get/get.dart';
import 'package:lavenz/data/models/down.dart' as down;
import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/data/repositories/new_ver_repo.dart';
import 'package:lavenz/data/storage.dart';
import 'package:lavenz/modules/vip/vip_controller.dart';
import 'package:lavenz/widgets/build_toast.dart';
import 'package:lavenz/widgets/dialog_down.dart';
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';
import 'package:lavenz/widgets/mixin/admod_mixin.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';
import 'package:lavenz/widgets/share_function/share_funciton.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin, ADmodMixin {
  VipController vipController = Get.find();
  int selectItemScreen = 0;
  PageController pageController = PageController(
    viewportFraction: 1.0,
  );
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
  PackageInfo? packageInfo;
  StreamSubscription<ConnectivityResult>? connectivityResul;
  User user = User();
  Map<String, dynamic> oldVer = {};
  Timer? timer;

  @override
  Future<void> onInit() async {
    changeUI();
    // await _downloadAssets();
    initData();
    initConnectInternet();
    initInterstitialAd();
    super.onInit();
  }

  @override
  void dispose() {
    speedTest.disableLog();
    connectivityResul?.cancel();
    super.dispose();
  }

  Future init() async {
    await downloadAssetsController.init();
    await initDown();
  }

  Future<void> initInterstitialAd() async {
    if (!checkExpiry(user: user)) {
      timer = Timer.periodic(
          const Duration(minutes: 5),
          (_) async =>
              {await createInitInterstitialAd(), interstitialAd?.show()});
    }
  }

  Future initData() async {
    loadingUI();
    user = getUserInBox();
    packageInfo = await PackageInfo.fromPlatform();
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

  void initConnectInternet() {
    connectivityResul = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        // buildToast(
        // message: 'Đã kết nối mạng di động', status: TypeToast.toastSuccess);
      } else if (result == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        // I am connected to a mobile network.
        // buildToast(message: 'Đã kết nối wifi', status: TypeToast.toastSuccess);
      } else if (result == ConnectivityResult.ethernet) {
        // I am connected to a mobile network.
        //      message: 'Đã kết nối ethernet', status: TypeToast.toastSuccess);
        // I am connected to a ethernet network.
      } else if (result == ConnectivityResult.vpn) {
        // I am connected to a mobile network.
        //buildToast(message: 'Đã kết nối vpn', status: TypeToast.toastSuccess);
        // I am connected to a vpn network.
        // Note for iOS and macOS:
        // There is no separate network interface type for [vpn].
        // It returns [other] on any device (also simulator)
      } else if (result == ConnectivityResult.bluetooth) {
        // I am connected to a bluetooth.
        // I am connected to a mobile network.
        // buildToast(
        //     message: 'Đã kết nối chia sẻ bluetooth',
        //     status: TypeToast.toastSuccess);
      } else if (result == ConnectivityResult.other) {
        // I am connected to a network which is not in the above mentioned networks.
        // I am connected to a mobile network.
        //  buildToast(
        //     message: 'Đã kết nối',
        //     status: TypeToast.toastSuccess);
      } else if (result == ConnectivityResult.none) {
        // I am not connected to any network.
        buildToast(
          message: 'Không có kết nối'.tr,
          status: TypeToast.toastError,
        );
      }
    });
  }

  Future initDown() async {
    downloaded = await downloadAssetsController.assetsDirAlreadyExists();
    var checkAllFile =
        await File('${downloadAssetsController.assetsDir}/svg_icons/river.svg')
            .exists();
    log('check down: $downloaded | $checkAllFile | ${downloadAssetsController.assetsDir}');
    log('check user vip: ${checkExpiry(user: user)} | ${user.toJson()}');
    renewSubscriptions(checkExpiry(user: user));
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
        obx((state) => dialogDown(
            process: message,
            speed: speedInternet,
            size: downLink.size,
            reloadDown: () async {
              onPopDialog(
                  context: Get.context!,
                  title: "Khởi động lại quá trình tải?".tr,
                  onCancel: () async {
                    Get.back();
                  },
                  onSubmit: () async {
                    Get.close(2);
                    await downloadAssetsController.clearAssets();
                    clearAndResetApp();
                  });
            },
            isDone: downloaded)),
        barrierDismissible: false,
      );
      _downloadAssets();
    }
    // kiểm tra xem dữ liệu tải về còn dùng đc ho phiên bản mơi shay k

    try {
      String data = await File(
              '${downloadAssetsController.assetsDir}/json_data/data_${getLocalConvertString()}.json')
          .readAsString();
      oldVer = jsonDecode(data);
      bool isUpdate = oldVer["version_app"].contains(packageInfo?.version);
      if (!isUpdate) {
        clearDown();
        initDown();
      }
    } catch (_) {}
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
              message = "Đang tải".trParams(
                  {'process': '${progressValue.toStringAsFixed(2)} %'});
              updateUI();
              // print(message);
            } else {
              message =
                  'Tải xuống thành công\nĐóng và khởi động lại ứng dụng để cập nhật dữ liệu mới'
                      .tr;
              downloaded = true;
              //Get.back();
              Future.delayed(const Duration(seconds: 2), () {
                clearAndResetApp();
              });
            }
          });
    } on DownloadAssetsException catch (e) {
      //print(e.toString());
      downloaded = false;
      buildToast(message: 'Lỗi tải xuống'.tr, status: TypeToast.toastError);
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

// tự động làm mới
  Future<void> renewSubscriptions(bool isVip) async {
    bool isRenew = await box.read(Storages.dataRenewSub);
    if (!isVip && isRenew) {
      vipController.restorePucharses();
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
