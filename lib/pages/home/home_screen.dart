
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voc/local_service/local_service.dart';
import 'package:voc/preferences.dart';

import '../../app_bar.dart';
import '../../color_font_util.dart';
import '../../route_management/routes.dart';
import '../../widget/home_chat.dart';
import 'controller/home_controller.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar( false, 'Chats',),
      backgroundColor: ColorFontUtil.white,
      floatingActionButton: FloatingActionButton(onPressed: () {
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
                  await LocalService.updateChat(controller.model.allChats[index].id, 'SUCCESS');
                  final result = await Get.toNamed(Routes.chat, arguments: {
                    'user_id': controller.model.allChats[index].receiverId == Preferences.getUser()['id'] ? controller.model.allChats[index].senderId : controller.model.allChats[index].receiverId,
                    'chat_id': controller.model.allChats[index].id,
                    'full_name': controller.model.allChats[index].receiverId == Preferences.getUser()['id'] ? controller.model.allChats[index].senderFullname : controller.model.allChats[index].receiverFullname,
                    'language': controller.model.allChats[index].receiverLanguage
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
