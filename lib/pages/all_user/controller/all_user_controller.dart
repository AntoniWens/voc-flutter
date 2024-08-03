
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:voc/local_service/all_chat.dart';
import 'package:voc/local_service/local_service.dart';

import '../../../api_service/response/all_users_response.dart';
import '../../../api_service/user_service.dart';
import '../../../preferences.dart';
import '../model/all_user_model.dart';

class AllUserController extends GetxController {
  final model = AllUserModel();

  final searchFocus = FocusNode();

  late UserService userService;

  void setInSearch(bool inSearch, BuildContext context) {
    model.inSearch.value = inSearch;
    model.inSearch.refresh();
    if (inSearch) {
      searchFocus.requestFocus();
    }
  }

  Future<void> allUsers() async {
    final response = await userService.allUsers();

    if (response.runtimeType == AllUsersResponse) {
      final allRes = response as AllUsersResponse;
      if (!allRes.error) {
        model.allUsers.value = allRes.data;
        model.allUsers.refresh();
      }
    }
  }

  Future<AllChat?> getChat(String receiverId) async {
    return await LocalService.getChat(receiverId, Preferences.getUser()['id']);
  }

  @override
  void onReady() {

    allUsers();
    super.onReady();
  }
  @override
  void onInit() {
    userService = UserService(Preferences.getToken());
    super.onInit();
  }
}