import 'package:cade_o_dinheiro/controllers/home_controller.dart';
import 'package:cade_o_dinheiro/helpers/helpers.dart';
import 'package:cade_o_dinheiro/models/budget_model.dart';
import 'package:cade_o_dinheiro/repositories/budgets_repository.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:cade_o_dinheiro/widgets/create_budget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetsController extends GetxController {
  var budgetsRepository = Get.find<BudgetsRepository>();
  var homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
  }

  openCreateModal(BudgetModel? budget) async {
    var result;
    if (budget != null) {
      result = await Get.bottomSheet(
        CreateBudget(
          budget: budget,
        ),
        isScrollControlled: true,
        backgroundColor: Colors.white,
      );
    } else {
      result = await Get.bottomSheet(
        CreateBudget(),
        isScrollControlled: true,
        backgroundColor: Colors.white,
      );
    }

    if (budget == null && result != null && result is BudgetModel) {
      budgetsRepository.budgets.add(result);
      Helpers.toast(
        title: 'Adicionado com sucesso',
        message: 'Orçamento adicionado com sucesso.',
        color: AppTheme.colors.success,
      );
    }

    if (result != null && result is String && result == 'excluir') {
      budgetsRepository.budgets.remove(budget);
      Helpers.toast(
        title: 'Removido com sucesso',
        message: 'Orçamento removido com sucesso.',
        color: AppTheme.colors.success,
      );
    }

    if (budget != null && result != null && result is BudgetModel) {
      var index = budgetsRepository.budgets.indexOf(budget);
      var newBudget = BudgetModel(
        name: result.name,
        total: result.total,
        goal: result.goal,
      );
      budgetsRepository.budgets.insert(index, newBudget);
      budgetsRepository.budgets.remove(budget);

      Helpers.toast(
        title: 'Atualizado com sucesso',
        message: 'Orçamento atualizado com sucesso.',
        color: AppTheme.colors.success,
      );
    }

    homeController.getTotalWallets();
  }
}
