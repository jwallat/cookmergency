import 'package:flutter/widgets.dart';

class FailbackImage extends Image {
  final String failbackImageSrc = "https://moorestown-mall.com/noimage.gif";

  FailbackImage(String src, {double height, double width, BoxFit fit}) {
    try {
      Image.network(
        src,
        height: height,
        width: width,
        fit: fit,
      );
    } catch (e) {
      Image.network(
        failbackImageSrc,
        height: height,
        width: width,
        fit: fit,
      );
    }
  }
}
