import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/data/models/user.dart';
import 'package:lavenz/data/repositories/gift_repo.dart';
import 'package:lavenz/data/repositories/new_ver_repo.dart';
import 'package:lavenz/modules/home/home_controller.dart';
import 'package:lavenz/widgets/build_toast.dart';
import 'package:lavenz/widgets/check_update_data.dart';
import 'package:lavenz/widgets/library/down_assets/download_assets.dart';
import 'package:lavenz/widgets/mixin/user_mixin.dart';
import 'package:lavenz/widgets/share_function/share_funciton.dart';
import 'package:lavenz/widgets/text_custom.dart';
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
  GiftRepo giftRepo = GiftRepo();
  TextEditingController giftTE = TextEditingController();
  Map<String, dynamic>? dataGift;
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
    dataGift = await giftRepo.getGift();
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

  Future<void> checkShowAddGift() async {
    await showDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
        title: textBodyMedium(text: 'Gift'.tr, fontWeight: FontWeight.bold),
        content: Material(
          child: Container(
            margin: const EdgeInsets.only(top: 12),
            child: TextField(
                controller: giftTE,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                    ), //<-- SEE HERE
                  ),
                )),
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: textBodySmall(
                text: "Hủy".tr,
                color: Get.theme.colorScheme.error,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3),
            onPressed: () {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: textBodySmall(
                text: 'Xác nhận'.tr,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3),
            onPressed: () async {
              //loadingUI();
              try {
                Map<String, dynamic>? dataGiftResult;
                //     .where((e) => e['key'].toString() == giftTE.text).firstOrNull;
                // print(dataGift["data"]);
                for (var item in dataGift?["data"]) {
                  if (item["key"].toString().toUpperCase() ==
                      giftTE.text.toUpperCase()) {
                    dataGiftResult = item;
                  }
                }
                // DateTime? expiry = DateTime.fromMicrosecondsSinceEpoch(
                //     dataGiftResult?['expiry'] != null
                //         ? int.parse(dataGiftResult!['expiry'].toString())
                //         : 0);
                if (dataGiftResult != null
                    // && expiry.isBefore(DateTime.now())
                    ) {
                  user = user.copyWith(
                      identifier: '1_month',
                      latestPurchaseDate: DateTime.now());
                  saveUserInBox(user: user);
                  buildToast(
                      message: 'Đổi mã thành công'.tr,
                      status: TypeToast.toastSuccess);
                  clearAndResetApp();
                } else {
                  buildToast(
                      message: 'Mã hết hạn hoặc không đúng'.tr,
                      status: TypeToast.toastError);
                }
              } on Exception catch (_) {}
              Get.back();
              changeUI();
            },
          ),
        ],
      ),
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
