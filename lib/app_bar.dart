import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'color_font_util.dart';

class CustomAppBar {
  static PreferredSizeWidget appBar(bool navEnable, String title) {
    return AppBar(
      leading: navEnable ? GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_circle_left,
            color: ColorFontUtil.white,
          )) : const SizedBox.shrink(),
      backgroundColor: ColorFontUtil.black25,
      centerTitle: !navEnable,
      title: Text(
        title,
        style: TextStyle(
            fontFamily: ColorFontUtil.poppins,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: ColorFontUtil.white),
      ),
    );
  }

  static PreferredSizeWidget leftAppBar(String title) {
    return AppBar(
      backgroundColor: ColorFontUtil.black25,
      title: Text(
        title,
        style: TextStyle(
            fontFamily: ColorFontUtil.poppins,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: ColorFontUtil.white),
      ),
    );
  }
}