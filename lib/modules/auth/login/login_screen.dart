import 'package:lavenz/modules/auth/login/login_controller.dart';
import 'package:lavenz/modules/auth/signup/signup_screen.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/theme_textinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  GlobalKey<FormState> keyForm1 = GlobalKey<FormState>(debugLabel: '_FormL1');
  int selectedIndex = 0;
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: null,
    );
  }

  Widget _buildBody() {
    return loginController.obx((state) => SafeArea(
          child: Form(
            key: keyForm1,
            child: Container(
              height: Get.height,
              margin: alignment_20_0(),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 4 * 20,
                        ),
                        textHeadlineLarge(
                            text: 'Đăng nhập', fontWeight: FontWeight.w700),
                        const SizedBox(
                          height: 4 * 1,
                        ),
                        textBodySmall(
                          text:
                              'Đăng nhập để bắt đầu quản lý quá trình tập luyện',
                        ),
                        const SizedBox(
                          height: 4 * 16,
                        ),
                        TextFormField(
                          onTap: () {},
                          controller: loginController.emailTE,
                          style: josefinSans(fontSize: 16),
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFieldInputStyle(label: 'Email'),
                          maxLines: 1,
                          validator: loginController.validateEmail,
                        ),
                        const SizedBox(
                          height: 4 * 6,
                        ),
                        TextFormField(
                          onTap: () {},
                          controller: loginController.passWTE,
                          obscureText: passwordVisible,
                          decoration: textFieldInputStyle(
                              label: 'Mật khẩu',
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                child: Ink(
                                  child: Icon(passwordVisible
                                      ? LucideIcons.eye
                                      : LucideIcons.eyeOff),
                                ),
                              )),
                          validator: loginController.validateString,
                        ),
                        const SizedBox(
                          height: 4 * 2,
                        ),
                        InkWell(
                          onTap: () {
                            Get.offAndToNamed(SignupScreen.routeName);
                          },
                          child: Ink(
                            child: textBodyMedium(
                                text: 'Chưa có tài khoản? Đăng kí',
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        const SizedBox(
                          height: 4 * 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Expanded(
                              child: GFButton(
                                onPressed: () {
                                  if (keyForm1.currentState?.validate() ??
                                      false) {
                                    loginController.loadingUI();
                                    loginController.login();
                                  }
                                },
                                padding: const EdgeInsets.only(
                                  left: 4 * 5,
                                  right: 4 * 5,
                                ),
                                size: 4 * 13,
                                color: Colors.black,
                                fullWidthButton: true,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textTitleSmall(
                                        text: 'Đăng nhập'.toUpperCase(),
                                        color: Colors.white),
                                    const Icon(
                                      LucideIcons.arrowRight,
                                      size: 4 * 6,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  loginController.login(isLoginBiometric: true);
                                },
                                icon: const Icon(LucideIcons.scanFace))
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
