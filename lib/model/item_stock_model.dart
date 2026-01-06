class ItemStock {
  final int? id;
  String itemName;
  double qty;
  String unit;
  double rate;
  double amount;
  DateTime date;

  ItemStock({
    this.id,
    required this.itemName,
    required this.qty,
    required this.unit,
    required this.rate,
    required this.amount,
    required this.date,
  });

  factory ItemStock.fromJson(Map<String, dynamic> json) {
    return ItemStock(
      id: json['id'],
      itemName: json['itemName'] ?? '',
      qty: (json['qty'] ?? 0).toDouble(),
      unit: json['unit'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemName': itemName,
      'qty': qty,
      'unit': unit,
      'rate': rate,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}
