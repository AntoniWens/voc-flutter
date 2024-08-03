class SendOtpBody {
  String countryCode;
  String phoneNumber;
  String email;
  String type;

  SendOtpBody(this.countryCode, this.phoneNumber, this.email, this.type);

  Map<String, dynamic> toJson() => {
    'country_code': countryCode,
    'phone_number': phoneNumber,
    'email': email,
    'type': type
  };
}