import 'package:cade_o_dinheiro/controllers/register_controller.dart';
import 'package:cade_o_dinheiro/controllers/settings_controller.dart';
import 'package:get/get.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies () {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}