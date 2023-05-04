import 'package:lavenz/modules/dashbroad/dashbroad_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/build_item_4x3.dart';
import 'package:lavenz/widgets/build_list_item_4x3.dart';
import 'package:lavenz/widgets/loading_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class DashBroadScreen extends StatefulWidget {
  const DashBroadScreen({Key? key}) : super(key: key);
  static const String routeName = '/DashBroad';

  @override
  State<DashBroadScreen> createState() => _DashBroadScreenState();
}

class _DashBroadScreenState extends State<DashBroadScreen> {
  DashBroadController dashBroadController = Get.put(DashBroadController());
  bool showHeader = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    dashBroadController.initVideoBackground();
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
    super.initState();
  }

  @override
  void dispose() {
    dashBroadController.videoPlayerController?.dispose();
    scrollController.dispose();
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
    return dashBroadController.obx(
        (state) => Stack(
              children: <Widget>[
                SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child:
                      VideoPlayer(dashBroadController.videoPlayerController!),
                ),
                Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background/bg.png'),
                          fit: BoxFit.fill)),
                ),
                Container(
                  height: Get.height,
                  width: Get.width,
                  padding: alignment_20_0_0(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cHeight(60),
                      _header(),
                      cHeight(20),
                      Expanded(child: _bodyDash())
                    ],
                  ),
                )
              ],
            ),
        onLoading: const LoadingCustom());
  }

  Widget _header() {
    return AnimatedContainer(
      width: showHeader ? Get.width : Get.width,
      height: showHeader ? Get.height * 0.3 : 70,
      duration: const Duration(milliseconds: 500),
      padding: showHeader ? const EdgeInsets.only(top: 30) : EdgeInsets.zero,
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: showHeader ? Alignment.topCenter : Alignment.topLeft,
            duration: const Duration(milliseconds: 500),
            child: textHeadlineLarge(
                text: 'Lavenz',
                color: Get.theme.colorScheme.background,
                fontWeight: FontWeight.w700),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: textBodySmall(
              text: 'Chào buổi tối, Huy',
              color: Get.theme.colorScheme.background,
            ),
          )
        ],
      ),
    );
  }

  Widget _bodyDash() {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          buildListItem4x3(),
          cHeight(8),
          buildItem4x3(),
          // cHeight(30),
          // buildListItem1x1(),
          // cHeight(12),
          // buildListItem1x1(),
          // cHeight(12),
          buildItem4x3(),
          cHeight(100)
        ],
      ),
    );
  }
}
