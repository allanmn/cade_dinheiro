import 'package:cade_o_dinheiro/models/budget_model.dart';
import 'package:cade_o_dinheiro/models/wallet_model.dart';

class TransactionModel {
  int? id;
  String name;
  double total;
  String transactionType;
  DateTime date;
  int? walletId;
  int? budgetId;

  WalletModel wallet;
  BudgetModel budget;

  TransactionModel({
    this.id,
    required this.name,
    required this.total,
    required this.transactionType,
    required this.date,
    required this.wallet,
    required this.budget,
  });

  bool operator ==(dynamic other) {
    return other is TransactionModel &&
        name == other.name &&
        total == other.total &&
        transactionType == other.transactionType &&
        date == other.date;
  }

  @override
  int get hashCode {
    // Hash code algorithm derived from https://www.sitepoint.com/how-to-implement-javas-hashcode-correctly/
    int hashCode = 1;
    hashCode = (23 * hashCode) + name.hashCode;
    hashCode = (23 * hashCode) + total.hashCode;
    return hashCode;
  }
}
