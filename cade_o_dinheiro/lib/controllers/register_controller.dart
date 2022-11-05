import 'package:cade_o_dinheiro/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  register () {
    if (loading.isTrue) return;
    if (formKey.currentState!.validate()) {
      loading.value = true;
      AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
      loading.value = false;
    }
  }
}
