import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';

Widget buildTime1({required Duration duration}) {
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
}

Widget buildTimeCard(
        {required String time, required String header, bool showLine = true}) =>
    SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
              Container(
                // padding: const EdgeInsets.all(20),
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(100)),
                child: textTitleMedium(
                  text: time,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
          cHeight(12),
          textBodySmall(text: header, color: Colors.white54),
        ],
      ),
    );

Widget lineTime() {
  return Container(
    margin: const EdgeInsets.only(bottom: 4*9),
    child: textTitleLarge(text: ':',color: Colors.white54),
  );
}
