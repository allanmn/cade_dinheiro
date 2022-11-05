import 'package:cade_o_dinheiro/controllers/auth_controller.dart';
import 'package:cade_o_dinheiro/controllers/settings_controller.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SettingsPage extends GetView<SettingsController> {
  @override
  var controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppTheme.colors.dark,
        ),
        title: Text(
          'CONFIGURAÇÕES',
          style: TextStyle(
            color: AppTheme.colors.dark,
          ),
        ),
        backgroundColor: AppTheme.colors.light,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Center(
                  child: Image.asset(
                    'assets/icon/icon.png',
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Olá',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AuthController.instance.userEmail,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppTheme.colors.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {
                      controller.signout();
                    },
                    child: Stack(
                      children: [
                        if (controller.loading.isFalse)
                          const Text(
                            'SAIR DA CONTA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (controller.loading.isTrue)
                          RichText(
                            text: TextSpan(
                                text: 'Aguarde  ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: LoadingAnimationWidget.inkDrop(
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ]),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
