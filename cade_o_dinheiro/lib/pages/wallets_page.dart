import 'package:cade_o_dinheiro/controllers/wallets_controller.dart';
import 'package:cade_o_dinheiro/helpers/helpers.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class WalletsPage extends GetView<WalletsController> {
  @override
  var controller = Get.find<WalletsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.light,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Carteiras',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.openCreateModal(null);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppTheme.colors.primary,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Criar nova',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Stack(
                  children: [
                    Visibility(
                      visible: controller.walletRepository.wallets.isEmpty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Nenhuma carteira cadastrada :('),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.walletRepository.wallets.isNotEmpty,
                      child: Obx(
                        () => ListView.builder(
                          itemCount: controller.walletRepository.wallets.length,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var wallet =
                                controller.walletRepository.wallets[index];
                            return Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  color: AppTheme.colors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Total',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                Helpers.currencyFormat(
                                                  wallet.total,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                wallet.name,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller
                                                      .openCreateModal(wallet);
                                                },
                                                child: const FaIcon(
                                                  FontAwesomeIcons.sliders,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
