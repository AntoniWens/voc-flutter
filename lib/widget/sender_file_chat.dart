
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:voc/util.dart';

import '../color_font_util.dart';

class SenderFileChat extends StatelessWidget {
  const SenderFileChat({super.key, });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 8, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: Util.queryImageSize(context, 550, 550)['width']! + 16,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorFontUtil.red45.withOpacity(0.2), ),
              color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: 'https://images.pexels.com/photos/433989/pexels-photo-433989.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                        placeholder: (_,__) => Image.asset('assets/images/placeholder_chat.png', width: 40,),
                        errorWidget: (_,__,___) => Image.asset('assets/images/placeholder_chat.png', width: 40,),
                        fit: BoxFit.cover,
                        width: Util.queryImageSize(context, 550, 550)['width']!,
                        height: Util.queryImageSize(context, 0, 0)['height']!,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'data.message dawdwad ad awd a',
                    style: TextStyle(
                        fontFamily: ColorFontUtil.poppins,
                        fontSize: 14,
                        color: ColorFontUtil.black25,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '22:10',
                      style: TextStyle(
                          fontFamily: ColorFontUtil.poppins,
                          fontSize: 10,
                          color: ColorFontUtil.black25.withOpacity(0.9),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(width: 4,),
                    SizedBox(width:10, height: 10,child: CircularProgressIndicator(strokeWidth: 2.0,color: ColorFontUtil.red02,))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
