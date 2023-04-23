import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

enum TypeToast {
  GetError,
  GetSuccess,
  GetDefault,
  ToastDefault,
  ToastError,
  ToastSuccess
}

void buildToast(
    {String? title,
      required String message,
      required TypeToast status,
      Duration? duration,
      Color? backgroundColor,
      Color? textColor}) {
  switch (status) {
    case TypeToast.GetSuccess:
      {
        Get.snackbar(title ?? 'Thành công'.tr, message,
            duration: duration ?? const Duration(seconds: 1),
            backgroundColor: backgroundColor ?? Colors.green,
            colorText: textColor ?? Colors.white);
        break;
      }
    case TypeToast.GetError:
      {
        Get.snackbar(title ?? 'Có lỗi sảy ra'.tr, message,
            duration: duration ?? const Duration(seconds: 1),
            backgroundColor: backgroundColor ?? Colors.red,
            colorText: textColor ?? Colors.white);
        break;
      }
    case TypeToast.GetDefault:
      {
        Get.snackbar(title ?? 'Thông báo'.tr, message,
            backgroundColor: backgroundColor,
            colorText: textColor,
            duration: duration ?? const Duration(seconds: 1));
        break;
      }
    case TypeToast.ToastDefault:
      {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: backgroundColor,
            textColor: textColor,
            fontSize: 16,
            gravity: ToastGravity.BOTTOM);
        break;
      }
    case TypeToast.ToastSuccess:
      {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: backgroundColor ?? Colors.green,
            textColor: textColor ?? Colors.white,
            fontSize: 16,
            gravity: ToastGravity.BOTTOM);
        break;
      }
    case TypeToast.ToastError:
      {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: backgroundColor ?? Colors.red,
            textColor: textColor ?? Colors.white,
            fontSize: 16,
            gravity: ToastGravity.BOTTOM);
        break;
      }
    default:
      {
        Get.snackbar('Thông báo'.tr, message, duration: const Duration(seconds: 1));
      }
  }
}