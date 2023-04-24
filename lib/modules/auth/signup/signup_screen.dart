import 'dart:io';

import 'package:lavenz/modules/auth/login/login_screen.dart';
import 'package:lavenz/modules/auth/signup/signup_controller.dart';
import 'package:lavenz/widgets/base/base.dart';
import 'package:lavenz/widgets/share_function/share_funciton.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:lavenz/widgets/theme_textinput.dart';
import 'package:lavenz/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String routeName = '/signup';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupController signupController = Get.put(SignupController());
  GlobalKey<FormState> keyForm1 = GlobalKey<FormState>(debugLabel: '_FormS1');
  bool sex = true;
  bool passwordVisible = true;
  File? imagePath;
  @override
  void initState() {
    super.initState();
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
    return SafeArea(
        child: SingleChildScrollView(
      child: signupController.obx((state) => Form(
            key: keyForm1,
            child: Container(
              margin: EdgeInsets.zero,
              padding: alignment_20_0(),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4 * 10,
                  ),
                  textTitleLarge(text: 'Đăng kí'.toUpperCase()),
                  textBodyMedium(
                      text: 'Đăng kí tài khoản để có thể truy cập ứng dụng'),
                  const SizedBox(
                    height: 4 * 10,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          signupController.setAvatar();
                          // setState(() {
                          //   try {
                          //     // imagePath = File(image!.path);
                          //   } catch (_) {}
                          // });
                        },
                        child: Ink(
                          child: avatarImage(
                            url: '',
                            isFileImage: true,
                            imageF: signupController.base64Image,
                            radius: 60,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4 * 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onTap: () {},
                              style: josefinSans(fontSize: 16),
                              decoration:
                                  textFieldInputStyle(label: 'Họ & đệm (*)'),
                              validator: signupController.validateString,
                              controller: signupController.firstNameTE,
                            ),
                          ),
                          const SizedBox(
                            width: 4 * 5,
                          ),
                          Expanded(
                            child: TextFormField(
                              onTap: () {},
                              style: josefinSans(fontSize: 16),
                              decoration: textFieldInputStyle(label: 'Tên (*)'),
                              validator: signupController.validateString,
                              controller: signupController.lastNameTE,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {},
                    style: josefinSans(fontSize: 16),
                    keyboardType: TextInputType.emailAddress,
                    decoration: textFieldInputStyle(label: 'Email (*)'),
                    maxLines: 1,
                    validator: signupController.validateEmail,
                    controller: signupController.emailTE,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {},
                    style: josefinSans(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: passwordVisible,
                    decoration: textFieldInputStyle(
                        label: 'Mật khẩu (*)',
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
                    maxLines: 1,
                    validator: signupController.validatePass,
                    controller: signupController.passWTE,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {},
                    style: josefinSans(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: textFieldInputStyle(
                        label: 'Nhập lại mật khẩu (*)',
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
                    maxLines: 1,
                    validator: signupController.validateConfirmPass,
                    controller: signupController.confirmPassTE,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {
                      dateTimePicker(
                          onchange: (dt) {
                            signupController.birthTE.text = formatDate(
                                type: TypeDate.yyyyMMdd, dateTime: dt);
                            // signupController.birthTE?.text = formatDate(
                            //     type: TypeDate.ddMMyyyy, dateTime: dt);
                          },
                          onComplete: () {});
                    },
                    controller: signupController.birthTE,
                    showCursor: false,
                    readOnly: true,
                    style: josefinSans(fontSize: 16),
                    decoration: textFieldInputStyle(label: 'Năm sinh (*)'),
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sex = true;
                            signupController.sex = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: !sex
                                      ? Colors.grey
                                      : Get.theme.colorScheme.onBackground)),
                          child: Center(
                            child: textBodyMedium(
                                text: 'Nam',
                                color: !sex
                                    ? Colors.grey
                                    : Get.theme.colorScheme.onBackground),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4 * 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sex = false;
                            signupController.sex = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: sex
                                      ? Colors.grey
                                      : Get.theme.colorScheme.onBackground)),
                          child: Center(
                            child: textBodyMedium(
                                text: 'Nữ',
                                color: sex
                                    ? Colors.grey
                                    : Get.theme.colorScheme.onBackground),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  TextFormField(
                    onTap: () {},
                    controller: signupController.addressTE,
                    style: josefinSans(fontSize: 16),
                    decoration: textFieldInputStyle(label: 'Địa chỉ'),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onTap: () {},
                          style: josefinSans(fontSize: 16),
                          validator: signupController.numberValidator,
                          controller: signupController.heightTE,
                          decoration:
                              textFieldInputStyle(label: 'Chiều cao (cm)'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 4 * 5,
                      ),
                      Expanded(
                        child: TextFormField(
                          onTap: () {},
                          keyboardType: TextInputType.number,
                          validator: signupController.numberValidator,
                          controller: signupController.weightTE,
                          decoration:
                              textFieldInputStyle(label: 'Cân nặng (kg)'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4 * 10,
                  ),
                  GFButton(
                    onPressed: () {
                      if (keyForm1.currentState?.validate() ?? false) {
                        signupController.loadingUI();
                        signupController.signup();
                      }
                    },
                    padding: const EdgeInsets.only(
                      left: 4 * 5,
                      right: 4 * 5,
                    ),
                    size: 4 * 13,
                    color: Colors.black,
                    type: GFButtonType.outline,
                    fullWidthButton: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textTitleSmall(
                            text: 'Đăng kí'.toUpperCase(), color: Colors.black),
                        const Icon(
                          LucideIcons.arrowRight,
                          size: 4 * 6,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4 * 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(LoginScreen.routeName);
                    },
                    child: Ink(
                      child: textBodyMedium(
                          text: 'Đã có tài khoản? Đăng nhập',
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(
                    height: 4 * 10,
                  ),
                ],
              ),
            ),
          )),
    ));
  }
}
