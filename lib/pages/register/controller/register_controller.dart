
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../api_service/auth.dart';
import '../../../api_service/body/send_otp_body.dart';
import '../../../api_service/response/default_response.dart';
import '../../../api_service/response/role_lg_nt_response.dart';
import '../../../api_service/util_service.dart';
import '../../../route_management/routes.dart';
import '../model/register_model.dart';

class RegisterController extends GetxController {
  final model = RegisterModel();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();

  final utilService = UtilService();
  final authService = Auth();

  void setVisibilityPassword() {
    model.passwordObscure.value = !model.passwordObscure.value;
    model.passwordObscure.refresh();
  }

  void setVisibilityPasswordC() {
    model.passwordConfObscure.value = !model.passwordConfObscure.value;
    model.passwordConfObscure.refresh();
  }

  void setPhoneCode(String code) {
    model.phoneCode.value = '+$code';
    model.phoneCode.refresh();
  }

  void setSelectedRole(String value, int id) {
    model.selectedRole.value = value;
    model.selectedRoleID = id;
    model.selectedRole.refresh();
  }

  void setSelectedLanguage(String value, int id) {
    model.selectedLanguage.value = value;
    model.selectedLanguageID = id;
    model.selectedLanguage.refresh();
  }

  void setSelectedNation(String value, int id) {
    model.selectedNation.value = value;
    model.selectedNationID = id;
    model.selectedNation.refresh();
  }

  void checkEmpty() {
    model.isEmpty.value = phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confPasswordController.text.isEmpty ||
        emailController.text.isEmpty ||
        fullNameController.text.isEmpty ||
        model.selectedRole.value.isEmpty ||
        model.selectedLanguage.value.isEmpty ||
        model.selectedNation.value.isEmpty || model.passwordErr.value != null || model.passwordConfErr.value != null || model.emailErr.value != null;
    model.isEmpty.refresh();
  }

  void passwordValidation(String value) {
    final reg =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isNotEmpty) {
      if (!reg.hasMatch(value)) {
        model.passwordErr.value =
            'Password should contain at least one upper case, lower case, number and symbol';
      } else {
        model.passwordErr.value = null;
      }
    } else {
      model.passwordErr.value = null;
    }

    model.passwordErr.refresh();
  }

  void emailValidation(String value) {
    final reg =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isNotEmpty) {
      if (!reg.hasMatch(value)) {
        model.emailErr.value =
        'Wrong email format';
      } else {
        model.emailErr.value = null;
      }
    } else {
      model.emailErr.value = null;
    }

    model.emailErr.refresh();
  }

  void passwordConfirmation(String value) {
    if (passwordController.text != value) {
      model.passwordConfErr.value = 'Password not match';
    } else {
      model.passwordConfErr.value = null;
    }
    model.passwordConfErr.refresh();
  }

  Future<void> getRoleLgNt() async {
    final response = await utilService.getRoleLgNt();
    if (response.runtimeType == RoleLgNtResponse) {
      final roleRes = response as RoleLgNtResponse;

      if (!roleRes.error) {
        model.roles.value = roleRes.data.role;
        model.language.value = roleRes.data.language;
        model.nation.value = roleRes.data.nation;

        model.roles.refresh();
        model.language.refresh();
        model.nation.refresh();
      }
    } else {
      print(response.toString());
    }
  }

  Future<void> sendOtp() async {
    model.isLoading.value = true;
    final body =
        SendOtpBody(model.phoneCode.value, phoneController.text.toString(), emailController.text.toString(), 'sms');
    final response = await authService.sendOtp(body);
    model.isLoading.value = false;
    if (response.runtimeType == DefaultResponse) {
      final sendRes = response as DefaultResponse;
      if (!sendRes.error) {
        Get.toNamed(Routes.phoneVerification, arguments: {
          'country_code': model.phoneCode.value,
          'phone_number': phoneController.text.toString(),
          'password': passwordController.text.toString(),
          'email': emailController.text.toString(),
          'full_name': fullNameController.text.toString(),
          'role': model.selectedRoleID.toString(),
          'language': model.selectedLanguageID.toString(),
          'nationality': model.selectedNationID.toString()
        });
      } else {
        Fluttertoast.showToast(msg: sendRes.message);
      }
    } else {
      Fluttertoast.showToast(msg: response.toString());
    }
    model.isLoading.refresh();
  }

  @override
  void onInit() {
    getRoleLgNt();
    super.onInit();
  }
}
