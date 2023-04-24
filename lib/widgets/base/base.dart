import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

Widget buildBody(
    {required BuildContext context,
    required Widget body,
    AppBar? appBar,
    Widget? bottomNavigationBar,
    Widget? createFloatingActionButton,
    bool isCheckBeforePop = false,
    FloatingActionButtonLocation? floatingActionButtonLocation}) {
  return WillPopScope(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: appBar,
          backgroundColor: Get.theme.colorScheme.background,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: createFloatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          body: body),
      onWillPop: () async => onWillPop(context, isCheckBeforePop));
}

Future<bool> onWillPop(BuildContext context, bool isCheckBeforePop) async {
  //print('dđ');
  if (!isCheckBeforePop) {
    return true;
  }
  bool exitResult = await showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: textBodyLarge(text: "Thông báo", fontWeight: FontWeight.w700),
      content: Container(
        margin: const EdgeInsets.only(top: 16),
        child:
            textBodyMedium(text: "Bạn có chắc chắn muốn thoát khỏi ứng dụng?"),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: textBodyMedium(
            text: "Hủy",
            color: Get.theme.colorScheme.error,
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        CupertinoDialogAction(
          child: textBodyMedium(
            text: 'Xác nhận',
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    ),
  );
  return exitResult;
}

AppBar buildDefaultAppBar(
    {Widget? header,
    IconData? icon,
    List<Widget>? actions,
    EdgeInsetsGeometry? paddingActionIcon,
    Widget? actionIcon,
    bool showBack = true,
    bool isSearch = false,
    RxBool? edit,
    Color? color,
    Color? colorIconAction,
    Color? iconColor,
    Color? textColor,
    String? routeName,
    data,
    Function(dynamic)? callback,
    bool? centerTitle = true,
    Function()? callbackLeading,
    Color? backgroundColor,
    double? leadingWidth,
    bool automaticallyImplyLeading = true}) {
  return AppBar(
    elevation: 0,
    backgroundColor: backgroundColor,
    centerTitle: true,
    automaticallyImplyLeading: automaticallyImplyLeading,
    leadingWidth: leadingWidth,
    title: !isSearch ? header : null,
    leading: showBack
        ? IconButton(
            onPressed: () {
              if (callbackLeading != null) {
                callbackLeading();
              } else {
                Get.back();
              }
            },
            icon: Icon(
              LucideIcons.chevronLeft,
              size: 26,
              color: Get.theme.colorScheme.onBackground,
            ))
        : null,
  );
}

// căn lề
EdgeInsets alignment_20_8() {
  return const EdgeInsets.fromLTRB(20, 8, 20, 8);
}

EdgeInsets alignment_20_0() {
  return const EdgeInsets.fromLTRB(20, 0, 20, 0);
}
EdgeInsets alignment_20_0_0() {
  return const EdgeInsets.fromLTRB(20, 0, 0, 0);
}

EdgeInsets alignment_0() {
  return const EdgeInsets.fromLTRB(0, 0, 0, 0);
}
