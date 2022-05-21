import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/models/cart-model.dart';
import 'package:pointsf/Services/AuthService/auth-service.dart';

import 'package:uuid/uuid.dart';

class CartException implements Exception {
  String message;
  CartException(this.message);
}

class CartService extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  _addItemInCard(CartItem item) async {
    var uuid = const Uuid();
    var uidProduct = uuid.v1();

    await firestore
        .collection('usuarios')
        .doc(AuthService().getUid())
        .collection("carrinho")
        .doc(uidProduct)
        .set({
      "produto": item.name,
      "preco": item.price,
      "quantidade": item.amount,
    });

    if (item.additional!.isNotEmpty) {
      for (var i = 0; i < item.additional!.length; i++) {
        var uidAdditional = uuid.v1();

        await firestore
            .collection("usuarios")
            .doc(AuthService().getUid())
            .collection("carrinho")
            .doc(uidProduct)
            .collection("adicionais")
            .doc(uidAdditional)
            .set({
          "adicional": item.additional![i]["nome"],
          "preco": item.additional![i]["preco"],
        });
      }
    }
  }

  setCartItem(
    String product,
    Map<int, dynamic> additional,
    int amount,
    String price,
  ) {
    Map<int, Map<String, dynamic>> additionalCheck = Map();
    int count = 0;

    for (var i = 0; i < additional.length; i++) {
      if (additional[i]["check"]) {
        Map<String, dynamic> additionalCheckItem = Map();
        additionalCheckItem["nome"] = additional[i]["nome"];
        additionalCheckItem["preco"] = additional[i]["preco"];
        additionalCheck[count] = additionalCheckItem;
        count++;
      }
    }
    count = 0;

    CartItem item = CartItem(
      amount: amount,
      additional: additionalCheck,
      name: product,
      price: price,
    );
    _addItemInCard(item);
  }
}
