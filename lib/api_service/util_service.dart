import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:voc/api_service/response/role_lg_nt_response.dart';

import '../configuration.dart';


class UtilService {

  Future<Object> getRoleLgNt() async {
    try {
      final response =  await http.get(Uri.parse('${Configuration.baseUrl}api/mobile_api/util/role-lg-nt'), headers: {'Accept': 'application/json'});
      if (kDebugMode) {
        print('response get role : ${response.body}');
      }
      return RoleLgNtResponse.fromJson(jsonDecode(response.body));
    } catch(e){
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }
}
