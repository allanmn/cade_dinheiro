import 'package:cade_o_dinheiro/controllers/budgets_controller.dart';
import 'package:cade_o_dinheiro/helpers/helpers.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BudgetsPage extends GetView<BudgetsController> {
  @override
  var controller = Get.find<BudgetsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.light,
        elevation: 0,
        title: const Text(
          'Orçamentos',
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
                          'Novo orçamento',
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
                      visible: controller.budgetsRepository.budgets.isEmpty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Nenhum orçamento cadastrado :('),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.budgetsRepository.budgets.isNotEmpty,
                      child: Obx(
                        () => ListView.builder(
                          itemCount:
                              controller.budgetsRepository.budgets.length,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var budget =
                                controller.budgetsRepository.budgets[index];
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
                                                  budget.total,
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
                                            height: 10,
                                          ),
                                          Obx(
                                            () => Visibility(
                                              visible: budget
                                                      .transactionsRepository
                                                      .transactions
                                                      .isEmpty ||
                                                  budget.transactionsRepository
                                                      .transactions.isNotEmpty,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  LinearProgressIndicator(
                                                    value: budget
                                                        .getTotalPercentage(),
                                                    backgroundColor:
                                                        Colors.grey,
                                                    color: Colors.greenAccent,
                                                  ),
                                                  Text(
                                                    "${Helpers.currencyFormat(budget.getTotal())} de ${Helpers.currencyFormat(budget.total)}",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                budget.name,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller
                                                      .openCreateModal(budget);
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
