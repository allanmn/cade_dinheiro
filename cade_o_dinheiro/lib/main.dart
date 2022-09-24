import 'package:cade_o_dinheiro/routes/app_pages.dart';
import 'package:cade_o_dinheiro/routes/app_routes.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(GetMaterialApp(
    title: 'Cade o dinheiro?',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.define(),
    initialRoute: Routes.HOME,
    getPages: AppPages.routes,
  ));
}