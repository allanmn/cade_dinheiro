import 'package:get/get.dart';
import 'package:cade_o_dinheiro/models/wallet_model.dart';

class WalletsRepository {

  var wallets = <WalletModel>[].obs;

  create (WalletModel wallet) {
    wallets.add(wallet);
  }

  remove (WalletModel wallet) {
    wallets.remove(wallet);
  }
}