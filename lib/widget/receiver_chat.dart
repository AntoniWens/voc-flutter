
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:voc/local_service/message.dart';

import '../api_service/response/user_chat_response.dart';
import '../color_font_util.dart';
import '../pages/chat/model/chatting.dart';

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
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: ColorFontUtil.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(showOriginalText ? 'Original text' :'Automatic translated', style: TextStyle(
                          fontFamily: ColorFontUtil.poppins,
                          fontSize: 8,
                          color: ColorFontUtil.red02,
                          fontWeight: FontWeight.w400
                      ),),
                      const SizedBox(height: 4,),
                      Text(!showOriginalText ? data.translationMsg : data.message, style: TextStyle(
                          fontFamily: ColorFontUtil.poppins,
                          fontSize: 14,
                          color: ColorFontUtil.black25,
                          fontWeight: FontWeight.w400
                      ),),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Text(data.time, style: TextStyle(
                        fontFamily: ColorFontUtil.poppins,
                        fontSize: 10,
                        color: ColorFontUtil.black25.withOpacity(0.6),
                        fontWeight: FontWeight.w400
                    ),),
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
