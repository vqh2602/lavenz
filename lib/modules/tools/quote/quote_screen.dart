import 'package:intl/intl.dart';
import 'package:lavenz/modules/tools/quote/quote_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/loading_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);
  static const String routeName = '/Quote';

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen>
    with TickerProviderStateMixin {
  QuoteController quoteController = Get.find();
  // late AnimationController controller;
  // bool inhale = false;
  @override
  void initState() {
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
    return quoteController.obx(
        (state) => Hero(
              tag: 'tools3',
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
                  Container(
                    height: Get.height,
                    width: Get.width,
                    margin: alignment_20_8(),
                    child: SafeArea(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          child: textDisplayLarge(
                              text: DateTime.now().day.toString(),
                              color: Colors.white,
                              height: 0,
                              fontWeight: FontWeight.normal),
                        ),
                        Material(
                          child: textBodySmall(
                              text: DateFormat.yMMMM().format(DateTime.now()),
                              color: Colors.white60),
                        ),
                        cHeight(20),
                        SelectableText(
                          quoteController.dataQuote["content"]??'',
                          style: josefinSans(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              letterSpacing: 2,
                              wordSpacing: 5,
                              height: 1.5,
                              fontSize: 17),
                        ),
                        // textTitleMedium(
                        //     text: quoteController.dataQuote["content"],
                        //     color: Colors.white,
                        //     letterSpacing: 2,
                        //     wordSpacing: 5,
                        //     height: 1.5),
                        cHeight(8),
                        SizedBox(
                          width: Get.width * 0.2,
                          child: const Divider(
                            color: Colors.white30,
                          ),
                        ),
                        cHeight(8),
                        textBodySmall(
                            text: quoteController.dataQuote["author"]??'',
                            fontStyle: FontStyle.italic,
                            color: Colors.white60),
                        cHeight(Get.height * 0.1)
                      ],
                    )),
                  ),
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
