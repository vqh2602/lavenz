import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/count_down_timer.dart';
import 'package:lavenz/widgets/widgets.dart';

Widget buildTime({required Duration duration}) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'HOURS'.tr),
        cWidth(4),
        lineTime(),
        cWidth(4),
        buildTimeCard(time: minutes, header: 'MINUTES'.tr),
        cWidth(4),
        lineTime(),
        cWidth(4),
        buildTimeCard(time: seconds, header: 'SECONDS'.tr, showLine: false),
      ]);
  // return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //   buildTimeCard(time: hours, header: 'HOURS'.tr),
  //   buildTimeCard(time: minutes, header: 'MINUTES'.tr),
  //   buildTimeCard(time: seconds, header: 'SECONDS'.tr),
  // ]);
}
