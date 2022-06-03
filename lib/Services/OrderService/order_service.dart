import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/Services/CartService/cart_service.dart';
import 'package:pointsf/View/MyOrders/my_orders.dart';
import 'package:pointsf/models/enums/type_payment.dart';
import 'package:pointsf/models/order_model.dart';
import 'package:uuid/uuid.dart';

class OrderService {
  final firestore = FirebaseFirestore.instance;
  final auth = AuthService();
  Map<int, Map<String, dynamic>> orderItens = {};

  double calculateValueTotalOrder(dynamic itens) {
    double valueTotalOrder = 0;

    if (itens.isNotEmpty) {
      int amount;

      for (var i = 0; i < itens.length; i++) {
        double priceTotalProducts = 0;

        String price = (itens[i]['preco'] as String).replaceAll(",", ".");
        priceTotalProducts = double.parse(price);
        amount = itens[i]['quantidade'];

        double priceTotalAdditional = 0;
        for (var j = 0; j < itens[i]['adicionais'].length; j++) {
          String price = (itens[i]['adicionais'][j]['preco'] as String)
              .replaceAll(",", ".");

          priceTotalAdditional += double.parse(price);
        }

        valueTotalOrder += (priceTotalProducts + priceTotalAdditional) * amount;
      }

      return valueTotalOrder;
    }

    return valueTotalOrder;
  }

  save(OrderModel model, BuildContext context) async {
    var uuidOrder = const Uuid().v1();

    try {
      await firestore.collection('pedidos').doc(uuidOrder).set({
        "uid": uuidOrder,
        "uidUsuario": auth.getUid(),
        "usuario": model.userName,
        "email": model.userEmail,
        "telefone": model.userPhone,
        "endereco": model.address!.logradouro,
        "numero": model.address!.numero,
        "bairro": model.address!.bairro,
        "cep": model.address!.cep,
        "cidade": model.address!.cidade,
        "complemento": model.address!.complemento,
        "valorTotalProdutos": model.valueTotal,
        "taxaEntrega": model.valueDelivery,
        "data": model.dateOrder,
        "tipoPagamento":
            model.typePayment == TypePayment.money ? 'Dinheiro' : 'Cartão',
        "troco": model.typePayment == TypePayment.money ? model.moneyChange : 0,
        "bandeira":
            model.typePayment == TypePayment.cardCredit ? model.cardFlag : '',
        "pagamento": model.typePayment == TypePayment.cardCredit
            ? model.cardPayment
            : '',
      });

      for (var i = 0; i < model.itens!.length; i++) {
        var uuidItems = const Uuid().v1();
        await firestore
            .collection('pedidos')
            .doc(uuidOrder)
            .collection("items")
            .doc(uuidItems)
            .set(
          {
            "preco": model.itens![i]!["preco"],
            "quantidade": model.itens![i]!["quantidade"].toString(),
            "tamanho": model.itens![i]!["size"],
            "produto": model.itens![i]!["produto"],
            "uid": uuidItems,
          },
        );

        for (var j = 0; j < model.itens![i]["adicionais"]!.length; j++) {
          var uuidAdicional = const Uuid().v1();
          await firestore
              .collection('pedidos')
              .doc(uuidOrder)
              .collection("items")
              .doc(uuidItems)
              .collection("adicionais")
              .doc(uuidAdicional)
              .set(
            {
              "preco": model.itens![i]!["adicionais"][j]["preco"],
              "adicional": model.itens![i]!["adicionais"][j]["adicional"],
              "uid": uuidAdicional,
            },
          );
        }
      }
      CartService().removeAllItemFromCard();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyOrders(),
        ),
      );
    } on FirebaseException catch (ex) {
      throw Exception(ex.message);
    }
  }

  getMyOrders() {
    return firestore
        .collection('pedidos')
        .where("uidUsuario", isEqualTo: auth.getUid())
        .snapshots();
  }

  setMyOrdersItens(uid) async {
    print(uid);
    await firestore
        .collection('pedidos')
        .doc(uid)
        .collection("items")
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        orderItens[i] = value.docs[i].data();
      }
    });
    for (var i = 0; i < orderItens.length; i++) {
      Map<int, Map<String, dynamic>> additionalItem = {};

      await firestore
          .collection("pedidos")
          .doc(uid)
          .collection("items")
          .doc(orderItens[i]!["uid"])
          .collection("adicionais")
          .get()
          .then((value) {
        for (var x = 0; x < value.docs.length; x++) {
          additionalItem[x] = value.docs[x].data();
        }
        orderItens[i]!["adicionais"] = additionalItem;
      });
    }
  }

  getOrderItens() {
    return orderItens;
  }
}
