import 'package:flutter/material.dart';
import 'package:voc/util.dart';

import '../color_font_util.dart';

class ChatDate extends StatelessWidget {
  const ChatDate({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(date == Util.currentDateTime()['date'] ? 'Today' : date, style: TextStyle(
          fontFamily: ColorFontUtil.poppins,
          color: Colors.grey,
          fontSize: 12
      ),),
    );
  }
}
