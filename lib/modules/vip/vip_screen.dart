
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/modules/vip/vip_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/button_custom.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/loading_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:rive/rive.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});
  static const String routeName = '/vip';

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  VipController vipController = Get.find();
  @override
  void initState() {
    vipController.onInit();
    // _controller.isActiveChanged.addListener(_activeChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: Container(child: _buildBody()),
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            LucideIcons.x,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return vipController.obx(
        (state) => Stack(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background/bg_full.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.42,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                child: RiveAnimation.asset(
                                  'assets/background/lake-on-a-rainy-day.riv',
                                  fit: BoxFit.cover,
                                  controllers: [vipController.controller],

                                  //controllers: [_controller],
                                )
                                // Image.asset(
                                //   'assets/background/img1.jpg',
                                //   fit: BoxFit.cover,
                                //   height: Get.height * 0.42,
                                //   width: double.infinity,
                                // ),
                                ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: _buildListSubscription())
                          ],
                        ),
                      ),
                      cHeight(20),
                      Expanded(
                        child: Padding(
                          padding: alignment_20_0(),
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              },
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textHeadlineLarge(
                                    text: 'Unlock Lavenz'.tr,
                                    color: Get.theme.colorScheme.background,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  cHeight(20),
                                  for (var x in vipController.vipOffer) ...[
                                    vipOfferItem(
                                      text: x,
                                    ),
                                  ],
                                  // ListView.builder(
                                  //   padding: EdgeInsets.zero,
                                  //   shrinkWrap: true,
                                  //   primary: true,
                                  //   itemCount: vipOffer.length,
                                  //   itemBuilder: (context, index) => vipOfferItem(
                                  //     text: vipOffer[index],
                                  //   ),
                                  // ),
                                  // Align(
                                  //   alignment: Alignment.bottomRight,
                                  //   child: IconButton(
                                  //       onPressed: () {
                                  //         vipController.restorePucharses();
                                  //       },
                                  //       icon: textBodySmall(
                                  //           text: 'Khôi phục mua hàng',
                                  //           color: Colors.white70,
                                  //           textAlign: TextAlign.right)),
                                  // )
                                  // //         _buildRestoreButton(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Wrap(
                      children: [
                         Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                        onPressed: () {
                                          vipController.restorePucharses();
                                        },
                                        icon: textBodySmall(
                                            text: 'Khôi phục mua hàng'.tr,
                                            color: Colors.white70,
                                            textAlign: TextAlign.right)),
                                  )
                                ,
                        buttonCustom(
                          title: 'Đăng ký'.tr,
                          onTap: () {
                            vipController.buyApp();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        onLoading: const LoadingCustom());
  }

  Widget vipOfferItem({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4 * 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.checkCircle2,
            color: Get.theme.colorScheme.background,
            size: 28.0,
          ),
          cWidth(8),
          textBodySmall(
            text: text,
            color: Get.theme.colorScheme.background,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
    );
  }

  Widget _buildListSubscription() {
    return Container(
        padding: const EdgeInsets.all(4.0),
        height: 200,
        alignment: Alignment.center,
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemCount: vipController.listProduct.length,
            itemBuilder: (context, index) {
              bool isSelect = vipController.storeProductSelect?.identifier ==
                  vipController.listProduct[index].identifier;
              return InkWell(
                onTap: () {
                  vipController.storeProductSelect =
                      vipController.listProduct[index];
                  vipController.addStringDes();
                  vipController.updateUI();
                },
                child: Container(
                  width: 200,
                  height: 100,
                  margin: const EdgeInsets.only(
                    left: 12,
                    top: 30,
                    bottom: 30,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 3,
                          color: isSelect ? Colors.white : Colors.transparent),
                      borderRadius: BorderRadius.circular(25)),
                  child: BlurryContainer(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Stack(children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: textTitleMedium(
                                  text: vipController
                                              .listProduct[index].identifier ==
                                          '1_month'
                                      ? '1 tháng'.tr
                                      : '1 năm'.tr,
                                  color: Colors.white)),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: textTitleLarge(
                                  text: vipController
                                      .listProduct[index].priceString,
                                  color: isSelect ? Colors.white : colorF3))
                        ]),
                      )),
                ),
              );
            }));
  }
}
