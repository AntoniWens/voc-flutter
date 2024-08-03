

import 'package:voc/api_service/model/user_m.dart';

class AllUsersResponse {
  bool error;
  String message;
  List<UserM> data;

  AllUsersResponse({
    required this.error,
    required this.message,
    required this.data
  });

  factory AllUsersResponse.fromJson(Map<String, dynamic> json) => AllUsersResponse(
    error: json['error'],
    message: json['message'], data: List<UserM>.from(json["data"].map((x) => UserM.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}