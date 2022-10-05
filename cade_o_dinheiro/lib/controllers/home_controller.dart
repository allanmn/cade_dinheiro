import 'package:cade_o_dinheiro/repositories/transactions_repository.dart';
import 'package:cade_o_dinheiro/repositories/wallets_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var walletRepository = Get.find<WalletsRepository>();
  var transactionRepository = Get.find<TransactionsRepository>();

  var showMoney = true.obs;
  var totalWallets = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    getTotalWallets();
  }

  getTotalWallets() {
    totalWallets.value = 0;
    walletRepository.wallets.forEach((element) {
      totalWallets.value += element.total;
    });

    transactionRepository.transactions.forEach((element) {
      totalWallets.value -= element.total;
    });
  }
}
