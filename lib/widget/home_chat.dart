
import 'package:flutter/material.dart';
import 'package:voc/api_service/model/chat.dart';
import 'package:voc/preferences.dart';

import '../color_font_util.dart';

class HomeChat extends StatelessWidget {
  const HomeChat({super.key, required this.allChat, required this.onTap});

  final Chat allChat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 12,bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset('assets/images/user.png', width: 50,height: 50,fit: BoxFit.fill,)
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(allChat.userTwoId == Preferences.getUser()['id'] ? allChat.userOneFullname : allChat.userTwoFullname, style: TextStyle(
                            fontFamily: ColorFontUtil.poppins,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),),
                        const SizedBox(height: 4,),
                        Row(
                          children: [
                            allChat.senderId == Preferences.getUser()['id'] ? Icon(allChat.messageStatus == 'PENDING' ? Icons.pending : Icons.done_all, color: Colors.red,size: 14,) : const SizedBox.shrink(),
                            allChat.senderId == Preferences.getUser()['id'] ? const SizedBox(width: 4,): const SizedBox.shrink(),
                            Text(allChat.lastMessage, maxLines: 1, style: TextStyle(
                                fontFamily: ColorFontUtil.poppins,
                                fontSize: 14,
                                color: allChat.senderId == Preferences.getUser()['id'] ? ColorFontUtil.black25.withOpacity(0.8): (allChat.messageStatus == 'DELIVERED' ? Colors.black :ColorFontUtil.black25.withOpacity(0.8)),
                                fontWeight: allChat.senderId == Preferences.getUser()['id'] ?FontWeight.w400 :(allChat.messageStatus == 'DELIVERED' ? FontWeight.w500 :FontWeight.w400)
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(allChat.time, style: TextStyle(
                fontFamily: ColorFontUtil.poppins,
                fontSize: 12,
                color: ColorFontUtil.black25.withOpacity(0.8),
                fontWeight: FontWeight.w400
            ),),
          ],
        ),
      ),
    );
  }
}
