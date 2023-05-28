import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lavenz/modules/tools/breath/breath_screen.dart';
import 'package:lavenz/modules/tools/horoscope/horoscope_screen.dart';
import 'package:lavenz/modules/tools/meditation/meditation_screen.dart';
import 'package:lavenz/modules/tools/quote/quote_screen.dart';
import 'package:lavenz/modules/tools/tools_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({Key? key}) : super(key: key);
  static const String routeName = '/tools';

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  ToolsController toolsController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return toolsController.obx((state) => Stack(
          children: <Widget>[
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background/bg3.jpeg'),
                      fit: BoxFit.fill)),
            ),
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background/bg.png'),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
                height: Get.height,
                width: Get.width,
                child: ListView.builder(
                    itemCount: listData.length,
                    itemBuilder: (context, i) => InkWell(
                          onTap: () {
                            listData[i].onTap();
                          },
                          child: Hero(
                            tag: 'tools$i',
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              width: Get.width,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(listData[i].image),
                                      fit: BoxFit.cover)),
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/background/bg.png'),
                                            fit: BoxFit.fill)),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Material(
                                            child: textTitleLarge(
                                                text: listData[i].title,
                                                color: Colors.white),
                                          ),
                                          cHeight(8),
                                          Material(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 4,right: 4),
                                              child: textBodySmall(
                                                  text: listData[i].des,
                                                  textAlign: TextAlign.center,
                                                  color: Colors.white60),
                                            ),
                                          )
                                        ]),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: alignment_20_8(),
                                      child: Material(
                                        child: textBodySmall(
                                            text: listData[i].isVip
                                                ? 'Preium'.tr
                                                : 'Free'.tr,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))),
          ],
        ));
  }

  List<ToolsItem> listData = [
    ToolsItem(
        image: 'assets/background/t1.jpeg',
        onTap: () {
          Get.toNamed(BreathScreen.routeName);
        },
        title: 'Thở'.tr,
        des: 'điểu chỉnh nhịp thở'.tr,
        isVip: true),
    ToolsItem(
        image: 'assets/background/t2.jpeg',
        onTap: () {
          Get.toNamed(MeditationScreen.routeName);
        },
        title: 'Thiền định'.tr,
        des: 'thiền định hẹn giờ và đếm thời gian'.tr,
        isVip: true),
        ToolsItem(
        image: 'assets/background/t3.jpeg',
        onTap: () {
          Get.toNamed(HoroscopeScreen.routeName);
        },
        title: 'Lá số tử vi'.tr,
        des: 'thông tin chiêm tinh về cung hoàng đạo được làm mới mỗi ngày'.tr,
        isVip: true),
        ToolsItem(
        image: 'assets/background/t4.jpeg',
        onTap: () {
          Get.toNamed(QuoteScreen.routeName);
        },
        title: 'Châm ngôn'.tr,
        des: 'Những câu châm ngôn mỗi ngày'.tr,
        isVip: true),
  ];
}

class ToolsItem {
  String image;
  String? url;
  Function onTap;
  String title;
  String des;
  bool isVip;
  ToolsItem({
    required this.image,
    this.url,
    required this.onTap,
    required this.title,
    required this.des,
    required this.isVip,
  });
  ToolsItem copyWith({
    String? image,
    String? url,
    Function? onTap,
    String? title,
    String? des,
    bool? isVip,
  }) {
    return ToolsItem(
      image: image ?? this.image,
      url: url ?? this.url,
      onTap: onTap ?? this.onTap,
      title: title ?? this.title,
      des: des ?? this.des,
      isVip: isVip ?? this.isVip,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ToolsItem &&
        other.image == image &&
        other.url == url &&
        other.onTap == onTap &&
        other.title == title &&
        other.des == des &&
        other.isVip == isVip;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        url.hashCode ^
        onTap.hashCode ^
        title.hashCode ^
        des.hashCode ^
        isVip.hashCode;
  }
}
