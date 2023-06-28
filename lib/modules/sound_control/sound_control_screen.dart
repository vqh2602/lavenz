import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/modules/home/home_controller.dart';
import 'package:lavenz/modules/sound_control/sound_control_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/count_down_timer.dart';
import 'package:lavenz/widgets/loading_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SoundControlScreen extends StatefulWidget {
  final bool? isShowDownTime;
  const SoundControlScreen({Key? key, this.isShowDownTime}) : super(key: key);
  static const String routeName = '/SoundControl';

  @override
  State<SoundControlScreen> createState() => _SoundControlScreenState();
}

class _SoundControlScreenState extends State<SoundControlScreen>
    with TickerProviderStateMixin {
  SoundControlController soundControlController = Get.find();
  HomeController homeController = Get.find();
  bool showHeader = true;

  @override
  void initState() {
    soundControlController.initVideoBackground();
    super.initState();
  }

  @override
  void dispose() {
    //soundControlController.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("assets/background/bg2.jpeg"), context);

    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: buildBody(
          context: context,
          body: _buildBody(),
          appBar: null,
        ));
  }

  Widget _buildBody() {
    return soundControlController.obx(
        (state) => Stack(
              children: <Widget>[
                Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background/bg2.jpeg'),
                          fit: BoxFit.fill)),
                ),
                // SizedBox(
                //   width: Get.width,
                //   height: Get.height,
                //   child: VideoPlayer(
                //       soundControlController.videoPlayerController!),
                // ),
                Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background/bg.png'),
                          fit: BoxFit.fill)),
                ),
                SafeArea(
                    child: Column(
                  children: [
                    cHeight(30),
                    if(widget.isShowDownTime ?? true)...[
                    _numSoundPlay(
                        title: 'Hẹn giờ'.tr,
                        isPlay: false,
                        wIcon: IconButton(
                            onPressed: () {
                              soundControlController.resetDownTime();
                            },
                            icon: const Icon(
                              LucideIcons.alarmMinus,
                              color: Colors.white70,
                            ))),
                    _header(),
                    cHeight(30),],
                    _numSoundPlay(
                        title: 'Âm nhạc'.tr,
                        isPlay: soundControlController.isPlayMusic,
                        onClick: () {
                          if (soundControlController.listMusic.isNotEmpty) {
                            soundControlController.playAllSound(type: 2);

                            soundControlController.updateUI();
                          }
                        },
                        num: '${soundControlController.listMusic.length}/1'),
                    _listSoundControl(
                        listData: soundControlController.listMusic, type: 2),
                    cHeight(30),
                    _numSoundPlay(
                        title: 'Âm thanh'.tr,
                        isPlay: soundControlController.isPlaySound,
                        onClick: () {
                          if (soundControlController.listAudio.isNotEmpty) {
                            soundControlController.playAllSound(type: 1);

                            soundControlController.updateUI();
                          }
                        },
                        num: '${soundControlController.listAudio.length}/${soundControlController.checkVipPlaySound()}'),
                    Expanded(
                      child: _listSoundControl(
                          listData: soundControlController.listAudio),
                    ),
                  ],
                ))
              ],
            ),
        onLoading: const LoadingCustom());
  }

  Widget _header() {
    return _countdownTime();
  }

  Widget _listSoundControl(
      {required List<AudioCustom> listData, int type = 1}) {
    return soundControlController.obx((state) => Container(
          padding: alignment_20_0(),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 4),
            itemCount: listData.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(top: 16),
                width: Get.width,
                height: 70,
                child: Tooltip(
                  message: listData[index].title,
                  child: InkWell(
                    onTap: () {
                      //soundControlController.playSoundControl();
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          alignment: Alignment.center, //
                          padding: (type == 1)
                              ? const EdgeInsets.all(12)
                              : EdgeInsets.zero,
                          decoration: BoxDecoration(
                              color: colorF2,
                              borderRadius: BorderRadius.circular(20)),
                          child: (type == 1)
                              ? SvgPicture.file(
                                  File(
                                      '${soundControlController.downloadAssetsController.assetsDir}/svg_icons/${listData[index].data.image}'),
                                  fit: BoxFit.scaleDown,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.file(
                                    File(
                                        '${soundControlController.downloadAssetsController.assetsDir}/images/${listData[index].data.image}'),
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                        ),
                        cWidth(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              cHeight(8),
                              textTitleSmall(
                                  text: listData[index].title,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderThemeData(
                                      // here
                                      rangeThumbShape:
                                          const RoundRangeSliderThumbShape(
                                              enabledThumbRadius: 16),
                                      thumbShape: const RoundSliderThumbShape(
                                          enabledThumbRadius: 8),
                                      overlayShape:
                                          SliderComponentShape.noThumb),
                                  child: Slider.adaptive(
                                    min: 0,
                                    max: 1,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white30,
                                    onChanged: (val) {
                                      soundControlController.onSetVolume(
                                          listData[index], val,
                                          type: type);
                                    },
                                    value: (type == 1)
                                        ? soundControlController
                                            .listAudio[index].volume
                                        : soundControlController
                                            .listMusic[index].volume,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        GFButton(
                          onPressed: () async {
                            soundControlController
                                .onPauseMP3(listData[index], index, type: type);
                          },
                          size: GFSize.LARGE,
                          padding: EdgeInsets.zero,
                          shape: GFButtonShape.pills,
                          color: Colors.transparent,
                          child: const Icon(
                            LucideIcons.xCircle,
                            size: 30,
                            color: Colors.white54,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  Widget _numSoundPlay(
      {required String title,
      String? num,
      Function? onClick,
      Widget? wIcon,
      required bool isPlay}) {
    return Container(
      margin: alignment_20_0(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              textTitleSmall(text: title.toUpperCase(), color: Colors.white),
              num != null
                  ? textBodySmall(text: num, color: Colors.white)
                  : const SizedBox()
            ],
          ),
          (wIcon == null)
              ? IconButton(
                  onPressed: () {
                    if (onClick != null) onClick();
                  },
                  icon: Icon(
                    isPlay ? LucideIcons.pauseCircle : LucideIcons.playCircle,
                    color: Colors.white70,
                  ))
              : wIcon
        ],
      ),
    );
  }

  Widget _countdownTime() {
    return InkWell(
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
                if (soundControlController.debounce != null) {
                  soundControlController.debounce?.cancel();
                }
                soundControlController.debounce =
                    Timer(const Duration(seconds: 3), () {
                  soundControlController.startTimer1(duration: changedtimer);
                });
              },
            ),
          ),
          backgroundColor: Colors.white,
        );
      },
      child: Container(
          margin: alignment_20_0(),
          alignment: Alignment.center,
          child: buildTime1(duration: soundControlController.duration1)),
    );
  }
}
