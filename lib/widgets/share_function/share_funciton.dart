import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

void dateTimePicker(
    {required Function(DateTime) onchange, required Function onComplete}) {
  Get.bottomSheet(
      backgroundColor: Get.theme.colorScheme.background,
      Container(
        height: 200,
        padding: EdgeInsets.zero,
        child: CupertinoDatePicker(
            onDateTimeChanged: onchange,
            initialDateTime: DateTime.now(),
            //backgroundColor: Colors.white,
            dateOrder: DatePickerDateOrder.dmy,
            mode: CupertinoDatePickerMode.date),
      )).whenComplete(() => onComplete());
}

enum TypeDate { ddMMyyyy, yyyyMMdd, ddMMyyyyhhmm, hhmm, dd, yyyy, mM }

String? formatDate({required TypeDate type, required DateTime? dateTime}) {
  if (dateTime == null) return null;
  switch (type) {
    case TypeDate.ddMMyyyy:
      return DateFormat('dd-MM-yyyy').format(dateTime);
    case TypeDate.yyyyMMdd:
      return DateFormat('yyyy-MM-dd').format(dateTime);
    case TypeDate.ddMMyyyyhhmm:
      return DateFormat('dd-MM-yyyy hh:mm').format(dateTime);
    case TypeDate.hhmm:
      return DateFormat('hh:mm').format(dateTime);
    case TypeDate.dd:
      return dateTime.day.toString();
    case TypeDate.yyyy:
      return dateTime.year.toString();
    case TypeDate.mM:
      return dateTime.month.toString();
  }
}

// khoảng cách ngày
int daysBetween({required DateTime from, required DateTime to}) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

//tính buổi
String getSesisonDay() {
  DateTime dt = DateTime.now();
  if (dt.hour >= 18 || (dt.hour >= 0 && dt.hour < 4)) return 'tối'.tr;
  if (dt.hour >= 4 && dt.hour < 11) return 'sáng'.tr;
  if (dt.hour >= 11 && dt.hour < 13) return 'trưa'.tr;
  return 'chiều'.tr;
}

Future<dynamic> convertImageToBase64({File? file, String? base64String}) async {
  // nếu là kiẻu file thì convert ra base64 string
  if (file != null) {
    Uint8List imagebytes = await file.readAsBytes(); //convert to bytes
    String base64string = base64.encode(imagebytes);
    // log('convert image to base64: $base64string');
    return base64string;
  }
  // nếu là kiểu string thì convert ra ảnh
  if (base64String != null) {
    Uint8List decodedbytes = base64.decode(base64String);
    return decodedbytes;
  }
}

Future<String> getCurrentUrl(String url) async {
  if (Platform.isIOS) {
    String a = url.substring(url.indexOf("Documents/") + 10, url.length);
    Directory dir = await getApplicationDocumentsDirectory();
    a = "${dir.path}/$a";
    //print('aaa $a');
    return a;
  } else {
    return url;
  }
}

Future<void> onPopDialog(
    {required BuildContext context,
    required String title,
    required Function onCancel,
    required Function onSubmit}) async {
  await showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: textBodyMedium(text: 'Thông báo'.tr, fontWeight: FontWeight.bold),
      content: Container(
        margin: const EdgeInsets.only(top: 12),
        child: textBodySmall(
          text: title,
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: textBodySmall(
              text: "Hủy".tr,
              color: Get.theme.colorScheme.error,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3),
          onPressed: () {
            // Navigator.of(context).pop(false);
            onCancel();
          },
        ),
        CupertinoDialogAction(
          child: textBodySmall(
              text: 'Xác nhận'.tr,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3),
          onPressed: () {
            // Navigator.of(context).pop(true);
            onSubmit();
          },
        ),
      ],
    ),
  );
}

String getLocalConvertString() {
  Locale? locale = Get.deviceLocale;
  //print('vitri : ${locale?.languageCode}');
  switch (locale?.languageCode.toString()) {
    case 'en':
      return 'en';
    case 'vi':
      return 'vi';
    default:
      return 'en';
  }
}

showWebInApp(String url) async {
  if (!await launchUrl(Uri.parse(url),mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}
