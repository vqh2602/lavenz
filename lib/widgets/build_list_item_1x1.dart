import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/data/models/sound.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';

Widget buildListItem1x1(
    {required String title,
    required Function(String, dynamic) onTap,
    required List<Data> listData,
    required String pathImages}) {
  return SizedBox(
    height: 330,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textTitleMedium(
                text: title,
                color: Colors.white,
              ),
              GFButton(
                onPressed: () {},
                shape: GFButtonShape.pills,
                color: Colors.transparent,
                child: textBodySmall(
                    text: 'Tất cả >'.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.w100),
              )
            ],
          ),
        ),
        cHeight(4),
        Expanded(
          child: ListView.builder(
              itemCount: listData.length > 10 ? 10 : listData.length,
              shrinkWrap: false,
              primary: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Material(
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      onTap: () {
                        onTap(listData[i].sound ?? '', listData[i]);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: 150,
                        child: BlurryContainer(
                          padding: EdgeInsets.zero,
                          blur: 2,
                          child: Tooltip(
                            message: listData[i].describe ?? '',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.file(
                                    File('$pathImages${listData[i].image}'),
                                    errorBuilder:
                                        (context, object, stackTrace) {
                                      return SizedBox(
                                        height: double.infinity,
                                        child: Image.asset(
                                          'assets/images/image_notfound.jpg',
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    height: 150.0,
                                    width: 150.0,
                                  ),
                                ),
                                cHeight(4),
                                textTitleSmall(
                                    text: listData[i].name ?? '',
                                    color: Colors.white),
                                textBodySmall(
                                    text: listData[i].describe ?? '',
                                    color: Colors.white,
                                    maxLines: 3,
                                    fontWeight: FontWeight.w100,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    ),
  );
}
