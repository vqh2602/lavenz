import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lavenz/data/models/sound.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';

Widget listSound({
  required Function(String, dynamic) onTap,
  required List<Data> listData,
  required String pathBase,
}) {
  return Container(
    padding: alignment_20_0(),
    child: GridView.builder(
      padding: const EdgeInsets.only(top: 12),
      itemCount: listData.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemBuilder: (BuildContext context, int index) {
        return Tooltip(
          message: listData[index].describe,
          child: InkWell(
            onTap: () {
              onTap(listData[index].sound ?? '', listData[index]);
              //soundController.playSound();
            },
            child: Column(
              children: [
                Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.center, //
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: colorF2,
                        borderRadius: BorderRadius.circular(20)),
                    child: SvgPicture.file(
                      File('$pathBase${listData[index].image}'),
                      fit: BoxFit.scaleDown,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      // child: SvgPicture.asset(
                      //   'assets/background/noun-wind-3100898.svg',
                      //   fit: BoxFit.scaleDown,
                      //   colorFilter: const ColorFilter.mode(
                      //       Colors.white, BlendMode.srcIn),
                    )),
                cHeight(4),
                textBodySmall(
                    text: listData[index].name ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white),
              ],
            ),
          ),
        );
      },
    ),
  );
}
