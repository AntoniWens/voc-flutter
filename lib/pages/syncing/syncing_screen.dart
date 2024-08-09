import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:voc/color_font_util.dart';
import 'controller/syncing_controller.dart';

class SyncingScreen extends GetWidget<SyncingController> {
  const SyncingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/sync.jpg'),
            Column(
              children: [
                Text('One moment, please', style: TextStyle(
                    fontFamily: ColorFontUtil.poppins,
                    fontWeight: FontWeight.w500,
                  fontSize: 16
                ),),
                const SizedBox(height: 16,),
                Text("We're syncing your data", style: TextStyle(
                    fontFamily: ColorFontUtil.poppins,
                    fontWeight: FontWeight.w400,
                  fontSize: 12
                ),),
                const SizedBox(height: 16,),
                LottieBuilder.asset('assets/loading/loading2.json',width: 70,height: 70,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
