import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';

Widget buildListItem4x3() {
  return SizedBox(
    height: 230,
    child: ListView.builder(
        itemCount: listDataDash.length,
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
                      listDataDash[i].des,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                         listDataDash[i].image,
                          fit: BoxFit.cover,
                          height: 130.0,
                          width: 220.0,
                        ),
                      ),
                      cHeight(4),
                      textTitleSmall(
                          text:
                              listDataDash[i].title,
                          color: Colors.white),
                      textBodySmall(
                          text:
                              listDataDash[i].des,
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

List<DataDash> listDataDash = [
  DataDash(
      title: 'Hiệu ứng âm thanh'.tr,
      des: 'Các hiệu ứng âm thanh về các chủ đề khác nhau'.tr,
      image: 'assets/background/d1.jpeg',
      onTap: (){}),
        DataDash(
      title: 'Âm nhạc của cảm xúc'.tr,
      des: 'Các bản nhạc thư giãn, tập trung ... cũng có thể là những bản nhạc giải toả tâm trạng'.tr,
      image: 'assets/background/d2.jpeg',
      onTap: (){}),
              DataDash(
      title: 'Bộ sưu tập'.tr,
      des: 'Muốn thêm...? Điều chỉnh nhịp thở, giảm căng thẳng, thiền định...'.tr,
      image: 'assets/background/d3.jpeg',
      onTap: (){}),
];

class DataDash {
  String title;
  String des;
  String image;
  Function onTap;
  DataDash({
    required this.title,
    required this.des,
    required this.image,
    required this.onTap,
  });
}
