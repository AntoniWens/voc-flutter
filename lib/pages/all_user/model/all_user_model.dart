import 'package:get/get.dart';
import 'package:voc/api_service/model/user.dart';

import '../../../api_service/model/user_m.dart';
import '../../../api_service/response/all_users_response.dart';
import '../../home/model/chat.dart';

class AllUserModel {
  RxBool inSearch = false.obs;
  RxList<UserM> allUsers = <UserM>[].obs;


}