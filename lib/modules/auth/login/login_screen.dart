import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lavenz/modules/auth/login/login_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lavenz/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return loginController.obx((state) => Stack(
          children: <Widget>[
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background/bg6.jpeg'),
                      fit: BoxFit.fill)),
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
              margin: alignment_20_0(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textHeadlineLarge(
                      text: 'LAVENZ',
                      color: Get.theme.colorScheme.background,
                      fontWeight: FontWeight.w900),

                  //cHeight(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //  verticalDirection: VerticalDirection.up,
                    children: [
                      textBodyMedium(
                          text: 'Đăng nhập để tiếp tục\n sử dụng ứng dụng'.tr,
                          textAlign: TextAlign.center,
                          color: Get.theme.colorScheme.background),
                      cHeight(12),
                      GFButton(
                        onPressed: () {
                          loginController.login();
                        },
                        color: Colors.white,
                        text: "Tiếp tục với Google".tr,
                        textStyle: josefinSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textColor: Colors.black,
                        shape: GFButtonShape.pills,
                        blockButton: true,
                        size: GFSize.LARGE,
                        padding: EdgeInsets.zero,
                        icon: const Icon(FontAwesomeIcons.google),
                      ),
                      if (Platform.isIOS) GFButton(
                        onPressed: () {
                          loginController.loginApple();
                        },
                        color: Colors.white,
                        text: "Tiếp tục với Apple".tr,
                        textStyle: josefinSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textColor: Colors.black,
                        shape: GFButtonShape.pills,
                        blockButton: true,
                        size: GFSize.LARGE,
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          FontAwesomeIcons.apple,
                          size: 30,
                        ),
                      ),
                      cHeight(12),

                      // Align
                      //   alignment: Alignment.bottomCenter,
                      //     child: Image.asset('assets/background/logo.png',width: 100, fit: BoxFit.cover,))
                    ],
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: textBodySmall(
                      text:
                          'Khi bạn đăng nhập ứng dụng cũng có nghĩa sẽ đồng ý với các điều khoản của chúng tôi.'
                              .tr,
                      textAlign: TextAlign.center,
                      color: Get.theme.colorScheme.background),
                )),
          ],
        ));
  }
}
