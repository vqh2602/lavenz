import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';

Widget buildListItem4x3() {
  return SizedBox(
    height: 230,
    child: ListView.builder(
        itemCount: 15,
        shrinkWrap: false,
        primary: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {},
            child: Container(
              width: 220,
              margin: const EdgeInsets.only(right: 12),
              child: BlurryContainer(
                padding: EdgeInsets.zero,
                blur: 2,
                child: Tooltip(
                  message:
                  'Các hiệu ứng âm thanh về chủ đề thời tiết, thư giãn và dễ chịu',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          'assets/background/img1.jpg',
                          fit: BoxFit.cover,
                          height: 130.0,
                          width: 220.0,
                        ),
                      ),
                      cHeight(4),
                      textTitleSmall(
                          text:
                          'Những ngày mưa ${(i % 2 == 0 ? '' : ' mauw mua wmuaw ')}',
                          color: Colors.white),
                      textBodySmall(
                          text:
                          'Các hiệu ứng âm thanh về chủ đề thời tiết, thư giãn và dễ chịu',
                          color: Colors.white,
                          maxLines: 2,
                          fontWeight: FontWeight.w100,
                          overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
  );
}