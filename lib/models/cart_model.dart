class CartItem {
  Map<int, dynamic>? additional;
  int? amount;
  String? name;
  String? price;
  String? size;

  CartItem({
    this.additional,
    required this.amount,
    required this.name,
    required this.price,
    required this.size,
  });

  CartItem.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    additional = map['additional'];
    amount = map['amount'];
    price = map['price'];
    size = map['size'];
  }
}
