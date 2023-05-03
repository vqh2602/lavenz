import 'package:getwidget/getwidget.dart';
import 'package:lavenz/modules/setting/setting_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/loading_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static const String routeName = '/setting';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingController settingController = Get.put(SettingController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //splashController.videoPlayerController?.dispose();
    super.dispose();
  }
      @override
  void didChangeDependencies() {
    precacheImage(const AssetImage("assets/background/bg6.jpeg"), context);
    super.didChangeDependencies();
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
    return settingController.obx(
        (state) => Stack(
              children: <Widget>[
                Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background/bg6.jpeg'),
                          fit: BoxFit.fill)),
                ),
                // SizedBox(
                //   width: Get.width,
                //   height: Get.height,
                //   child: VideoPlayer(splashController.videoPlayerController!),
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
                  child: Container(
                    margin: alignment_20_0(),
                    height: Get.height,
                    width: Get.width,
                    child: settingBody(),
                  ),
                ),
              ],
            ),
        onLoading: const LoadingCustom());
  }

  Widget settingBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cHeight(30),
                textTitleSmall(
                    text: 'Dịch vụ'.toUpperCase(),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                cHeight(12),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: textBodySmall(
                            text: 'Gói đăng kí', color: Colors.white70),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: textBodyMedium(
                            text: 'Vip',
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: GFButton(
                          color: const Color.fromARGB(255, 255, 216, 59),
                          onPressed: () {},
                          shape: GFButtonShape.pills,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: textBodyMedium(
                              text: 'Gói đăng kí', fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ]),
                )
              ]),
          cHeight(30),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textTitleSmall(
                    text: 'Dữ liệu'.toUpperCase(),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                cHeight(12),
                _blockItem(
                    title: 'Phiên bản ứng dụng',
                    onTap: () {},
                    value: settingController.packageInfo?.version ?? ''),
                cHeight(4),
                _blockItem(
                    title: 'Phiên bản dữ liệu',
                    onTap: () {
                      settingController.checkUpdateData();
                    },
                    value: settingController.oldVer["version_data"] ?? ''),
              ]),
          cHeight(30),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textTitleSmall(
                    text: 'Khác'.toUpperCase(),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                cHeight(12),
                _blockItem(
                  title: 'Hỗ trợ & Giúp đỡ',
                  onTap: () {},
                ),
                cHeight(4),
                _blockItem(
                  title: 'Điều khoản dịch vụ',
                  onTap: () {},
                ),
                cHeight(4),
                _blockItem(
                  title: 'Chính sách bảo mật',
                  onTap: () {},
                ),
                cHeight(4),
                _blockItem(
                  title: 'Thông tin thêm',
                  onTap: () {},
                ),
              ])
        ],
      ),
    );
  }

  Widget _blockItem(
      {required String title, required Function onTap, String? value}) {
    return Container(
      height: value != null ? 90 : 70,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 12),
      decoration: BoxDecoration(
          color: Colors.white30, borderRadius: BorderRadius.circular(20)),
      child: Stack(children: [
        Align(
          alignment: value != null ? Alignment.topLeft : Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textBodySmall(text: title, color: Colors.white70),
                IconButton(
                  onPressed: () {
                    onTap();
                  },
                  icon: const Icon(LucideIcons.chevronRight),
                  color: Colors.white70,
                )
              ],
            ),
          ),
        ),
        if (value != null)
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: textBodyMedium(
                  text: value,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
      ]),
    );
  }
}