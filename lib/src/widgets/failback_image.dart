import 'package:flutter/widgets.dart';

class FailbackImage {
  final String failbackImageSrc = "https://moorestown-mall.com/noimage.gif";
  Widget image;

  FailbackImage(String src, {double height, double width, BoxFit fit}) {
    try {
      image = Image.network(
        src,
        height: height,
        width: width,
        fit: fit,
      );
    } catch (e) {
      print("Image Exception: $e");
      image = Image.network(
        failbackImageSrc,
        height: height,
        width: width,
        fit: fit,
      );
    }
  }
}
