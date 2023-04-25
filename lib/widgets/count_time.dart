import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/count_down_timer.dart';

Widget buildTime({required Duration duration}) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    buildTimeCard(time: hours, header: 'HOURS'.tr),
    buildTimeCard(time: minutes, header: 'MINUTES'.tr),
    buildTimeCard(time: seconds, header: 'SECONDS'.tr),
  ]);
}