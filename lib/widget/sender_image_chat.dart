import 'package:flutter/material.dart';

import '../color_font_util.dart';
import '../pages/chat/model/chatting.dart';

class SenderImageChat extends StatelessWidget {
  const SenderImageChat({super.key, required this.chatting});

  final Chatting chatting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 8, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 8, top: 8),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorFontUtil.red15,
                      ColorFontUtil.red45
                    ]),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 4),
                      child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.asset('assets/images/placeholder.png', width: 250,height: 250,fit: BoxFit.fill,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(chatting.message, style: TextStyle(
                          fontFamily: ColorFontUtil.poppins,
                          fontSize: 14,
                          color: ColorFontUtil.white,
                          fontWeight: FontWeight.w400
                      ),),
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      children: [
                        Text(chatting.time, style: TextStyle(
                            fontFamily: ColorFontUtil.poppins,
                            fontSize: 9,
                            color: ColorFontUtil.white,
                            fontWeight: FontWeight.w400
                        ),),
                        const SizedBox(width: 4,),
                        Icon(Icons.check_circle_outlined, size: 12,color: ColorFontUtil.white,),
                        const SizedBox(width: 4,),
                      ],
                    ),
                    const SizedBox(height: 4,),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
