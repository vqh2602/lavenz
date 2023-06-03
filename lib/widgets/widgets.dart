import 'dart:typed_data';
import 'package:lavenz/widgets/color_custom.dart';
import 'package:lavenz/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lavenz/data/models/tag.dart' as tag;

Widget searchBar(
    {double? width,
    Function(String)? onChange,
    required TextEditingController controller}) {
  return Container(
    // margin: const EdgeInsets.symmetric(horizontal: 4 * 5),
    width:width ?? Get.width ,
    decoration: BoxDecoration(
      color: colorF3.withOpacity(0.3),
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      onChanged: onChange,
      controller: controller,
      textAlign: TextAlign.left,
      style: josefinSans(
        fontSize: 14,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.all(4 * 3),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.7,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.7,
          ),
        ),
        hintText: "Tìm kiếm ...",
        hintStyle: josefinSans(
          fontSize: 14,
          color: Colors.white,
        ),
        prefixIcon: const Icon(
          LucideIcons.search,
          size: 30,
          color: Colors.white,
        ),
      ),
    ),
  );
}

//avater tròn
Widget avatarImage(
    {required String url,
    double? radius,
    bool isFileImage = false,
    Uint8List? imageF}) {
  bool loadImageError = false;
  return StatefulBuilder(builder: (context, setState) {
    return !isFileImage
        ? CircleAvatar(
            radius: radius,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(url),
            onBackgroundImageError:
                (dynamic exception, StackTrace? stackTrace) {
              setState(() {
                loadImageError = true;
              });
            },
            child: loadImageError
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/image_notfound.jpg'))
                : null)
        : CircleAvatar(
            radius: radius,
            backgroundColor: Colors.transparent,
            backgroundImage:
                const AssetImage('assets/images/image_notfound.jpg'),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(radius ?? 20), // Image radius
                child: (imageF == null)
                    ? Image.asset(
                        'assets/images/image_notfound.jpg',
                        fit: BoxFit.cover,
                      )
                    : Image.memory(
                        imageF,
                        errorBuilder: (buildContext, object, stackTrace) =>
                            Image.asset(
                          'assets/images/image_notfound.jpg',
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
            ));
  });
}

Widget buttonSetting({
  required IconData iconStart,
  required IconData iconEnd,
  Function? onTap,
  required String title,
  bool isToggle = false,
  Color? disabledTrackColor,
  Color? enabledTrackColor,
  bool valToggle = false,
  Function(bool?)? onChangeToggle,
}) {
  return Container(
    decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 0.5))),
    padding: const EdgeInsets.only(top: 4 * 5, bottom: 4 * 5),
    child: InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4 * 5,
            children: [
              Icon(
                iconStart,
                size: 4 * 6,
              ),
              textTitleSmall(text: title),
            ],
          ),
          isToggle
              ? GFToggle(
                  onChanged: onChangeToggle!,
                  value: valToggle,
                  disabledTrackColor:
                      disabledTrackColor ?? Colors.grey.shade300,
                  enabledTrackColor: enabledTrackColor ?? Colors.black,
                  type: GFToggleType.ios,
                )
              : Icon(
                  iconEnd,
                  size: 4 * 5,
                ),
        ],
      ),
    ),
  );
}

Widget noData({required Function inReload}) {
  return Container(
    margin: EdgeInsets.zero,
    color: Get.theme.colorScheme.background,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              // color: Colors.cyan,
              margin: EdgeInsets.zero,
              //height: 20,
              child: Lottie.asset('assets/animate/nodata.json',
                  width: Get.width, fit: BoxFit.fill)),
          textBodyMedium(
            text: 'Không có dữ liệu',
            color: Get.theme.colorScheme.onBackground,
          ),
          GFButton(
            onPressed: () {
              inReload();
            },
            color: Get.theme.colorScheme.onBackground,
            colorScheme: Get.theme.colorScheme,
            text: 'Làm mới',
          )
        ],
      ),
    ),
  );
}

Widget cWidth(double val) => SizedBox(
      width: val,
    );
Widget cHeight(double val) => SizedBox(
      height: val,
    );

Widget filterChip(
    {required tag.Data tagData,
    required bool isSelect,
    required Function(tag.Data?) onChange}) {
  return ChoiceChip(
    label: textBodySmall(
      text: tagData.name ?? '',
      color: Colors.black,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(color: colorF1),
    ),
    selectedColor: colorF3,
    disabledColor: Get.theme.colorScheme.background,
    selected: isSelect,
    avatar: null,
    onSelected: (bool value) {
      onChange(tagData);
    },
  );
}

filterAlertTags(
    {required List<tag.Data> result,
    required List<tag.Data?> choices,
    required Function(tag.Data?) onChange,
    required Function onSubmit}) {
  Get.dialog(
    AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: textBodyMedium(text: 'Huỷ'.tr),
          ),
          textTitleMedium(text: 'Lọc'.tr),
          TextButton(
            onPressed: () {
              Get.back();
              onSubmit();
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: textBodyMedium(text: 'Xác nhận'.tr),
          ),
        ],
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Wrap(
          spacing: 4,
          children: [
            for (var item1 in result) ...[
              filterChip(
                tagData: item1,
                isSelect: choices.contains(item1) ? true : false,
                onChange: (item1) {
                  onChange(item1);
                  setState(() {});
                },
              )
            ]
          ],
        ),
      ),
    ),
  );
}
