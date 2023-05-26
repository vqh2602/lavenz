import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/modules/tools/breath/breath_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/count_down_timer.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BreathScreen extends StatefulWidget {
  const BreathScreen({Key? key}) : super(key: key);
  static const String routeName = '/breath';

  @override
  State<BreathScreen> createState() => _BreathScreenState();
}

class _BreathScreenState extends State<BreathScreen>
    with TickerProviderStateMixin {
  BreathController breathController = Get.find();
  // late AnimationController controller;
  // bool inhale = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    breathController.controller.dispose();
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
    return breathController.obx((state) => Hero(
          tag: 'tools0',
          child: Stack(
            children: <Widget>[
              Container(
                width: Get.width,
                height: Get.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background/t1.jpeg'),
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
              AnimatedOpacity(
                opacity: breathController.inhale ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 4000),
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.teal,
                ),
              ),
              SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        cHeight(30),
                        Container(
                          width: Get.width,
                          height: Get.width,
                          margin: const EdgeInsets.only(top: 20),
                          child: Lottie.asset(
                            'assets/animation/breath.json',
                            controller: breathController.controller,
                            repeat: true,
                            //  frameRate: FrameRate(60),
                            fit: BoxFit.fill,
                            onLoaded: (composition) {
                              breathController.controller.duration =
                                  composition.duration;

                              // controller.forward();
                            },
                          ),
                        ),
                        _countdownTime(),
                        cHeight(20),
                        GFButton(
                          onPressed: () {
                            setState(() {
                              if (breathController.controller.isAnimating) {
                                breathController.controller.stop();
                                 breathController.controller.reset();
                                breathController.closeStartTime();
            
                              } else {
                                breathController.controller.reset();
                                breathController.controller.forward();
                                breathController.playStartTime();
                              }
                            });
                          },
                          shape: GFButtonShape.pills,
                          type: GFButtonType.outline,
                          //icon: Icon(LucideIcons.play,color: Colors.white60,),
                          size: 50,
                          color: Colors.white,
                          child: textBodyMedium(
                              text: (breathController.controller.isAnimating)
                                  ? 'dừng'
                                  : 'phát',
                              color: Colors.white),
                        ),
                      ],
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
        ));
  }

  Widget _countdownTime() {
    return Material(
      child: InkWell(
        onTap: () {
          Get.bottomSheet(
            SizedBox(
              height: 250,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hms,
                minuteInterval: 5,
                secondInterval: 10,
                initialTimerDuration: Duration.zero,
                onTimerDurationChanged: (Duration changedtimer) {
                  // if (breathController.debounce != null) {
                  //   breathController.debounce?.cancel();
                  // }
                  breathController.duration1 = changedtimer;
                  breathController.updateUI();
                  // breathController.debounce =
                  //     Timer(const Duration(seconds: 3), () {
                  //   breathController.startTimer1(duration: changedtimer);
                  // }
                  // );
                },
              ),
            ),
            backgroundColor: Colors.white,
          );
        },
        child: Container(
            margin: alignment_20_0(),
            alignment: Alignment.center,
            child: buildTime1(duration: breathController.duration1)),
      ),
    );
  }
}
