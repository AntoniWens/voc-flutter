
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voc/preferences.dart';

import '../../app_bar.dart';
import '../../color_font_util.dart';
import '../../route_management/routes.dart';
import '../../widget/home_chat.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar( false, 'Chats',),
      backgroundColor: ColorFontUtil.white,
      floatingActionButton: FloatingActionButton(onPressed: () async {
        Get.toNamed(Routes.allUser);
      },backgroundColor: ColorFontUtil.white, child: Image.asset('assets/images/add_chat.png', width: 32,height: 32,),),
      body: SafeArea(
        child: Obx(() => controller.model.allChats.isEmpty ? Center(
          child: Image.asset('assets/images/empty_data.jpg', width: 300,height: 300,)
        ) : Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Obx(() => ListView.builder(
              itemCount: controller.model.allChats.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Obx(() => HomeChat(allChat: controller.model.allChats[index], onTap: () async {
                  final result = await Get.toNamed(Routes.chat, arguments: {
                    'user_id': controller.model.allChats[index].userTwoId == Preferences.getUser()['id'] ? controller.model.allChats[index].userOneId : controller.model.allChats[index].userTwoId,
                    'chat_id': controller.model.allChats[index].id,
                    'full_name': controller.model.allChats[index].userTwoId == Preferences.getUser()['id'] ? controller.model.allChats[index].userOneFullname : controller.model.allChats[index].userTwoFullname,
                    'language': controller.model.allChats[index].userTwoId == Preferences.getUser()['id'] ? controller.model.allChats[index].userOneLanguage : controller.model.allChats[index].userTwoLanguage
                  });
                  if (result != null) {
                    controller.queryAllChat();
                  }
                }));
              }),)
        ),
      )),
    );
  }
}
