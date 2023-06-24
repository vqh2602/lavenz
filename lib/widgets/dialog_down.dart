import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';

Widget dialogDown(
    {dynamic process,
    dynamic speed,
    String? size,
    required Function reloadDown,
    bool isDone = false}) {
  return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      //title: textBodyLarge(text: "Yêu cầu tải gói dữ liệu", fontWeight: FontWeight.w700),
      content: Material(
        child: BlurryContainer(
          blur: 5,
          color: colorF2.withOpacity(0.3),
          child: Container(
            width: Get.width * 0.8,
            height: Get.height * 0.6,
            padding: alignment_20_0(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  cHeight(12),
                  Wrap(
                    spacing: 4,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      textTitleMedium(
                          text: 'Yêu cầu tải gói dữ liệu'.tr + (' - $size'),
                          color: Colors.white),
                      IconButton(
                          onPressed: () async {
                            await reloadDown();
                          },
                          icon: const Icon(
                            LucideIcons.refreshCw,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  cHeight(8),
                  textBodySmall(
                      text:
                          'Ứng dụng sẽ không thể hoạt động nếu không có dữ liệu bổ sung.'
                              .tr,
                      color: Colors.white),
                  textBodySmall(
                      text:
                          'Lưu ý: Trong quá trình tải không đóng ứng dụng, tắt màn hình...'
                              .tr,
                      color: Colors.white),
                  SizedBox(
                    height: Get.height * 0.2,
                    child: isDone
                        ? Lottie.asset('assets/animation/welldone.json')
                        : Lottie.asset('assets/background/loadding_dowb.json'),
                  ),
                  textTitleSmall(text: '$process', color: Colors.white),
                  textBodySmall(
                      text: 'Tốc độ internet:'.trParams({'speed': speed}),
                      color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ));
}

Widget dialogChoseSever({List<Widget>? choise}) {
  return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      //title: textBodyLarge(text: "Yêu cầu tải gói dữ liệu", fontWeight: FontWeight.w700),
      content: StatefulBuilder(
          builder: (context, setState) => Material(
                child: BlurryContainer(
                  blur: 5,
                  color: colorF2.withOpacity(0.3),
                  child: Container(
                    width: Get.width * 0.7,
                    height: Get.height * 0.5,
                    padding: alignment_20_0(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          cHeight(12),
                          textTitleMedium(
                              text: 'Chọn máy chủ'.tr, color: Colors.white),
                          cHeight(12),
                          if (choise != null) ...choise,
                          cHeight(8),
                          textBodySmall(
                              text:
                                  'Nếu máy chủ mặc định bị lỗi bạn có thể chọn các máy chủ dự phòng khác'
                                      .tr,
                              color: Colors.white),
                          textBodySmall(
                              text:
                                  'Lưu ý: Máy chủ mặc định được chọn là one'.tr,
                              color: Colors.white),
                          cHeight(12),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GFButton(
                              onPressed: () {
                                Get.back();
                              },
                              shape: GFButtonShape.pills,
                              color: Colors.white,
                              child: textBodySmall(text: 'Xác nhận và tải'.tr),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )));
}
