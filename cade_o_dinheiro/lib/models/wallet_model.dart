
class WalletModel {
  String name;
  double total;

  WalletModel({
    required this.name,
    required this.total,
  });

  addMoney (double value) {
    total += value;
  }

  removeMoney (double value) {
    total -= value;
  }
}