import 'package:pointsf/models/address_model.dart';
import 'package:pointsf/models/enums/type_payment.dart';

class OrderModel {
  AddressModel? address;
  String? cardFlag;
  String? cardPayment;
  DateTime? dateOrder;
  DateTime? dateOrderAccepted;
  DateTime? dateOrderSent;
  String? id;
  Map<dynamic, dynamic>? itens;
  String? moneyChange;
  String? status;
  TypePayment? typePayment;
  String? userEmail;
  String? userName;
  String? userPhone;
  double? valueDelivery;
  double? valueTotal;

  OrderModel({
    this.address,
    this.cardFlag,
    this.cardPayment,
    this.dateOrder,
    this.dateOrderAccepted,
    this.dateOrderSent,
    this.id,
    this.itens,
    this.moneyChange,
    this.status,
    this.typePayment,
    this.userEmail,
    this.userName,
    this.userPhone,
    this.valueDelivery,
    this.valueTotal,
  });

  OrderModel.fromMap(Map<String, dynamic> map) {
    address = map["address"];
    cardFlag = map["cardFlag"];
    cardPayment = map["cardPayment"];
    dateOrder = map["dateOrder"];
    dateOrderAccepted = map["dateOrderAccepted"];
    dateOrderSent = map["dateOrderSent"];
    id = map["id"];
    itens = map["itens"];
    moneyChange = map["moneyChange"];
    status = map["status"];
    typePayment = map["typePayment"];
    userEmail = map["userEmail"];
    userName = map["userName"];
    userPhone = map["userPhone"];
    valueDelivery = map["valueDelivery"];
    valueTotal = map["valueTotal"];
  }
}
