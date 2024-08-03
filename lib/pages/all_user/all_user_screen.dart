
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voc/route_management/routes.dart';
import 'package:voc/util.dart';
import '../../color_font_util.dart';
import '../../widget/user_item.dart';
import 'controller/all_user_controller.dart';

class AllUserScreen extends GetWidget<AllUserController> {
  const AllUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_circle_left,
              color: ColorFontUtil.white,
            )),
        backgroundColor: ColorFontUtil.black25,
        title: Obx(
          () => controller.model.inSearch.value
              ? TextFormField(
            focusNode: controller.searchFocus,
            cursorColor: ColorFontUtil.white,
            style: TextStyle(
                fontFamily: ColorFontUtil.poppins,
                color: ColorFontUtil.white
            ),
            decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none
            ),
          )
              : Text(
                  'all_user'.tr,
                  style: TextStyle(
                      fontFamily: ColorFontUtil.poppins,
                      fontSize: 16,
                      color: ColorFontUtil.white),
                ),
        ),
        actions: [
          Obx(() => !controller.model.inSearch.value ? IconButton(
              onPressed: () {
                controller.setInSearch(true,context);
              },
              icon: Icon(
                Icons.search,
                color: ColorFontUtil.white,
              )) : IconButton(
              onPressed: () {
                controller.setInSearch(false, context);
              },
              icon: Icon(
                Icons.clear,
                color: ColorFontUtil.white,
              )))
        ],
      ),
      backgroundColor: ColorFontUtil.white,
      body: Column(
        children: [
          const SizedBox(height: 8,),
          Expanded(
            child: Obx(() => ListView.builder(
                itemCount: controller.model.allUsers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(onTap: () async {
                    final chat = await controller.getChat(controller.model.allUsers[index].id);
                      Get.toNamed(Routes.chat, arguments: {
                        'full_name': controller.model.allUsers[index].fullName,
                        'language': controller.model.allUsers[index].language,
                        'user_id': controller.model.allUsers[index].id,
                        'chat_id': chat == null ? Util.generateChar(10) : chat
                            .id
                      });

                  },child: Obx(() => UserItem(data: controller.model.allUsers[index],)));
                }),)
          )
        ],
      ),
    );
  }
}
