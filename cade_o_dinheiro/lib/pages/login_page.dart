import 'package:cade_o_dinheiro/controllers/login_controller.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends GetView<LoginController> {
  @override
  var controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.colors.success, AppTheme.colors.warning])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
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
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Olá',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                          Text(
                            'Entre na sua conta!',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppTheme.colors.secondary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Form(
                        key: controller.formKey,
                        child: Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: controller.emailController,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'E-mail é obrigatório';
                                  }
                                  if (EmailValidator.validate(value) == false) {
                                    return 'E-mail inválido';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(Icons.email),
                                    hintText: 'E-mail',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: controller.passwordController,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Senha é obrigatório';
                                  }
                                  if (value.length < 8) {
                                    return 'Senha deve ter ao menos 8 caracteres';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.password),
                                    hintText: 'Senha',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                          controller.login();
                        },
                        child: Obx(
                          () => Stack(
                            children: [
                              if (controller.loading.isFalse)
                                const Text(
                                  'ENTRAR',
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
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Não tem uma conta?  ',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.colors.secondary,
                          ),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed('/register');
                                },
                                child: Text(
                                  'Criar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: AppTheme.colors.secondary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
