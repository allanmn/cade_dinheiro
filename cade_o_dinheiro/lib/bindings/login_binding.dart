import 'package:cade_o_dinheiro/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies () {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}