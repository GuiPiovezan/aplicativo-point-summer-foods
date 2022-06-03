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
  DateTime? dateOrder;
  TypePayment? typePayment;
  String? moneyChange;
  String? cardFlag;
  String? cardPayment;
  Map<dynamic, dynamic>? itens;

  OrderModel(
      {this.id,
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
      this.itens});
}
