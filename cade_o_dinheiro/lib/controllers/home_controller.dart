import 'package:cade_o_dinheiro/repositories/wallets_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var walletRepository = Get.find<WalletsRepository>();

  var showMoney = true.obs;
  var totalWallets = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    getTotalWallets();
  }

  getTotalWallets() {
    walletRepository.wallets.forEach((element) {
      totalWallets.value += element.total;
    });
  }
}
