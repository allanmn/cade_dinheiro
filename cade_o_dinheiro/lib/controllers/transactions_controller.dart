import 'package:cade_o_dinheiro/controllers/home_controller.dart';
import 'package:cade_o_dinheiro/helpers/helpers.dart';
import 'package:cade_o_dinheiro/models/transaction_model.dart';
import 'package:cade_o_dinheiro/repositories/transactions_repository.dart';
import 'package:cade_o_dinheiro/repositories/wallets_repository.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:cade_o_dinheiro/widgets/create_transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  var transactionRepository = Get.find<TransactionsRepository>();
  var walletRepository = Get.find<WalletsRepository>();
  var homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
  }

  openCreateModal(TransactionModel? transaction) async {
    var result;
    if (transaction != null) {
      result = await Get.bottomSheet(
        CreateTransaction(
          transaction: transaction,
        ),
        isScrollControlled: true,
        backgroundColor: Colors.white,
      );
    } else {
      result = await Get.bottomSheet(
        CreateTransaction(),
        isScrollControlled: true,
        backgroundColor: Colors.white,
      );
    }

    if (transaction == null && result != null && result is TransactionModel) {
      transactionRepository.add(result);
    }

    if (result != null && result is String && result == 'excluir') {
      transactionRepository.remove(transaction!);
      Helpers.toast(
        title: 'Removido com sucesso',
        message: 'Transação removida com sucesso.',
        color: AppTheme.colors.success,
      );
    }

    if (transaction != null && result != null && result is TransactionModel) {
      var index = transactionRepository.transactions.indexOf(transaction);
      var newTransaction = TransactionModel(
        id: transaction.id,
        name: result.name,
        total: result.total,
        date: result.date,
        transactionType: result.transactionType,
        walletId: result.wallet?.id,
        budgetId: result.budget?.id,
        wallet: result.wallet,
        budget: result.budget,
      );
      await transactionRepository.update(newTransaction);
      transactionRepository.transactions.insert(index, newTransaction);
      transactionRepository.transactions.remove(transaction);

      Helpers.toast(
        title: 'Atualizado com sucesso',
        message: 'Transação atualizada com sucesso.',
        color: AppTheme.colors.success,
      );
    }

    homeController.getTotalWallets();
  }
}
