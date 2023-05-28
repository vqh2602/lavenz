import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:lavenz/data/repositories/user_repo.dart';
import 'package:lavenz/modules/auth/login/login_screen.dart';
import 'package:lavenz/widgets/share_function/share_funciton.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController
    with GetTickerProviderStateMixin, StateMixin {
  UserRepo userRepo = UserRepo();
  GetStorage box = GetStorage();
  bool sex = true;
  Uint8List? base64Image;
  String base64ImageConvert = '';
  String avatarConverted = '';
  late TextEditingController firstNameTE,
      lastNameTE,
      emailTE,
      passWTE,
      confirmPassTE,
      birthTE,
      heightTE,
      weightTE,
      addressTE;

  @override
  Future<void> onInit() async {
    super.onInit();
    initTE();
    changeUI();
  }

  initTE() {
    firstNameTE = TextEditingController();
    lastNameTE = TextEditingController();
    emailTE = TextEditingController();
    passWTE = TextEditingController();
    confirmPassTE = TextEditingController();
    birthTE = TextEditingController();
    heightTE = TextEditingController();
    weightTE = TextEditingController();
    addressTE = TextEditingController();
  }

  Future<void> setAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    try {
      base64ImageConvert = await convertImageToBase64(file: File(image!.path));
      //print('convert image to base64: $base64ImageConvert');
      base64Image =
          await convertImageToBase64(base64String: base64ImageConvert);
     // await box.write(Storages.dataUrlAvatarUser, base64ImageConvert);
      avatarConverted = base64ImageConvert;
    } catch (_) {}
    changeUI();
  }

  Future<void> signup() async {
    await userRepo.signupWithEmail(
      name: '${firstNameTE.text}@${lastNameTE.text}',
      email: emailTE.text,
      passW: passWTE.text,
      birth: birthTE.text,
      sex: sex,
      height: double.parse(heightTE.text),
      weight: double.parse(weightTE.text),
      address: (addressTE.text.isEmpty) ? '' : addressTE.text,
      avatar: (avatarConverted.isEmpty) ? '' : avatarConverted,
    );

    Get.offAllNamed(LoginScreen.routeName);
    changeUI();
  }

  String? validateString(String? text) {
    if (text == null || text.isEmpty) {
      return "Trường bắt buộc";
    }
    return null;
  }

  String? numberValidator(String? value) {
    if (value == null || value == '') {
      return 'Trường bắt buộc';
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '$value không phải kiểu số';
    }
    return null;
  }

  String? validateEmail(String? value) {
    bool emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value ?? '');
    return emailValid ? null : "Không đúng định dạng email";
  }

  String? validatePass(String? value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return (regExp.hasMatch(value ?? '') && ((value ?? '').length > 7))
        ? null
        : 'Mật khẩu không đủ mạnh';
  }

  String? validateConfirmPass(String? value) {
    return (value == passWTE.text ? null : 'Mật khẩu không khớp');
  }

  changeUI() {
    change(null, status: RxStatus.success());
  }

  updateUI() {
    update();
  }

  loadingUI() {
    change(null, status: RxStatus.loading());
  }
}
