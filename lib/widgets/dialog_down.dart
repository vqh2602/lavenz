import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

Widget dialogDown({dynamic process, dynamic speed, bool isDone = false}) {
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
                  textTitleMedium(
                      text: 'Yêu cầu tải gói dữ liệu', color: Colors.white),
                  cHeight(8),
                  textBodySmall(
                      text:
                          'Ứng dụng sẽ không thể hoạt động nếu không có dữ liệu bổ sung.',
                      color: Colors.white),
                  textBodySmall(
                      text:
                          'Lưu ý: Trong quá trình tải không đóng ứng dụng, tắt màn hình...',
                      color: Colors.white),
                  isDone ? Lottie.asset('assets/animation/welldone.json') :Lottie.asset('assets/background/loadding_dowb.json'),
                  textTitleSmall(text: '$process', color: Colors.white),
                  textBodySmall(
                      text: 'Tốc độ internet: $speed', color: Colors.white),
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
                              text: 'Chọn máy chủ', color: Colors.white),
                          cHeight(12),
                          if (choise != null) ...choise,
                          cHeight(8),
                          textBodySmall(
                              text:
                                  'Nếu máy chủ mặc định bị lỗi bạn có thể chọn các máy chủ dự phòng khác',
                              color: Colors.white),
                          textBodySmall(
                              text: 'Lưu ý: Máy chủ mặc định được chọn là one',
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
                              child: textBodySmall(text: 'Xác nhận và tải'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )));
}
