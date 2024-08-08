
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:voc/local_service/message.dart';

import '../color_font_util.dart';

class SenderChat extends StatelessWidget {
  const SenderChat({super.key, required this.data, required this.onReply});

  final ChatMessage data;
  final VoidCallback onReply;

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: (v) {
        onReply.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 8, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorFontUtil.red45.withOpacity(0.2), ),
                  color: ColorFontUtil.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
                    child: Text(
                      data.message,
                      style: TextStyle(
                          fontFamily: ColorFontUtil.poppins,
                          fontSize: 14,
                          color: ColorFontUtil.black25,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.time,
                          style: TextStyle(
                              fontFamily: ColorFontUtil.poppins,
                              fontSize: 10,
                              color: ColorFontUtil.black25.withOpacity(0.9),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 2,),
                        Icon(data.statusMessage == 'PENDING' ? Icons.pending : Icons.done_all, color: Colors.red,size: 14,)

                      ],
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
