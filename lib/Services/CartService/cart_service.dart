import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/models/cart_model.dart';
import 'package:pointsf/Services/AuthService/auth_service.dart';

import 'package:uuid/uuid.dart';

class CartException implements Exception {
  String message;
  CartException(this.message);
}

class CartService extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final AuthService auth = AuthService();

  Map<int, Map<String, dynamic>> cartItens = {};

  _addItemInCard(CartItem item) async {
    var uuid = const Uuid();
    var uidProduct = uuid.v1();

    await firestore
        .collection('usuarios')
        .doc(auth.getUid())
        .collection("carrinho")
        .doc(uidProduct)
        .set({
      "produto": item.name,
      "preco": item.price,
      "size": item.size,
      "quantidade": item.amount,
      "uid": uidProduct,
    });

    if (item.additional!.isNotEmpty) {
      for (var i = 0; i < item.additional!.length; i++) {
        var uidAdditional = uuid.v1();

        await firestore
            .collection("usuarios")
            .doc(auth.getUid())
            .collection("carrinho")
            .doc(uidProduct)
            .collection("adicionais")
            .doc(uidAdditional)
            .set({
          "adicional": item.additional![i]["nome"],
          "preco": item.additional![i]["preco"],
          "uid": uidAdditional,
        });
      }
    }
  }

  setCartItem(
    String product,
    Map<int, dynamic> additional,
    int amount,
    String size,
    String price,
  ) {
    Map<int, Map<String, dynamic>> additionalCheck = {};
    int count = 0;

    for (var i = 0; i < additional.length; i++) {
      if (additional[i]["check"]) {
        Map<String, dynamic> additionalCheckItem = {};
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
      size: size,
      name: product,
      price: price,
    );
    _addItemInCard(item);
  }

  setCart() async {
    await firestore
        .collection("usuarios")
        .doc(auth.getUid())
        .collection("carrinho")
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        cartItens[i] = value.docs[i].data();
      }
    });

    for (var i = 0; i < cartItens.length; i++) {
      Map<int, Map<String, dynamic>> additionalItem = {};

      await firestore
          .collection("usuarios")
          .doc(auth.getUid())
          .collection("carrinho")
          .doc(cartItens[i]!["uid"])
          .collection("adicionais")
          .get()
          .then((value) {
        for (var x = 0; x < value.docs.length; x++) {
          additionalItem[x] = value.docs[x].data();
        }
        cartItens[i]!["adicionais"] = additionalItem;
      });
    }
  }

  getCart() {
    return cartItens;
  }

  removeItemFromCard(itemUid) {
    firestore
        .collection("usuarios")
        .doc(auth.getUid())
        .collection("carrinho")
        .doc(itemUid)
        .collection("adicionais")
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        firestore
            .collection("usuarios")
            .doc(auth.getUid())
            .collection("carrinho")
            .doc(itemUid)
            .collection("adicionais")
            .doc(value.docs[i]["uid"])
            .delete();
      }
    });

    firestore
        .collection("usuarios")
        .doc(auth.getUid())
        .collection("carrinho")
        .doc(itemUid)
        .delete();
  }
}
