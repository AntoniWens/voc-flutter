class UserM {
  String id;
  String countryCode;
  String phoneNumber;
  String email;
  String fullName;
  String role;
  String language;
  String nationality;

  UserM({
    required this.id,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.fullName,
    required this.role,
    required this.language,
    required this.nationality,
  });

  factory UserM.fromJson(Map<String, dynamic> json) => UserM(
    id: json["id"],
    countryCode: json["country_code"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    fullName: json["full_name"],
    role: json["role"],
    language: json["language"],
    nationality: json["nationality"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_code": countryCode,
    "phone_number": phoneNumber,
    "email": email,
    "full_name": fullName,
    "role": role,
    "language": language,
    "nationality": nationality,
  };
}