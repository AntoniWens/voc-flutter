import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../color_font_util.dart';

class RedButton extends StatelessWidget {
  const RedButton({super.key, required this.text, required this.isLoading, required this.isEmpty, required this.onTap});

  final String text;
  final bool isLoading;
  final bool isEmpty;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(onPressed: onTap,style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(isEmpty ? ColorFontUtil.grayC7 : ColorFontUtil.red02),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              )
          )
      ), child: !isLoading ? Text(text, style: TextStyle(
          fontFamily: ColorFontUtil.poppins,
          color: ColorFontUtil.white,
          fontWeight: FontWeight.bold
      ),) : LottieBuilder.asset('assets/loading/loading.json')),
    );
  }
}
