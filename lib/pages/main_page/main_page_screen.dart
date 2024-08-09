
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voc/pages/home/home_screen.dart';
import 'package:voc/pages/profile/profile_screen.dart';
import 'dart:io' show Platform;

import '../../color_font_util.dart';
import 'controller/main_page_controller.dart';

class MainPageScreen extends GetWidget<MainPageController> {
   const MainPageScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => controller.model.selectedIndex.value == 0
            ? HomeScreen()
            : controller.model.selectedIndex.value == 1
            ? const ProfileScreen()
            : controller.model.selectedIndex.value == 2
            ? Container()
            : Container(),
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: Obx(
                () => SizedBox(
              height: Platform.isAndroid ? 81 : 100,
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/images/chat_unselected.png', width: 28, height: 28,),
                    activeIcon: Image.asset('assets/images/chat_selected.png',width: 28, height: 28,),
                    label: 'Chat'
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/images/user_unselected.png', width: 24, height: 24,),
                      activeIcon: Image.asset('assets/images/user_selected.png',width: 24, height: 24,),
                    label: 'Profile'
                  ),
                ],
                selectedItemColor: ColorFontUtil.red02,
                unselectedItemColor: ColorFontUtil.black25.withOpacity(0.6),
                selectedLabelStyle: TextStyle(
                    fontFamily: ColorFontUtil.poppins,
                    color: ColorFontUtil.red45,
                    fontSize: 14),
                unselectedLabelStyle: TextStyle(
                    fontFamily: ColorFontUtil.poppins,
                    color: ColorFontUtil.black25.withOpacity(0.6),
                    fontSize: 14),
                currentIndex: controller.model.selectedIndex.value,
                onTap: (value) {
                  controller.onItemTapped(value);


                },
              ),
            ),
          )),
    );
  }
}
