import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lavenz/modules/tools/horoscope/horoscope_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/loading_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({Key? key}) : super(key: key);
  static const String routeName = '/Horoscope';

  @override
  State<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen>
    with TickerProviderStateMixin {
  HoroscopeController horoscopeController = Get.find();
  // late AnimationController controller;
  // bool inhale = false;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      horoscopeController.initData();
    });
    super.initState();
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
    return horoscopeController.obx(
        (state) => Hero(
              tag: 'tools2',
              child: Stack(
                children: <Widget>[
                  Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/background/t3.jpeg'),
                            fit: BoxFit.cover)),
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
                    width: Get.width,
                    height: Get.height,
                    child: Lottie.asset(
                      'assets/animation/night_sky.json',

                      //  frameRate: FrameRate(60),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: SafeArea(
                        child: RefreshIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.blue,
                          strokeWidth: 4.0,
                          onRefresh: () async {
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              horoscopeController.initData();
                            });
                          },
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.only(bottom: 30, top: 30),
                              itemCount: horoscopeController.title.length,
                              itemBuilder: (context, index) => Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    child: BlurryContainer(
                                        blur: 5,
                                        color: Colors.black12,
                                        child: Column(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.3,
                                              height: Get.width * 0.3,
                                              child: SvgPicture.asset(
                                                horoscopeController
                                                    .getZodiacImage(
                                                        horoscopeController
                                                                .title[index]
                                                            ["title"]),
                                                fit: BoxFit.scaleDown,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Colors.white,
                                                        BlendMode.srcIn),
                                              ),
                                            ),
                                            cHeight(12),
                                            // textTitleMedium(
                                            //     text: horoscopeController
                                            //         .title[index]["title"],
                                            //     color: Colors.white),
                                            SelectableText(
                                              horoscopeController.title[index]
                                                      ["title"]
                                                  .toString()
                                                  .trim(),
                                              style: josefinSans(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            SelectableText(
                                              horoscopeController
                                                  .subTitle[index]["title"]
                                                  .toString()
                                                  .trim(),
                                              style: josefinSans(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            ),
                                            const Divider(
                                              color: Colors.white30,
                                            ),
                                            // textBodySmall(
                                            //     text: horoscopeController
                                            //         .elements[index]["title"],
                                            //     color: Colors.white60,
                                            //     textAlign: TextAlign.center),
                                            SelectableText(
                                              horoscopeController
                                                  .elements[index]["title"]
                                                  .toString()
                                                  .trim(),
                                              style: josefinSans(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white60,
                                                  fontSize: 14),
                                            ),
                                            cHeight(8),
                                          ],
                                        )),
                                  )),
                        ),
                      )),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: alignment_20_0(),
                        child: IconButton(
                          icon: const Icon(
                            LucideIcons.x,
                            color: Colors.white60,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
        onLoading: const LoadingCustom());
  }
}
