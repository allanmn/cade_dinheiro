import 'package:cade_o_dinheiro/database/db.dart';
import 'package:get/get.dart';
import 'package:cade_o_dinheiro/models/wallet_model.dart';
import 'package:sqflite/sqlite_api.dart';

class WalletsRepository {
  late Database db;

  var wallets = <WalletModel>[].obs;

  getAll() async {
    db = await DB.instance.database;

    var response = await db.query('wallets');

    wallets.addAll(response.map<WalletModel>((e) => WalletModel.fromJson(e)));
  }

  add(WalletModel wallet) async {
    db = await DB.instance.database;

    await db.insert('wallets', wallet.toJson());

    wallets.add(wallet);
  }

  create(WalletModel wallet) {
    wallets.add(wallet);
  }

  remove(WalletModel wallet) async {
    db = await DB.instance.database;

    db.delete('wallets', where: 'id = ?', whereArgs: [wallet.id]);
    wallets.remove(wallet);
  }

  update(WalletModel walletModel) async {
    db = await DB.instance.database;

    db.update('wallets', walletModel.toJson(),
        where: 'id = ?', whereArgs: [walletModel.id]);
  }
}
