import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/data/repositories/new_ver_repo.dart';
import 'package:lavenz/modules/home/home_controller.dart';
import 'package:lavenz/widgets/check_update_data.dart';
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';
import 'package:lavenz/widgets/share_function/share_funciton.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingController extends GetxController
    with GetTickerProviderStateMixin, StateMixin, UserMixin {
  DownloadAssetsController downloadAssetsController =
      DownloadAssetsController();
  HomeController homeController = Get.find();
  bool isAssets = false;
  Map<String, dynamic> newVer = {};
  Map<String, dynamic> oldVer = {};
  NewVersionRepo newVersionRepo = NewVersionRepo();
  PackageInfo? packageInfo;
  User user = User();
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
    user = getUserInBox();
    newVer = await newVersionRepo.getNewVersion();
    try {
      String data = await File(
              '${downloadAssetsController.assetsDir}/json_data/data_${getLocalConvertString()}.json')
          .readAsString();
      oldVer = jsonDecode(data);
    } on Exception catch (_) {}
  }

  String? getTitileVip() {
    if (user.identifier == '1_month') return '1 tháng'.tr;
    if (user.identifier == '1_year') return '1 năm'.tr;
    return null;
  }

  String? getTimeVip() {
    if (user.latestPurchaseDate == null) return null;
    return daysBetween(
      from: DateTime.now(),
      to: user.identifier == '1_month'
          ? user.latestPurchaseDate!.add(const Duration(days: 30))
          : user.latestPurchaseDate!.add(const Duration(days: 365)),
    ).toString();
  }

  Future logout() async {
    await clearDataUser();
    await clearAndResetApp();
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
            onPopDialog(
                context: Get.context!,
                onCancel: () {
                  Get.back(result: false);
                },
                onSubmit: () async {
                  Get.back();
                  await homeController.clearDown();
                  await homeController.initDown();
                },
                title: 'Xác nhận tải gói dữ liệu mới'.tr);
          },
          isDown: !isDown,
          isUpdate: !isUpdate),
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
