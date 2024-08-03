
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voc/preferences.dart';
import 'package:voc/route_management/app_routes.dart';
import 'package:voc/route_management/routes.dart';

import 'app_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialRoute: login ? Routes.home : Routes.login,
      getPages: AppRoutes.pages,
    );
  }
}
