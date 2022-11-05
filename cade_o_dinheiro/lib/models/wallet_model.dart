class WalletModel {
  int? id;
  String name;
  double total;

  WalletModel({
    this.id,
    required this.name,
    required this.total,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        name: json["name"],
        total: json["value"],
        id: json["id"],
      );

  Map<String, dynamic> toJson () {
    return {
      'id': id,
      'name': name,
      'value': total,
    };
  }

  addMoney(double value) {
    total += value;
  }

  removeMoney(double value) {
    total -= value;
  }
}
