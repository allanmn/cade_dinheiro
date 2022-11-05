import 'package:cade_o_dinheiro/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  signout() {
    loading.value = true;

    AuthController.instance.logout();

    loading.value = false;
  }
}
