import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/modules/sound_control/sound_control_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/loading_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:video_player/video_player.dart';

class SoundControlScreen extends StatefulWidget {
  const SoundControlScreen({Key? key}) : super(key: key);
  static const String routeName = '/SoundControl';

  @override
  State<SoundControlScreen> createState() => _SoundControlScreenState();
}

class _SoundControlScreenState extends State<SoundControlScreen>
    with TickerProviderStateMixin {
  SoundControlController soundControlController =
      Get.put(SoundControlController());
  bool showHeader = true;
  ScrollController scrollController = ScrollController();
  late TabController tabController, tabControllerMin;
  @override
  void initState() {
    soundControlController.initVideoBackground();
    scrollController.addListener(() {
      if (scrollController.position.pixels <=
          scrollController.position.minScrollExtent + 20) {
        //print('mở');
        setState(() {
          showHeader = true;
        });
      } else {
        setState(() {
          showHeader = false;
        });
      }
    });
    tabController = TabController(length: 2, vsync: this);
    tabControllerMin = TabController(length: 6, vsync: this);
    tabControllerMin.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    soundControlController.videoPlayerController?.dispose();
    scrollController.dispose();
    tabController.dispose();
    tabControllerMin.dispose();
    super.dispose();
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
                SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: VideoPlayer(
                      soundControlController.videoPlayerController!),
                ),
                Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background/bg.png'),
                          fit: BoxFit.fill)),
                ),
                SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _header(),
                      // Container(
                      //    color: Colors.red,
                      //  ),
                      _listSoundControl(),
                      Container(
                        color: Colors.black,
                      ),
                    ],
                  ),
                ))
              ],
            ),
        onLoading: const LoadingCustom());
  }

  Widget _header() {
    return Container();
  }

  Widget _listSoundControl() {
    return soundControlController.obx((state) => Container(
          padding: alignment_20_0(),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 12),
            itemCount: soundControlController.listAudio.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(top: 16),
                width: Get.width,
                height: 70,
                child: Tooltip(
                  message: 'ádfnsdjkfhkjsdfhnjkleswdfbnjkl',
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
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: colorF2,
                                borderRadius: BorderRadius.circular(20)),
                            child: SvgPicture.asset(
                              'assets/background/noun-wind-3100898.svg',
                              fit: BoxFit.scaleDown,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            )),
                        cWidth(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              cHeight(8),
                              textTitleSmall(
                                  text: 'âm thanh nhẹ sss sss ss ',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderThemeData(
                                      // here
                                      overlayShape:
                                          SliderComponentShape.noThumb),
                                  child: Slider.adaptive(
                                    min: 0,
                                    max: 1,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white30,
                                    onChanged: (val) {
                                      soundControlController
                                          .listAudio[index].audioPlayer
                                          .setVolume(val);
                                      soundControlController
                                          .listAudio[index].volume = val;
                                      soundControlController.updateUI();
                                    },
                                    value: soundControlController
                                        .listAudio[index].volume,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        GFButton(
                          onPressed: () async {
                            soundControlController.listAudio[index].audioPlayer
                                .dispose();
                            soundControlController.listAudio.removeAt(index);
                            soundControlController.updateUI();
                          },
                          size: GFSize.LARGE,
                          padding: EdgeInsets.zero,
                          shape: GFButtonShape.pills,
                          color: Colors.transparent,
                          child: const Icon(
                            LucideIcons.xCircle,
                            size: 30,
                            color: Colors.white,
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
}
