
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:voc/local_service/message.dart';

import '../color_font_util.dart';

class ReceiverChat extends StatelessWidget {
  const ReceiverChat({super.key, required this.data, required this.showOriginalText, required this.onReply});

  final ChatMessage data;
  final bool showOriginalText;
  final VoidCallback onReply;

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: (v) {
        onReply.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 32, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorFontUtil.grayE8),
                  color: ColorFontUtil.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
                    child: Text(
                      !showOriginalText ? data.translationMsg : data.message,
                      style: TextStyle(
                          fontFamily: ColorFontUtil.poppins,
                          fontSize: 14,
                          color: ColorFontUtil.black25,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
                    child: Text(
                      data.time,
                      style: TextStyle(
                          fontFamily: ColorFontUtil.poppins,
                          fontSize: 10,
                          color: ColorFontUtil.black25.withOpacity(0.6),
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
