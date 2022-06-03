class ConfigModel {
  String? deliveryFee;
  String? deliveryTime;

  ConfigModel({
    this.deliveryFee,
    this.deliveryTime,
  });

  ConfigModel.fromMap(Map<String, dynamic> map) {
    deliveryFee = map['deliveryFee'];
    deliveryTime = map['deliveryTime'];
  }
}
