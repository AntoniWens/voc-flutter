import 'package:flutter/material.dart';

import '../../app_bar.dart';
import '../../color_font_util.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar( false, 'Profile',),
      backgroundColor: ColorFontUtil.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 16,),
                Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          child: Image.asset('assets/images/user.png', width: 80,height: 80,),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                color: ColorFontUtil.red02,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(child: Icon(Icons.edit, color: ColorFontUtil.white,size: 14,))),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Text('Antoni', style: TextStyle(
                    fontFamily: ColorFontUtil.poppins,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorFontUtil.black25
                ),),
                Text('Indonesia', style: TextStyle(
                    fontFamily: ColorFontUtil.poppins,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorFontUtil.black25
                ),),
                SizedBox(height: 32),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(onPressed: () {},style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        ColorFontUtil.red02
                    ),
                  ), child: Text('Information', style: TextStyle(
                      fontFamily: ColorFontUtil.poppins,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorFontUtil.white
                  ),)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, color: ColorFontUtil.red02,),
                SizedBox(width: 8,),
                Text('Logout', style: TextStyle(
                    fontFamily: ColorFontUtil.poppins,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorFontUtil.black25
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
