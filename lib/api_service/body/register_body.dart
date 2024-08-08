class RegisterBody {
  String otp;
  String countryCode;
  String phoneNumber;
  String password;
  String email;
  String fullName;
  String role;
  String language;
  String nationality;
  String token;

  RegisterBody(this.otp, this.countryCode, this.phoneNumber, this.password,
      this.email, this.fullName, this.role, this.language, this.nationality, this.token);

  Map<String,dynamic> toJson() => {
    'otp': otp,
    'country_code': countryCode,
    'phone_number': phoneNumber,
    'password': password,
    'email': email,
    'full_name': fullName,
    'role': role,
    'language': language,
    'nationality': nationality,
    'token': token
  };
}