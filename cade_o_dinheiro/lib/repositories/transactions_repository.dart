import 'package:cade_o_dinheiro/models/transaction_model.dart';
import 'package:get/get.dart';

class TransactionsRepository {

  var transactions = <TransactionModel>[].obs;

  create (TransactionModel transaction) {
    transactions.add(transaction);
  }

  remove (TransactionModel transaction) {
    transactions.remove(transaction);
  }
}