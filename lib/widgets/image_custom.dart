import 'package:flutter/material.dart';

Widget imageNetwork(
    {required String url,
    BoxFit? fit,
    Color? color,
    double? height,
    double? width,
    double scale = 1.0,
    AlignmentGeometry alignment = Alignment.center,
    int? cacheHeight,
    int? cacheWidth,
    Animation<double>? opacity,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    bool matchTextDirection = false,
    BlendMode? colorBlendMode,
    Rect? centerSlice,
    Map<String, String>? headers,
    FilterQuality filterQuality = FilterQuality.low,
    Key? key,
    String? semanticLabel}) {
  return Image.network(
    url,
    fit: fit,
    color: color,
    height: height,
    width: width,
    scale: scale,
    alignment: alignment,
    cacheHeight: cacheHeight,
    cacheWidth: cacheWidth,
    opacity: opacity,
    repeat: repeat,
    matchTextDirection: matchTextDirection,
    colorBlendMode: colorBlendMode,
    errorBuilder: (context, object, stackTrace) {
      return SizedBox(
        height: double.infinity,
        child: Image.asset(
          'assets/images/image_notfound.jpg',
          fit: BoxFit.fill,
        ),
      );
    },
    centerSlice: centerSlice,
    headers: headers,
    filterQuality: filterQuality,
    key: key,
    semanticLabel: semanticLabel,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
  );
}
