import 'package:cade_o_dinheiro/models/budget_model.dart';
import 'package:get/get.dart';

class BudgetRepository {

  var budgets = <BudgetModel>[].obs;

  create (BudgetModel wallet) {
    budgets.add(wallet);
  }

  remove (BudgetModel wallet) {
    budgets.remove(wallet);
  }
}