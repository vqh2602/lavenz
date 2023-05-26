import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/modules/sound/sound_screen.dart';
import 'package:lavenz/modules/sound_control/sound_control_screen.dart';
import 'package:lavenz/modules/tools/meditation/meditation_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/block_bottomsheet.dart';
import 'package:lavenz/widgets/count_down_timer.dart';
import 'package:lavenz/widgets/count_time.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({Key? key}) : super(key: key);
  static const String routeName = '/meditation';

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen>
    with TickerProviderStateMixin {
  MeditationController meditationController = Get.find();
  // late AnimationController controller;
  // bool inhale = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    meditationController.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      createFloatingActionButton: Wrap(
        spacing: 8,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              showBlockDetail(widget: const SoundScreen());
            },
            child: const Icon(LucideIcons.music),
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              showBlockDetail(
                  widget: const SoundControlScreen(
                isShowDownTime: false,
              ));
            },
            child: const Icon(LucideIcons.towerControl),
          ),
        ],
      ),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return meditationController.obx((state) => Hero(
          tag: 'tools1',
          child: Stack(
            children: <Widget>[
              Container(
                width: Get.width,
                height: Get.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background/t2.jpeg'),
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
              // AnimatedOpacity(
              //   opacity: meditationController.inhale ? 1.0 : 0.0,
              //   duration: const Duration(milliseconds: 4000),
              //   child: Container(
              //     width: Get.width,
              //     height: Get.height,
              //     color: Colors.teal,
              //   ),
              // ),
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
                            'assets/animation/meditation.json',
                            controller: meditationController.controller,
                            repeat: true,
                            //  frameRate: FrameRate(60),
                            fit: BoxFit.fill,
                            onLoaded: (composition) {
                              meditationController.controller.duration =
                                  composition.duration;

                              // controller.forward();
                            },
                          ),
                        ),
                        cHeight(12),
                        textTitleSmall(
                            text: 'Hẹn giờ'.toUpperCase(), color: Colors.white),
                        _countdownTime(),
                        cHeight(12),
                        textTitleSmall( 
                            text: 'Điếm giờ'.toUpperCase(),
                            color: Colors.white),
                        buildTime(duration: meditationController.duration),
                        cHeight(20),
                        GFButton(
                          onPressed: () {
                            setState(() {
                              if (meditationController.controller.isAnimating) {
                                meditationController.controller.stop();
                                meditationController.controller.reset();
                                meditationController.closeStartTime();
                              } else {
                                meditationController.controller.reset();
                                meditationController.controller.forward();
                                meditationController.playStartTime();
                              }
                            });
                          },
                          shape: GFButtonShape.pills,
                          type: GFButtonType.outline,
                          //icon: Icon(LucideIcons.play,color: Colors.white60,),
                          size: 50,
                          color: Colors.white,
                          child: textBodyMedium(
                              text:
                                  (meditationController.controller.isAnimating)
                                      ? 'Dừng'
                                      : 'Bắt đầu',
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
                  // if (meditationController.debounce != null) {
                  //   meditationController.debounce?.cancel();
                  // }
                  meditationController.duration1 = changedtimer;
                  meditationController.updateUI();
                  // meditationController.debounce =
                  //     Timer(const Duration(seconds: 3), () {
                  //   meditationController.startTimer1(duration: changedtimer);
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
            child: buildTime1(duration: meditationController.duration1)),
      ),
    );
  }
}
