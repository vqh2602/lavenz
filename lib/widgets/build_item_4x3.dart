import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/modules/vip/vip_screen.dart';
import 'package:lavenz/widgets/text_custom.dart';

Widget buildItem4x3() {
  return SizedBox(
      height: 200,
      child: InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(right: 12),
          child: BlurryContainer(
            padding: EdgeInsets.zero,
            blur: 2,
            child: Tooltip(
              message: 'Mua hàng một cách nhanh chóng, đăng kí ngay',
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/background/img1.jpg',
                      fit: BoxFit.cover,
                      height: 200.0,
                      width: double.infinity,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 20, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textTitleSmall(
                              text: 'Mở khoá tất cả tính năng',
                              color: Colors.white,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          textBodySmall(
                              text:
                                  'Nhận quyền truy cập không giới hạn vào các chức năng của ứng dụng',
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
                          Get.toNamed(VipScreen.routeName);
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                        padding:
                            const EdgeInsets.only(left: 4 * 10, right: 4 * 10),
                        text: "Đăng kí ngay",
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
