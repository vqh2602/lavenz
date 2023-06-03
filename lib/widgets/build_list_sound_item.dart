import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/data/models/sound.dart';
import 'package:lavenz/modules/sound/sound_controller.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';

SoundController soundController = Get.find();

Widget buildListSoundItem({
  required int index,
  required List<Data> listData,
}) {
  return InkWell(
    onTap: () {
      soundController.onPlayMusic(
        listData[index].sound ?? '',
        listData[index],
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4 * 6,
        vertical: 4 * 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.file(
              File(
                  '${soundController.downloadAssetsController.assetsDir}/images/${listData[index].image}'),
              errorBuilder: (context, object, stackTrace) {
                return SizedBox(
                  height: double.infinity,
                  child: Image.asset(
                    'assets/images/image_notfound.jpg',
                    fit: BoxFit.fill,
                  ),
                );
              },
              fit: BoxFit.cover,
              height: 75.0,
              width: 75.0,
            ),
          ),
          cWidth(4 * 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cHeight(4),
                textTitleSmall(
                    text: listData[index].name ?? '', color: Colors.white),
                textBodySmall(
                  text: listData[index].describe ?? '',
                  color: Colors.white,
                  maxLines: 3,
                  fontWeight: FontWeight.w100,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
