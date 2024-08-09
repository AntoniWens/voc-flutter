
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../color_font_util.dart';

class SendImage extends StatelessWidget {
   SendImage({super.key, required this.onTap, required this.data});

  final Function(String message) onTap;
  final String data;

  final typeController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorFontUtil.white,
      surfaceTintColor: ColorFontUtil.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Send your image', style: TextStyle(
                    fontFamily: ColorFontUtil.poppins,
                    color: ColorFontUtil.black25,
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                ),),
                IconButton(onPressed: () {
                  Get.back();
                },icon: const Icon(Icons.cancel), color: ColorFontUtil.red02,)
              ],
            ),
            const SizedBox(height: 8,),
            Container(
              width: double.infinity,
              height: 250,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: ColorFontUtil.grayC7),
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(image: AssetImage('assets/images/placeholder.png'))
              ),
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: typeController2,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        fontFamily: ColorFontUtil.poppins,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        hintText: 'Type something',
                        hintStyle: TextStyle(
                            fontFamily: ColorFontUtil.poppins,
                            fontWeight: FontWeight.w400),
                        fillColor: ColorFontUtil.grayE8,
                        filled: true,
                        contentPadding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 16, right: 16),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                const SizedBox(width: 16,),
                GestureDetector(
                    onTap: () {
                      onTap.call(typeController2.text);
                    },
                    child: Image.asset(
                      'assets/images/send.png',
                      width: 20,
                      height: 20,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
