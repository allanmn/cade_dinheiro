import 'package:cade_o_dinheiro/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies () {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}