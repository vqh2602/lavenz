import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lavenz/data/models/sound.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';

Widget listSound({
  required Function(String, dynamic) onTap,
  required Function(num?) onTapPlaying,
  required List<Data> listData,
  required List<Data> listSelect,
  required String pathBase,
}) {
  return Container(
    padding: alignment_20_0(),
    child: GridView.builder(
      padding: const EdgeInsets.only(top: 12),
      itemCount: listData.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 4,
        childAspectRatio: Get.width / (Get.height / 2),
      ),
      itemBuilder: (BuildContext context, int index) {
        bool isPlaying = listSelect.contains(listData[index]);
        return Tooltip(
          message: listData[index].describe,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            splashColor: colorF2.withOpacity(0.3),
            onTap: () {
              !isPlaying
                  ? onTap(listData[index].sound ?? '', listData[index])
                  : onTapPlaying(listData[index].id);
              //soundController.playSound();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: 70,
                      height: 70,
                      alignment: Alignment.center, //
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: isPlaying ? Colors.white : colorF2,
                          boxShadow: [
                            isPlaying
                                ? BoxShadow(
                                    color: colorF4,
                                    spreadRadius: 4,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        0, 0), // changes position of shadow
                                  )
                                : const BoxShadow(),
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: SvgPicture.file(
                          File('$pathBase${listData[index].image}'),
                          fit: BoxFit.scaleDown,
                          colorFilter: !isPlaying
                              ? const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn)
                              : ColorFilter.mode(colorF2, BlendMode.srcIn),
                          // child: SvgPicture.asset(
                          //   'assets/background/noun-wind-3100898.svg',
                          //   fit: BoxFit.scaleDown,
                          //   colorFilter: const ColorFilter.mode(
                          //       Colors.white, BlendMode.srcIn),
                        ),
                      )),
                  cHeight(4),
                  textBodySmall(
                      text:
                          '${listData[index].vip ?? false ? '♔ ' : ''}${listData[index].name ?? ''}',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
