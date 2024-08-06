
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voc/fcm_service.dart';
import 'package:voc/preferences.dart';
import 'package:voc/route_management/app_routes.dart';
import 'package:voc/route_management/routes.dart';

import 'app_translate.dart';
import 'firebase_options.dart';
import 'notification_service.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FcmService.onBackgroundMessage();
  await NotificationService.initializeLocalNotifications();
  await Preferences.init();

  var login = false;

  if (Preferences.getToken().isEmpty) {
    login = false;
  } else {
    login = true;
  }

  runApp( MyApp(login: login));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.login});

  final bool login;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslate(),
      locale: Get.deviceLocale,
      initialRoute: login ? Routes.mainPage : Routes.login,
      getPages: AppRoutes.pages,
    );
  }
}
