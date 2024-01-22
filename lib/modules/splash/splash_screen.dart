import 'package:lavenz/modules/splash/splash_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavenz/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    splashController.checkLogin();
  }

  @override
  void dispose() {
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
    return splashController.obx((state) => Stack(
          children: <Widget>[
            SizedBox(
              width: Get.width,
              height: Get.height,
              child:
                  Image.asset('assets/background/vd3.gif', fit: BoxFit.cover),
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
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textHeadlineLarge(
                      text: 'LAVENZ',
                      color: Get.theme.colorScheme.background,
                      fontWeight: FontWeight.w900),
                  textBodySmall(
                      text: 'Ngủ & Thiền, Thư giãn'.tr,
                      color: Get.theme.colorScheme.background),
                  cHeight(100)
                  // Align
                  //   alignment: Alignment.bottomCenter,
                  //     child: Image.asset('assets/background/logo.png',width: 100, fit: BoxFit.cover,))
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    'assets/background/logo.png',
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                )),
          ],
        ));
  }
}
