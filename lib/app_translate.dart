import 'package:get/get.dart';

class AppTranslate extends Translations {
  @override

  Map<String, Map<String, String>> get keys => {
    "en" : id
  };

  final Map<String, String> id = {
    'faq':'FAQ',
    'register_now': 'Register Now',
    'register': 'Register',
    'enter_your_mobile_number': 'Enter Your Mobile Number',
    'we_will_send_you_one_time_code': 'We will send you one time code',
    'start_typing_to_search': 'Start typing to search',
    'enter_verification_code': 'Enter Verification Code',
    'enter_verification_code2': 'We are send to your mobile number',
    'enter_verification_code3': 'We are send verification code to your email',
    'search': 'Search',
    'dont_receive_otp':'Dont receive the OTP ? ',
    'resend': 'RESEND',
    'by_continuing_you_agree_to_translator': 'By Continuing you agree to Translator',
    'terms_of_user_privacy_policy' : '\nTerms of User & Privacy Policy',
    'phone_verification': 'Phone Verification',
    'email_verification': 'Email Verification',
    'login': 'Login',
    'please_fill_your_information': 'Please fill your information',
    'phone_number_label': 'Phone Number',
    'email_hint': 'Enter email',
    'email_label': 'Email',
    'home':'Home',
    'profile':'Profile',
    'full_name_hint': 'Enter your name',
    'full_name_label': 'Full Name',
    'password_conf_label': 'Password Confirmation',
    'password_hint': 'Enter password',
    'password_label': 'Password',
    'password_conf_hint': 'Enter again password',
    'all_user': 'All User'
  };

}