import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void showBlockDetail({required Widget widget}) {
  Get.bottomSheet(
      Container(
        height: Get.height * 0.9,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12), bottom: Radius.circular(0)),
          color: Get.theme.scaffoldBackgroundColor,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: widget,
      ),
      isScrollControlled: true);
}
