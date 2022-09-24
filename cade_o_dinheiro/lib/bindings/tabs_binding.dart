import 'package:cade_o_dinheiro/controllers/home_controller.dart';
import 'package:cade_o_dinheiro/controllers/tabs_controller.dart';
import 'package:cade_o_dinheiro/controllers/wallets_controller.dart';
import 'package:cade_o_dinheiro/repositories/wallets_repository.dart';
import 'package:get/get.dart';

class TabsBinding implements Bindings {
  @override
  void dependencies () {
    Get.lazyPut<TabsController>(() => TabsController());

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<WalletsController>(() => WalletsController());

    Get.lazyPut<WalletsRepository>(() => WalletsRepository());
  }
}