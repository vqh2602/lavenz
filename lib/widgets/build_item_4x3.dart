import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/widgets/text_custom.dart';

Widget buildItem4x3(
    {required Function onTap,
    required String title,
    required String des,
    required String image,
    required String textButton}) {
  return SizedBox(
      height: 200,
      // width: double.infinity,
      child: InkWell(
        onTap: () {
          // onTap();
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(right: 12),
          child: BlurryContainer(
            padding: EdgeInsets.zero,
            blur: 2,
            child: Tooltip(
              message: 'Mua hàng một cách nhanh chóng, đăng kí ngay'.tr,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      height: 200.0,
                      width: double.infinity,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          textTitleSmall(
                              text: title,
                              color: Colors.white,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis),
                          textBodySmall(
                              text: des,
                              color: Colors.white,
                              maxLines: 2,
                              fontWeight: FontWeight.w100,
                              overflow: TextOverflow.ellipsis)
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GFButton(
                        onPressed: () {
                          onTap();
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                        padding:
                            const EdgeInsets.only(left: 4 * 10, right: 4 * 10),
                        text: textButton,
                        textStyle: josefinSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        shape: GFButtonShape.pills),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
}
