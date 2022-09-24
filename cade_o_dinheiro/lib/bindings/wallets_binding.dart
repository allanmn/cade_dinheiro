import 'package:cade_o_dinheiro/controllers/wallets_controller.dart';
import 'package:get/get.dart';

class WalletsBinding implements Bindings {
  @override
  void dependencies () {
    Get.lazyPut<WalletsController>(() => WalletsController());
  }
}