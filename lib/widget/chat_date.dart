import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color_font_util.dart';

class ChatDate extends StatelessWidget {
  const ChatDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('22 April 2023', style: TextStyle(
          fontFamily: ColorFontUtil.poppins,
          color: Colors.grey,
          fontSize: 12
      ),),
    );
  }
}
