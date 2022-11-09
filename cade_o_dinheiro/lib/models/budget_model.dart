import 'package:cade_o_dinheiro/repositories/transactions_repository.dart';
import 'package:get/get.dart';

class BudgetModel {
  var transactionsRepository = Get.find<TransactionsRepository>();

  int? id;
  String name;
  double total;
  String goal;

  BudgetModel({
    this.id,
    required this.name,
    required this.total,
    required this.goal,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) => BudgetModel(
    name: json["name"],
    total: json["value"],
    id: json["id"],
    goal: json["goal"],
  );

    Map<String, dynamic> toJson () {
    return {
      'id': id,
      'name': name,
      'value': total,
      'goal' : goal,
    };
  }

  getTotal() {
    double total = 0;

    transactionsRepository.transactions.forEach((element) {
      if (element.budget.name == name) {
        total += element.total;
      }
    });

    return total;
  }

  getTotalPercentage() {
    double total = 0;

    transactionsRepository.transactions.forEach((element) {
      if (element.budget.name == name) {
        total += element.total;
      }
    });

    var value = total / this.total;

    return value > 1 ? 1 : value;
  }
}
