class LoginResponse {
  bool error;
  String message;
  UserData? data;

  LoginResponse({
    required this.error,
    required this.message,
    required this.data
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    error: json['error'],
    message: json['message'], data: json['data'] == null ? null : UserData.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    'data': data?.toJson()
  };
}

class UserData {
  String id;
  String countryCode;
  String phoneNumber;
  String email;
  String fullName;
  String role;
  String language;
  String nationality;
  String token;

  UserData({
    required this.id,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.fullName,
    required this.role,
    required this.language,
    required this.nationality,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    countryCode: json["country_code"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    role: json["role"],
    language: json["language"],
    nationality: json["nationality"],
    token: json["token"], fullName: json['full_name'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_code": countryCode,
    "phone_number": phoneNumber,
    "email": email,
    'full_name': fullName,
    "role": role,
    "language": language,
    "nationality": nationality,
    "token": token,
  };
}