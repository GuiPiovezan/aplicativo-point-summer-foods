import 'package:pointsf/models/address_model.dart';
import 'package:pointsf/models/enums/type_payment.dart';

class OrderModel {
  String? id;
  String? userName;
  String? userEmail;
  String? userPhone;
  AddressModel? address;
  double? valueTotal;
  double? valueDelivery;
  TypePayment? typePayment;
  String? moneyChange;
  String? cardFlag;
  String? cardPayment;
  Map<dynamic, dynamic>? itens;
  DateTime? dateOrder;
  DateTime? pedidoConcluido;
  DateTime? pedidoAceito;

  OrderModel({
    this.id,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.address,
    this.valueTotal,
    this.valueDelivery,
    this.dateOrder,
    this.typePayment,
    this.cardFlag,
    this.cardPayment,
    this.moneyChange,
    this.itens,
    this.pedidoAceito,
    this.pedidoConcluido,
  });

  OrderModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    userName = map["userName"];
    userEmail = map["userEmail"];
    userPhone = map["userPhone"];
    address = map["address"];
    valueTotal = map["valueTotal"];
    valueDelivery = map["valueDelivery"];
    dateOrder = map["dateOrder"];
    typePayment = map["typePayment"];
    cardFlag = map["cardFlag"];
    cardPayment = map["cardPayment"];
    moneyChange = map["moneyChange"];
    itens = map["itens"];
    pedidoAceito = map["pedidoAceito"];
    pedidoConcluido = map["pedidoConcluido"];
  }
}
