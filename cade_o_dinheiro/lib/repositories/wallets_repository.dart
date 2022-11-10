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

    wallets.clear();

    wallets.addAll(response.map<WalletModel>((e) => WalletModel.fromJson(e)));
  }

  find(int id) async {
    db = await DB.instance.database;

    var response = await db.query('wallets', where: 'id = ?', whereArgs: [id]);

    if (response[0]['id'] != null) return WalletModel.fromJson(response[0]);

    return null;
  }

  add(WalletModel wallet) async {
    db = await DB.instance.database;

    await db.insert('wallets', wallet.toJson());

    wallets.add(wallet);
  }

  remove(WalletModel wallet) async {
    db = await DB.instance.database;

    print(wallet.id);

    db.delete('wallets', where: 'id = ?', whereArgs: [wallet.id]);
    wallets.remove(wallet);
  }

  update(WalletModel walletModel) async {
    db = await DB.instance.database;

    await db.update('wallets', walletModel.toJson(),
        where: 'id = ?', whereArgs: [walletModel.id]);
  }

  verifyTotal(int id, double total) async {
    db = await DB.instance.database;

    var response = await db.query('wallets', where: 'id = ?', whereArgs: [id]);

    if (response[0]["id"] != null) {
      var wallet = WalletModel.fromJson(response[0]);

      if (total <= wallet.total) {
        var index = wallets.indexWhere((element) => element.id == wallet.id);
        wallet.total -= total;
        await db.update('wallets', wallet.toJson(),
            where: 'id = ?', whereArgs: [wallet.id]);
        wallets.insert(index, wallet);
        wallets.remove(wallet);
        return true;
      }
    }
  }
}
