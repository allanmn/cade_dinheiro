import 'package:cade_o_dinheiro/database/db.dart';
import 'package:cade_o_dinheiro/helpers/helpers.dart';
import 'package:cade_o_dinheiro/models/transaction_model.dart';
import 'package:cade_o_dinheiro/repositories/budgets_repository.dart';
import 'package:cade_o_dinheiro/repositories/wallets_repository.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';

class TransactionsRepository {
  late Database db;

  var transactions = <TransactionModel>[].obs;

  getAll() async {
    var walletRepository = WalletsRepository();
    var budgetRepository = BudgetsRepository();
    db = await DB.instance.database;

    var response = await db.query('transactions');

    response.forEach((element) async {
      var transaction = TransactionModel.fromJson(element);

      if (transaction.walletId != null) {
        var wallet = await walletRepository.find(transaction.walletId!);
        transaction.wallet = wallet;
      }

      if (transaction.budgetId != null) {
        var budget = await budgetRepository.find(transaction.budgetId!);
        transaction.budget = budget;
      }

      transactions.add(transaction);
    });
  }

  add(TransactionModel transaction) async {
    var walletRepository = Get.find<WalletsRepository>();
    db = await DB.instance.database;

    var response = await walletRepository.verifyTotal(
        transaction.walletId!, transaction.total);

    if (response == true) {
      await db.insert('transactions', transaction.toJson());

      await getAll();

      Helpers.toast(
        title: 'Adicionado com sucesso',
        message: 'Transação adicionada com sucesso.',
        color: AppTheme.colors.success,
      );
    } else {
      Helpers.toast(
        title: 'Saldo insuficiente',
        message: "Saldo insuficiente na carteira ${transaction.wallet?.name}",
        backgroundColor: AppTheme.colors.danger,
      );
    }
  }

  update(TransactionModel transaction) async {
    db = await DB.instance.database;

    await db.update('transactions', transaction.toJson(),
        where: 'id = ?', whereArgs: [transaction.id]);
  }

  remove(TransactionModel transaction) async {
    db = await DB.instance.database;

    db.delete('transactions', where: 'id = ?', whereArgs: [transaction.id]);
    transactions.remove(transaction);
  }
}
