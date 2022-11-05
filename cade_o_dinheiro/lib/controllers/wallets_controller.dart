import 'package:cade_o_dinheiro/controllers/home_controller.dart';
import 'package:cade_o_dinheiro/helpers/helpers.dart';
import 'package:cade_o_dinheiro/models/wallet_model.dart';
import 'package:cade_o_dinheiro/repositories/wallets_repository.dart';
import 'package:cade_o_dinheiro/theme/app_theme.dart';
import 'package:cade_o_dinheiro/widgets/create_wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletsController extends GetxController {
  var walletRepository = Get.find<WalletsRepository>();
  var homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
  }

  openCreateModal(WalletModel? wallet) async {
    var result;
    if (wallet != null) {
      result = await Get.bottomSheet(
        CreateWallet(
          wallet: wallet,
        ),
        isScrollControlled: true,
        backgroundColor: Colors.white,
      );
    } else {
      result = await Get.bottomSheet(
        CreateWallet(),
        isScrollControlled: true,
        backgroundColor: Colors.white,
      );
    }

    if (wallet == null && result != null && result is WalletModel) {
      walletRepository.add(result);
      Helpers.toast(
        title: 'Adicionado com sucesso',
        message: 'Carteira adicionada com sucesso.',
        color: AppTheme.colors.success,
      );
    }

    if (wallet != null && result != null && result is String && result == 'excluir') {
      await walletRepository.remove(wallet);
      Helpers.toast(
        title: 'Removido com sucesso',
        message: 'Carteira removida com sucesso.',
        color: AppTheme.colors.success,
      );
    }

    if (wallet != null && result != null && result is WalletModel) {
      var index = walletRepository.wallets.indexOf(wallet);
      var newWallet = WalletModel(
        id: result.id,
        name: result.name,
        total: result.total,
      );
      await walletRepository.update(newWallet);
      walletRepository.wallets.insert(index, newWallet);
      walletRepository.wallets.remove(wallet);

      Helpers.toast(
        title: 'Atualizado com sucesso',
        message: 'Carteira atualizada com sucesso.',
        color: AppTheme.colors.success,
      );
    }

    homeController.getTotalWallets();
  }
}
