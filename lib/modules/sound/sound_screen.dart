import 'package:lavenz/modules/home/home_controller.dart';
import 'package:lavenz/modules/sound/sound_controller.dart';
import 'package:lavenz/modules/sound_control/sound_control_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/build_list_item_1x1.dart';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/list_sound.dart';
import 'package:lavenz/widgets/loading_custom.dart';

import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';

class SoundScreen extends StatefulWidget {
  const SoundScreen({Key? key}) : super(key: key);
  static const String routeName = '/Sound';

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen>
    with TickerProviderStateMixin {
  SoundController soundController = Get.put(SoundController());
  SoundControlController soundControlController =
      Get.put(SoundControlController());
  HomeController homeController = Get.find();
  bool showHeader = true;
  @override
  void initState() {
    //soundController.initVideoBackground();
    super.initState();
  }

  @override
  void dispose() {
    //soundController.videoPlayerController?.dispose();
  //  soundController.tabController.dispose();
  //   soundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: soundController.obx((state) => buildBody(
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
                    controller: soundController.tabController,
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
                            fontWeight: (soundController.tabController.index == 0)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: (soundController.tabController.index == 0)
                                ? Colors.white
                                : Colors.white54),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4 * 2),
                        child: textTitleMedium(
                            text: 'Âm nhạc',
                            fontWeight: (soundController.tabController.index == 1)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: (soundController.tabController.index == 1)
                                ? Colors.white
                                : Colors.white54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ))
 ); }

  Widget _buildBody() {
    return soundController.obx(
        (state) => Stack(
              children: <Widget>[
                Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background/bg1.jpeg'),
                          fit: BoxFit.fill)),
                ),
                // SizedBox(
                //   width: Get.width,
                //   height: Get.height,
                //   child: VideoPlayer(soundController.videoPlayerController!),
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
                  child: TabBarView(
                    controller: soundController.tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _sound(),
                      // Container(
                      //    color: Colors.red,
                      //  ),
                      _music()
                    ],
                  ),
                )
              ],
            ),
        onLoading: const LoadingCustom());
  }

  Widget _sound() {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 4,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          bottom: TabBar(
            controller: soundController.tabControllerMin,

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
              for (int i = 0; i < soundController.dataTab.length; i++) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: textBodySmall(
                      text: soundController.dataTab[i],
                      fontWeight: (soundController.tabControllerMin.index == i)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: (soundController.tabControllerMin.index == i)
                          ? Colors.white
                          : colorF3),
                ),
              ]
            ],
          ),
        ),
        body: TabBarView(
          controller: soundController.tabControllerMin,
          children: [
            //all
            listSound(
              onTap: (sound, data) {
                soundController.onPlaySound(sound, data);
              },
              onTapPlaying: (data) {
                soundController.onPlaySound('', data, isPlaying: true);
              },
              listSelect:
                  soundControlController.listAudio.map((e) => e.data).toList(),
              listData: soundController.listSound,
              pathBase:
                  '${soundController.downloadAssetsController.assetsDir}/svg_icons/',
            ),

            for (var x in soundController.listTagSound) ...[
              listSound(
                onTap: (sound, data) {
                  soundController.onPlaySound(sound, data);
                },
                onTapPlaying: (data) {
                  soundController.onPlaySound('', data, isPlaying: true);
                },
                listSelect: soundControlController.listAudio
                    .map((e) => e.data)
                    .toList(),
                listData: soundController.listSound
                    .where((element) =>
                        element.tag!.contains(num.parse(x.id.toString())))
                    .toList(),
                pathBase:
                    '${soundController.downloadAssetsController.assetsDir}/svg_icons/',
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _music() {
    return SingleChildScrollView(
      child: Container(
        margin: alignment_20_0_0(),
        child: Column(children: [
          cHeight(30),
          buildListItem1x1(
              onTap: (sound, data) async {
                soundController.onPlayMusic(sound, data);
              },
              listData: soundController.listMusic
                  .where((element) => element.tag?.contains(17) ?? false)
                  .toList(),
              pathImages:
                  '${soundController.downloadAssetsController.assetsDir}/images/',
              title: 'Đi vào giấc ngủ'),
          cHeight(12),
          buildListItem1x1(
              onTap: (sound, data) async {
                soundController.onPlayMusic(sound, data);
              },
              listData: soundController.listMusic
                  .where((element) => element.tag?.contains(18) ?? false)
                  .toList(),
              pathImages:
                  '${soundController.downloadAssetsController.assetsDir}/images/',
              title: 'Bản nhạc thiên nhiên'),
          cHeight(12),
          buildListItem1x1(
              onTap: (sound, data) async {
                soundController.onPlayMusic(sound, data);
              },
              listData: soundController.listMusic
                  .where((element) => element.tag?.contains(12) ?? false)
                  .toList(),
              pathImages:
                  '${soundController.downloadAssetsController.assetsDir}/images/',
              title: 'Bản nhạc thư giãn'),
          cHeight(12),
          buildListItem1x1(
              onTap: (sound, data) async {
                soundController.onPlayMusic(sound, data);
              },
              listData: soundController.listMusic
                  .where((element) => element.tag?.contains(13) ?? false)
                  .toList(),
              pathImages:
                  '${soundController.downloadAssetsController.assetsDir}/images/',
              title: 'Tập trung cao độ'),
          cHeight(12),
          buildListItem1x1(
              onTap: (sound, data) async {
                soundController.onPlayMusic(sound, data);
              },
              listData: soundController.listMusic
                  .where((element) => element.tag?.contains(14) ?? false)
                  .toList(),
              pathImages:
                  '${soundController.downloadAssetsController.assetsDir}/images/',
              title: 'Giải toả tâm trạng'),
          cHeight(12),
          buildListItem1x1(
              onTap: (sound, data) async {
                soundController.onPlayMusic(sound, data);
              },
              listData: soundController.listMusic
                  .where((element) => element.tag?.contains(15) ?? false)
                  .toList(),
              pathImages:
                  '${soundController.downloadAssetsController.assetsDir}/images/',
              title: 'Bản nhạc trị liệu'),
          cHeight(12),
        ]),
      ),
    );
  }
}
