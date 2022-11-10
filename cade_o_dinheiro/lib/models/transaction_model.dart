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

  WalletModel? wallet;
  BudgetModel? budget;

  TransactionModel({
    this.id,
    required this.name,
    required this.total,
    required this.transactionType,
    required this.date,
    this.walletId,
    this.budgetId,
    this.wallet,
    this.budget,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        name: json["name"],
        total: json["total"],
        date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
        transactionType: json["transaction_type"],
        budgetId: json["budget_id"],
        walletId: json["wallet_id"],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'total': total,
      'date': date.toUtc().millisecondsSinceEpoch,
      'transaction_type': transactionType,
      'budget_id': budgetId,
      'wallet_id': walletId,
    };
  }
}
