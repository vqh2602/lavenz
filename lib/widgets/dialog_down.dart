import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

Widget dialogDown({dynamic process}) {
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
            width: Get.width * 0.7,
            height: Get.height * 0.6,
            padding: alignment_20_0(),
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
                Lottie.asset('assets/background/loadding_dowb.json'),
                textTitleSmall(
                    text:'$process',
                    color: Colors.white),
              ],
            ),
          ),
        ),
      ));
}
