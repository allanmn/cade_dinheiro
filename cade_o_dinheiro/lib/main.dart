import 'package:cade_o_dinheiro/controllers/auth_controller.dart';
import 'package:cade_o_dinheiro/firebase_options.dart';
import 'package:cade_o_dinheiro/routes/app_pages.dart';
import 'package:cade_o_dinheiro/routes/app_routes.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();

  await Firebase.initializeApp().then((value) => Get.put(AuthController()));

  runApp(GetMaterialApp(
    title: 'Cade o dinheiro?',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.define(),
    initialRoute: Routes.HOME,
    getPages: AppPages.routes,
  ));
}
