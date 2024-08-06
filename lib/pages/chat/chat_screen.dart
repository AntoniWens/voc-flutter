import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:voc/popup/send_image.dart';
import 'package:voc/widget/chat_date.dart';
import 'package:voc/widget/receiver_chat_reply.dart';
import 'package:voc/widget/sender_chat_reply.dart';

import '../../color_font_util.dart';
import '../../preferences.dart';
import '../../widget/receiver_chat.dart';
import '../../widget/sender_chat.dart';
import 'controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetWidget<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorFontUtil.grayFA,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: ColorFontUtil.black25,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back(result: 's');
                      },
                      child: Icon(
                        Icons.arrow_circle_left,
                        color: ColorFontUtil.white,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          'assets/images/user.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Get.arguments['full_name'],
                          style: TextStyle(
                              fontFamily: ColorFontUtil.poppins,
                              fontSize: 14,
                              color: ColorFontUtil.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          Get.arguments['language'],
                          style: TextStyle(
                              fontFamily: ColorFontUtil.poppins,
                              fontSize: 12,
                              color: ColorFontUtil.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Icon(
                      Icons.g_translate_outlined,
                      color: Colors.grey,
                      size: 15,
                    ))
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Obx(
                      () => ListView.separated(
                          controller: controller.autoScrollController,
                          itemCount: controller.model.messages.length + 1,
                          separatorBuilder: (context, index) {
                            return index == 0
                                ? ChatDate()
                                : controller.model.messages[index - 1].date !=
                                        controller.model.messages[index].date
                                    ? ChatDate()
                                    : SizedBox();
                          },
                          itemBuilder: (context, index) {
                            return AutoScrollTag(
                                key: ValueKey(index),
                                controller: controller.autoScrollController,
                                index: index,
                                highlightColor: ColorFontUtil.grayE8,
                                child: index != 0
                                    ? Obx(() => (controller
                                                    .model
                                                    .messages[index - 1]
                                                    .senderId !=
                                                Preferences.getUser()['id']) &&
                                            (controller
                                                .model
                                                .messages[index - 1]
                                                .replyMessageId
                                                .isNotEmpty)
                                        ? ReceiverChatReply(
                                            data: controller
                                                .model.messages[index - 1],
                                            showOriginalText: controller
                                                .model.showOriginalText.value,
                                            onReply: () {
                                              controller.showReply(
                                                  controller
                                                      .model
                                                      .messages[index - 1]
                                                      .message,
                                                  controller.model
                                                      .messages[index - 1].id);
                                            },
                                            replyTap: () async {
                                              final ind = controller
                                                  .model.messages
                                                  .indexWhere((e) =>
                                                      e.id ==
                                                      controller
                                                          .model
                                                          .messages[index - 1]
                                                          .replyMessageId);
                                              await controller
                                                  .scrollToItem(ind);
                                            },
                                          )
                                        : (controller.model.messages[index - 1]
                                                        .senderId ==
                                                    Preferences.getUser()[
                                                        'id']) &&
                                                (controller
                                                    .model
                                                    .messages[index - 1]
                                                    .replyMessageId
                                                    .isNotEmpty)
                                            ? SenderChatReply(
                                                data: controller
                                                    .model.messages[index - 1],
                                                onReply: () {
                                                  controller.showReply(
                                                      controller
                                                          .model
                                                          .messages[index - 1]
                                                          .message,
                                                      controller
                                                          .model
                                                          .messages[index - 1]
                                                          .id);
                                                },
                                                replyTap: () async {
                                                  final ind = controller
                                                      .model.messages
                                                      .indexWhere((e) =>
                                                          e.id ==
                                                          controller
                                                              .model
                                                              .messages[
                                                                  index - 1]
                                                              .replyMessageId);
                                                  await controller
                                                      .scrollToItem(ind);
                                                },
                                              )
                                            : controller
                                                        .model
                                                        .messages[index - 1]
                                                        .senderId !=
                                                    Preferences.getUser()['id']
                                                ? ReceiverChat(
                                                    data: controller.model
                                                        .messages[index - 1],
                                                    showOriginalText: controller
                                                        .model
                                                        .showOriginalText
                                                        .value,
                                                    onReply: () {
                                                      controller.showReply(
                                                          controller
                                                              .model
                                                              .messages[
                                                                  index - 1]
                                                              .message,
                                                          controller
                                                              .model
                                                              .messages[
                                                                  index - 1]
                                                              .id);
                                                    },
                                                  )
                                                : SenderChat(
                                                    data: controller.model
                                                        .messages[index - 1],
                                                    onReply: () {
                                                      controller.showReply(
                                                          controller
                                                              .model
                                                              .messages[
                                                                  index - 1]
                                                              .message,
                                                          controller
                                                              .model
                                                              .messages[
                                                                  index - 1]
                                                              .id);
                                                    },
                                                  ))
                                    : SizedBox());
                          }),
                    )),
              ),
              Obx(
                () => controller.model.replyMessage.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: ColorFontUtil.grayFA,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Get.arguments['full_name'],
                                      style: TextStyle(
                                          fontFamily: ColorFontUtil.poppins,
                                          color: ColorFontUtil.red15,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      controller.model.replyMessage.value,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: ColorFontUtil.poppins,
                                        color: ColorFontUtil.black25,
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 6),
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () {
                                controller.showReply('', '');
                              },
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.typeController,
                        focusNode: controller.focusNode,
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
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(20))),
                        onChanged: (v) {
                          controller.showSendBtn(v.isNotEmpty);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(context: context, builder: (context) {
                                return SendImage(onTap: (v) {}, data: '');
                              });
                            },
                            child: Image.asset(
                              'assets/images/attach.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          Obx(
                            () => SizedBox(
                              width: controller.model.showBtn.value ? 16 : 0,
                            ),
                          ),
                          Obx((() => controller.model.showBtn.value
                              ? GestureDetector(
                                  onTap: () async {
                                    await controller.sendMessage();
                                  },
                                  child: Image.asset(
                                    'assets/images/send.png',
                                    width: 20,
                                    height: 20,
                                  ))
                              : SizedBox()))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
              bottom: 160,
              right: 16,
              child: Obx(() => controller.model.showScrollBottom.value
                  ? FloatingActionButton.small(
                      onPressed: () {
                        controller.scrollDown();

                      },
                      child: Icon(Icons.arrow_downward_outlined),
                      backgroundColor: ColorFontUtil.redF5,
                    )
                  : SizedBox())),
        ],
      ),
    );
  }
}
