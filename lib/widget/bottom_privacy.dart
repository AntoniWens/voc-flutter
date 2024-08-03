import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../color_font_util.dart';

class BottomPrivacy extends StatelessWidget {
  const BottomPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            children: [
              TextSpan(text: 'by_continuing_you_agree_to_translator'.tr, style: TextStyle(
                  fontFamily: ColorFontUtil.poppins,
                  fontSize: 12,
                  color: ColorFontUtil.black25
              )),
              TextSpan(text: 'terms_of_user_privacy_policy'.tr, style: TextStyle(
                  fontFamily: ColorFontUtil.poppins,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: ColorFontUtil.black25
              ))
            ]
        ));
  }
}
