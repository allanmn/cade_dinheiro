import 'package:cade_o_dinheiro/repositories/transactions_repository.dart';
import 'package:cade_o_dinheiro/repositories/budgets_repository.dart';
import 'package:cade_o_dinheiro/repositories/wallets_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var budgetRepository = Get.find<BudgetsRepository>();
  var walletRepository = Get.find<WalletsRepository>();
  var transactionRepository = Get.find<TransactionsRepository>();

  var showMoney = true.obs;
  var totalWallets = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();

    await getBudgets();

    await getWallets();

    await listenWallets();

    await getTotalWallets();
  }

  listenWallets () async {
    walletRepository.wallets.listen((p0) async {
      await getTotalWallets();
    });
  }

  getBudgets () async {
    budgetRepository.getAll();
  }

  getWallets () async {
    walletRepository.getAll();
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
