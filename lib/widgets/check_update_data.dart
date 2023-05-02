import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lottie/lottie.dart';

Widget wCheckUpdateData(
    {required String dataVer,
    Function? onTap,
    required String dataNewVer,
    required String appSupport,
    bool isDown = true,
    bool isUpdate = false}) {
  return BlurryContainer(
    blur: 3,
    color: colorF3.withOpacity(0.2),
    padding: alignment_20_0(),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.center,
              child: Lottie.asset('assets/background/rocket.json',
                  height: 120, width: 120, fit: BoxFit.cover)),
          textBodyMedium(
              text: 'Phiên bản dữ liệu hiện tại: \n $dataVer',
              color: Colors.white),
          textBodyMedium(
              text: 'Phiên bản dữ liệu mới nhất: \n $dataNewVer',
              color: Colors.white),
          textBodyMedium(
              text: 'Hỗ trợ các phiên bản ứng dụng: \n $appSupport',
              color: Colors.white),
          isDown
              ? GFButton(
                  onPressed: () {
                    if(onTap!= null) onTap();
                  },
                  color: colorF3,
                  shape: GFButtonShape.pills,
                  blockButton: true,
                  size: 50,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: textTitleMedium(text: 'Cập nhật ngay'))
              : textBodyMedium(
                  text: isUpdate
                      ? 'Phiên bản ứng dụng đã quá cũ, vui lòng cập nhật ứng dụng lên phiên bản mới nhất'
                      : 'Không có bản cập nhật nào',
                  color: isUpdate ? Colors.red : Colors.white),
        ]),
  );
}
