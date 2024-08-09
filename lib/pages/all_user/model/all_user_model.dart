import 'package:get/get.dart';

import '../../../api_service/model/user_m.dart';

class AllUserModel {
  RxBool inSearch = false.obs;
  RxList<UserM> allUsers = <UserM>[].obs;


}