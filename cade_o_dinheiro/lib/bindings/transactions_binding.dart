import 'package:cade_o_dinheiro/controllers/transactions_controller.dart';
import 'package:get/get.dart';

class TransactionsBinding implements Bindings {
  @override
  void dependencies () {
    Get.lazyPut<TransactionsController>(() => TransactionsController());
  }
}