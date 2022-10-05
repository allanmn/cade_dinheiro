import 'package:cade_o_dinheiro/controllers/budgets_controller.dart';
import 'package:get/get.dart';

class BudgetsBinding implements Bindings {
  @override
  void dependencies () {
    Get.lazyPut<BudgetsController>(() => BudgetsController());
  }
}