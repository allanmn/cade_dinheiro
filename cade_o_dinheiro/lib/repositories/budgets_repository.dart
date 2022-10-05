import 'package:get/get.dart';
import 'package:cade_o_dinheiro/models/budget_model.dart';

class BudgetsRepository {

  var budgets = <BudgetModel>[].obs;

  create (BudgetModel budget) {
    budgets.add(budget);
  }

  remove (BudgetModel budget) {
    budgets.remove(budget);
  }
}