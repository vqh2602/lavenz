import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lavenz/data/repositories/new_ver_repo.dart';
import 'package:lavenz/modules/home/home_controller.dart';
import 'package:lavenz/widgets/check_update_data.dart';
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  GetStorage box = GetStorage();
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  HomeController homeController = Get.find();
  bool isAssets = false;
  Map<String, dynamic> newVer = {};
  Map<String, dynamic> oldVer = {};
  NewVersionRepo newVersionRepo = NewVersionRepo();
  PackageInfo? packageInfo;
  @override
  Future<void> onInit() async {
    super.onInit();
    await init();
    await initData();
    // videoPlayerController =
    //     VideoPlayerController.asset('assets/background/vd2.mp4')
    //       ..initialize().then((_) {
    //         videoPlayerController?.play();
    //         videoPlayerController?.setLooping(true);
    //         videoPlayerController?.setVolume(0);
    //       });
    changeUI();
  }

  Future init() async {
    await downloadAssetsController.init();
    isAssets = await downloadAssetsController.assetsDirAlreadyExists();
    packageInfo = await PackageInfo.fromPlatform();
  }

  Future initData() async {
    newVer = await newVersionRepo.getNewVersion();
    String data =
        await File('${downloadAssetsController.assetsDir}/json_data/data.json')
            .readAsString();
    oldVer = jsonDecode(data);
  }

  Future<void> checkUpdateData() async {
    bool isDown = oldVer["version_data"].toString().toUpperCase() ==
        newVer["version_data"].toString().toUpperCase();
    bool isUpdate = newVer["version_app"].contains(packageInfo?.version);
    Get.bottomSheet(
      wCheckUpdateData(
          dataVer: oldVer["version_data"],
          dataNewVer: newVer["version_data"],
          appSupport: newVer["version_app"].toString(),
          onTap: () async {
            var x = await Get.defaultDialog(
                title: 'Xác nhận tải dữ liệu mới',
                textCancel: 'Huỷ',
                textConfirm: 'Xác nhận',
                onCancel: () {
                  Get.back(result: false);
                },
                onConfirm: () {
                  Get.back(result: true);
                });
            if (x != null && x) {
              await homeController.clearDown();
              await homeController.initDown();
            }
          },
          isDown: !isDown,
          isUpdate: isUpdate),
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
