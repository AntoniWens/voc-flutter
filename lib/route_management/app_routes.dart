
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:voc/pages/syncing/binding/syncing_binding.dart';
import 'package:voc/pages/syncing/syncing_screen.dart';
import 'package:voc/route_management/routes.dart';

import '../pages/all_user/all_user_screen.dart';
import '../pages/all_user/bindings/all_user_binding.dart';
import '../pages/chat/bindings/chat_bindings.dart';
import '../pages/chat/chat_screen.dart';
import '../pages/email_verification/binding/email_verification_binding.dart';
import '../pages/email_verification/email_verification_screen.dart';
import '../pages/home/bindings/home_binding.dart';
import '../pages/home/home_screen.dart';
import '../pages/login/binding/login_binding.dart';
import '../pages/login/login_screen.dart';
import '../pages/main_page/binding/main_page_binding.dart';
import '../pages/main_page/main_page_screen.dart';
import '../pages/phone_verification/binding/phone_verification_binding.dart';
import '../pages/phone_verification/phone_verification_screen.dart';
import '../pages/register/binding/register_bindings.dart';
import '../pages/register/register_screen.dart';

class AppRoutes {

  static List<GetPage> pages = [
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
      binding: RegisterBindings()
    ),

    GetPage(
        name: Routes.login,
        page: () => const LoginScreen(),
        binding: LoginBinding()
    ),
    GetPage(
        name: Routes.phoneVerification,
        page: () => const PhoneVerification(),
        binding: PhoneVerificationBinding()
    ),
    GetPage(
        name: Routes.mainPage,
        page: () =>  const MainPageScreen(),
        binding: MainPageBinding()
    ),
    GetPage(
        name: Routes.home,
        page: () =>  HomeScreen(),
        binding: HomeBinding()
    ),
    GetPage(
        name: Routes.chat,
        page: () => const ChatScreen(),
        binding: ChatBindings()
    ),
    GetPage(
        name: Routes.emailVerification,
        page: () => const EmailVerificationScreen(),
        binding: EmailVerificationBinding()
    ),
    GetPage(
        name: Routes.allUser,
        page: () => const AllUserScreen(),
        binding: AllUserBinding()
    ),
    GetPage(
        name: Routes.syncing,
        page: () => const SyncingScreen(),
        binding: SyncingBinding()
    ),
  ];
}