import 'package:cade_o_dinheiro/controllers/register_controller.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  var controller = Get.find<RegisterController>();

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
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AppTheme.colors.dark,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          extendBodyBehindAppBar: true,
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
                                    return 'E-mail é inválido';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: AppTheme.colors.primary,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
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
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Senha é obrigatório';
                                  }
                                  if (value.length < 8) {
                                    return 'Senha deve ter ao menos 8 caracteres';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Senha',
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: AppTheme.colors.primary,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
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
                            ],
                          ),
                        ),
                      ),
                    ],
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
                          controller.register();
                        },
                        child: Stack(
                          children: [
                            if (controller.loading.isFalse)
                              const Text(
                                'CRIAR CONTA',
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
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Entre utilizando sua conta do Google',
                        style: TextStyle(
                          color: AppTheme.colors.secondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 25,
                          backgroundImage: AssetImage(
                            'assets/images/google.png',
                          ),
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
