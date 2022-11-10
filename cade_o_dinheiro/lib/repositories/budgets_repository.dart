import 'package:cade_o_dinheiro/database/db.dart';
import 'package:get/get.dart';
import 'package:cade_o_dinheiro/models/budget_model.dart';
import 'package:sqflite/sqlite_api.dart';

class BudgetsRepository {
  late Database db;
  var budgets = <BudgetModel>[].obs;

  getAll() async {
    db = await DB.instance.database;

    var response = await db.query('budgets');

    budgets.clear();

    budgets.addAll(response.map<BudgetModel>((e) => BudgetModel.fromJson(e)));
  }

  find(int id) async {
    db = await DB.instance.database;

    var response = await db.query('budgets', where: 'id = ?', whereArgs: [id]);

    if (response[0]['id'] != null) return BudgetModel.fromJson(response[0]);

    return null;
  }

  add(BudgetModel budget) async {
    db = await DB.instance.database;

    await db.insert('budgets', budget.toJson());

    budgets.add(budget);
  }

  update(BudgetModel budget) async {
    db = await DB.instance.database;

    await db.update('budgets', budget.toJson(),
        where: 'id = ?', whereArgs: [budget.id]);
  }

  remove(BudgetModel budget) async {
    db = await DB.instance.database;

    db.delete('budgets', where: 'id = ?', whereArgs: [budget.id]);
    budgets.remove(budget);
  }
}
