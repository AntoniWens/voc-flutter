import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

import '../../../api_service/response/role_lg_nt_response.dart';

class RegisterModel {
  RxString selectedRole = ''.obs;
  RxString selectedLanguage = ''.obs;
  RxString selectedNation = ''.obs;
  int selectedRoleID = 00;
  int selectedLanguageID = 00;
  int selectedNationID = 00;
  RxString phoneCode = '+62'.obs;

  RxBool passwordObscure = true.obs;
  RxBool passwordConfObscure = true.obs;

  RxBool isLoading = false.obs;

  Rx<String?> passwordErr = Rx(null);
  Rx<String?> passwordConfErr = Rx(null);
  Rx<String?> emailErr = Rx(null);

  RxBool isEmpty = true.obs;

  RxList<Role> roles = <Role>[].obs;
  RxList<Language> language = <Language>[].obs;
  RxList<Nation> nation = <Nation>[].obs;
}