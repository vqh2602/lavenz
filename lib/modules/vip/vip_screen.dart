import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/modules/vip/vip_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/button_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});
  static const String routeName = '/vip';

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen> {
  VipController vipController = Get.put(VipController());
  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
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
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/bg.png'),
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
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset(
                  'assets/background/img1.jpg',
                  fit: BoxFit.cover,
                  height: Get.height * 0.42,
                  width: double.infinity,
                ),
              ),
              cHeight(20),
              Padding(
                padding: const EdgeInsets.only(left: 4 * 10, right: 4 * 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textHeadlineLarge(
                      text: 'Unlock Lavenz',
                      color: Get.theme.colorScheme.background,
                      fontWeight: FontWeight.w900,
                    ),
                    cHeight(20),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: vipOffer.length,
                      itemBuilder: (context, index) => vipOfferItem(
                        text: vipOffer[index],
                      ),
                    ),
                    cHeight(32),
                    Column(
                      children: [
                        textBodyMedium(
                            text:
                                'Sau 7 ngày dùng thử, gia hạn với 20000đ/ tháng hoặc 1tr500/năm',
                            color: Get.theme.colorScheme.background,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700),
                        cHeight(20),
                        buttonCustom(
                          title: 'Thử miễn phí và đăng ký',
                          onTap: () {},
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
}

List<String> vipOffer = [
  'Không có quảng cáo',
  '200+ hiệu ứng âm thanh thư giãn',
  'Không giới hạn tính năng nâng cao',
  'Trải nghiệm 7 ngày miễn phí',
];
