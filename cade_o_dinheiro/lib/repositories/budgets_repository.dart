import 'package:get/get.dart';
import 'package:cade_o_dinheiro/database/db.dart';
import 'package:cade_o_dinheiro/models/budget_model.dart';
import 'package:sqflite/sqlite_api.dart';

class BudgetsRepository {
  late Database db;
  var budgets = <BudgetModel>[].obs;

  getAll() async {
    db = await DB.instance.database;

    var response = await db.query('budgets');

    budgets.addAll(response.map<BudgetModel>((e) => BudgetModel.fromJson(e)));
  }

  add(BudgetModel budget) async {
    db = await DB.instance.database;

    await db.insert('budgets', budget.toJson());
    budgets.add(budget);
  }

  create (BudgetModel budget) {
    budgets.add(budget);
  }

  remove (BudgetModel budget) async {
    db = await DB.instance.database;

    db.delete('budgets', where: 'id = ?', whereArgs: [budget.id]);
    budgets.remove(budget);
  }

  update(BudgetModel budgetModel) async {
    db = await DB.instance.database;

    print(budgetModel.id);
    db.update('budgets', budgetModel.toJson(),
        where: 'id = ?', whereArgs: [budgetModel.id]);
  }
}