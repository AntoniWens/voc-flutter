
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:voc/local_service/message.dart';

import '../color_font_util.dart';

class SenderChatReply extends StatelessWidget {
  const SenderChatReply({super.key, required this.data, required this.onReply, required this.replyTap});

  final ChatMessage data;
  final VoidCallback onReply;
  final VoidCallback replyTap;

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
                  GestureDetector(
                    onTap: () {
                      replyTap.call();
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: ColorFontUtil.grayE8.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Get.arguments['full_name'],
                            style: TextStyle(
                                fontFamily: ColorFontUtil.poppins,
                                color: ColorFontUtil.red15,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            data.replyMessage,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: ColorFontUtil.poppins,
                              color: ColorFontUtil.black25,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                        Obx(() => Icon(data.status == 'PENDING' ? Icons.pending : Icons.done_all, color: Colors.red,size: 14,))
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
