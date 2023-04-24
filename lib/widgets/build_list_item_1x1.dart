import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';

Widget buildListItem1x1() {
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
                text: 'Âm thanh thiên nhiên',
                color: Colors.white,
              ),
              GFButton(
                onPressed: () {},
                shape: GFButtonShape.pills,
                color: Colors.transparent,
                child: textBodySmall(
                    text: 'Tất cả >',
                    color: Colors.white,
                    fontWeight: FontWeight.w100),
              )
            ],
          ),
        ),
        cHeight(4),
        Expanded(
          child: ListView.builder(
              itemCount: 15,
              shrinkWrap: false,
              primary: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: 150,
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
                                height: 150.0,
                                width: 150.0,
                              ),
                            ),
                            cHeight(4),
                            textTitleSmall(
                                text: 'Những ngày mưa SSSSSSS',
                                color: Colors.white),
                            textBodySmall(
                                text:
                                'Các hiệu ứng âm thanh về chủ đề thời tiết, thư giãn và dễ chịu',
                                color: Colors.white,
                                maxLines: 3,
                                fontWeight: FontWeight.w100,
                                overflow: TextOverflow.ellipsis)
                          ],
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