import 'package:cade_o_dinheiro/controllers/home_controller.dart';
import 'package:cade_o_dinheiro/controllers/tabs_controller.dart';
import 'package:cade_o_dinheiro/helpers/helpers.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  @override
  var controller = Get.find<HomeController>();
  var tabsController = Get.find<TabsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Seu saldo',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Stack(
                                children: [
                                  Visibility(
                                    visible: controller.showMoney.isTrue,
                                    child: Text(
                                      Helpers.currencyFormat(
                                          controller.totalWallets.value),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: controller.showMoney.isFalse,
                                    child: const Text(
                                      'R\$ ****, **',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(
                              () => Stack(
                                children: [
                                  Visibility(
                                    visible: controller.showMoney.isTrue,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.showMoney.value = false;
                                      },
                                      icon: const Icon(
                                        Icons.visibility_off,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: controller.showMoney.isFalse,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.showMoney.value = true;
                                      },
                                      icon: const Icon(
                                        Icons.visibility,
                                        size: 30,
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
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed('/settings');
                          },
                          icon: const Icon(
                            Icons.settings,
                            size: 35,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        tabsController.currentIndex.value = 1;
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.wallet,
                                  size: 25,
                                ),
                                Text(
                                  'Carteiras',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tabsController.changePage(2);
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.piggyBank,
                                  size: 25,
                                ),
                                Text(
                                  'Or??amentos',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tabsController.currentIndex.value = 3;
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.fileExcel,
                                  size: 25,
                                ),
                                Text(
                                  'Transa????es',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
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
    );
  }
}
