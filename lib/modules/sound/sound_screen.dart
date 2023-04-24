import 'package:flutter_svg/flutter_svg.dart';
import 'package:lavenz/modules/sound/sound_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/loading_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class SoundScreen extends StatefulWidget {
  const SoundScreen({Key? key}) : super(key: key);
  static const String routeName = '/Sound';

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen>
    with TickerProviderStateMixin {
  SoundController soundController = Get.put(SoundController());
  bool showHeader = true;
  ScrollController scrollController = ScrollController();
  late TabController tabController, tabControllerMin;
  @override
  void initState() {
    soundController.initVideoBackground();
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
    soundController.videoPlayerController?.dispose();
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
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4 * 0),
              child: Container(
                padding: alignment_20_0(),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: tabController,
                    unselectedLabelColor: Colors.transparent,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 4.0,
                        ),
                      ),
                    ),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    isScrollable: true,
                    tabs: [
                      Container(
                        margin: const EdgeInsets.all(4 * 2),
                        child: textTitleMedium(
                            text: 'Âm thanh',
                            fontWeight: (tabController.index == 0)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: (tabController.index == 0)
                                ? Colors.white
                                : Colors.white54),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4 * 2),
                        child: textTitleMedium(
                            text: 'Âm nhạc',
                            fontWeight: (tabController.index == 1)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: (tabController.index == 1)
                                ? Colors.white
                                : Colors.white54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildBody() {
    return soundController.obx(
        (state) => Stack(
              children: <Widget>[
                SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: VideoPlayer(soundController.videoPlayerController!),
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
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _header(),
                      // Container(
                      //    color: Colors.red,
                      //  ),
                      Container(
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
        onLoading: const LoadingCustom());
  }

  Widget _header() {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 4,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          bottom: TabBar(
            controller: tabControllerMin,

            // unselectedLabelColor: Colors.transparent,
            //indicatorColor: Colors.white,
            // indicatorSize: TabBarIndicatorSize.tab,
            //dividerColor: Colors.transparent,
            indicator: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
            ),
            // overlayColor:
            //     MaterialStateProperty.all<Color>(Colors.transparent),
            isScrollable: true,
            tabs: [
              for (int i = 0; i < dataTab.length; i++) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: textBodySmall(
                      text: dataTab[i],
                      fontWeight: (tabControllerMin.index == i)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: (tabControllerMin.index == i)
                          ? Colors.white
                          : colorF3),
                ),
              ]
            ],
          ),
        ),
        body: TabBarView(
          controller: tabControllerMin,
          children: [
            listSound(),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }

  Widget listSound() {
    return Container(
      padding: alignment_20_0(),
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 12),
        itemCount: 20,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemBuilder: (BuildContext context, int index) {
          return Tooltip(
            message: 'ádfnsdjkfhkjsdfhnjkleswdfbnjkl',
            child: InkWell(
              onTap: () {
                soundController.playSound();
              },
              child: Column(
                children: [
                  Container(
                      width: 70,
                      height: 70,
                      alignment: Alignment.center, //
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: colorF2,
                          borderRadius: BorderRadius.circular(12)),
                      child: SvgPicture.asset(
                        'assets/background/noun-wind-3100898.svg',
                        fit: BoxFit.scaleDown,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      )),
                  cHeight(4),
                  textBodySmall(
                      text: 'âm thanh nhẹ sss sss ss ',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<String> dataTab = [
  'Tất cả',
  'Nước',
  'Thiên nhiên',
  'Đồng quê',
  'Thành phố',
  'Nhà'
];
