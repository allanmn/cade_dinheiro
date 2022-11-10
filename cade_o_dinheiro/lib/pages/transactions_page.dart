import 'package:cade_o_dinheiro/controllers/transactions_controller.dart';
import 'package:cade_o_dinheiro/helpers/helpers.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionsPage extends GetView<TransactionsController> {
  @override
  var controller = Get.find<TransactionsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.light,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Transações',
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
                      visible:
                          controller.transactionRepository.transactions.isEmpty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Nenhuma transação cadastrada :('),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller
                          .transactionRepository.transactions.isNotEmpty,
                      child: Obx(
                        () => ListView.builder(
                          itemCount: controller
                              .transactionRepository.transactions.length,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            var transaction = controller
                                .transactionRepository.transactions[index];
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.openCreateModal(transaction);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transaction.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yyyy')
                                                .format(transaction.date),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Visibility(
                                            visible: transaction.wallet != null,
                                            child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: Colors.lightBlue,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5),
                                                child: Text(
                                                  "${transaction.wallet?.name}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            Helpers.currencyFormat(transaction.total),
                                            style: const TextStyle(
                                              fontSize: 16
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  height: 0,
                                  color: Colors.blueGrey,
                                )
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
