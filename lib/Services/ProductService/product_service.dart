import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/models/product_model.dart';

import 'package:uuid/uuid.dart';

class ProductException implements Exception {
  String message;
  ProductException(this.message);
}

class ProductService extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  Map<int, Map<String, dynamic>> itens = {};
  Map<int, Map<String, dynamic>> sizes = {};

  registration(ProductModel model, BuildContext context) {
    var uuid = const Uuid();
    var uidProduct = uuid.v1();
    try {
      firestore.collection('produtos').doc(uidProduct).set({
        "categoria": model.categoria,
        "nome": model.nome,
        "status": model.status,
        "tipo": model.tipo,
        "uid": uidProduct,
      });
      if (model.sizes!.isNotEmpty) {
        for (var i = 0; i < model.sizes!.length; i++) {
          var uidSize = uuid.v1();
          firestore
              .collection('produtos')
              .doc(uidProduct)
              .collection('tamanhos')
              .doc(uidSize)
              .set({
            "tamanho": model.sizes![i]['size'],
            "preco": model.sizes![i]['price'],
            "uid": uidSize,
          });
        }
      }
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }

    Navigator.of(context).pop();
  }

  getActiveProductsByCategory(category) {
    return firestore
        .collection('produtos')
        .where("categoria", isEqualTo: category)
        .where("status", isEqualTo: "Ativo")
        .where("tipo", isEqualTo: "Primario")
        .snapshots();
  }

  getSizeProduct(uid) async {
    await firestore
        .collection('produtos')
        .doc(uid)
        .collection("tamanhos")
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        sizes[i] = value.docs[i].data();
        sizes[i]!["check"] = false;
      }
    });
    return null;
  }

  getAdditionalByCategory(category) async {
    await firestore
        .collection('produtos')
        .where("categoria", isEqualTo: category)
        .where("status", isEqualTo: "Ativo")
        .where("tipo", isEqualTo: "Adicional")
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        itens[i] = value.docs[i].data();
        itens[i]!["check"] = false;
        await firestore
            .collection("produtos")
            .doc(value.docs[i]["uid"])
            .collection("tamanhos")
            .get()
            .then((value) {
          itens[i]!["preco"] = value.docs[0]["preco"];
        });
      }
    });
  }

  getAllProductsByCategory(category) {
    return firestore
        .collection('produtos')
        .where("categoria", isEqualTo: category)
        .snapshots();
  }

  update(ProductModel model, BuildContext context) async {
    try {
      await firestore.collection('produtos').doc(model.uid).update({
        "categoria": model.categoria,
        "nome": model.nome,
        "status": model.status,
        "tipo": model.tipo,
      });
      await firestore
          .collection("produtos")
          .doc(model.uid)
          .collection("tamanhos")
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          await firestore
              .collection("produtos")
              .doc(model.uid)
              .collection("tamanhos")
              .doc(value.docs[i]["uid"])
              .delete();
        }
      });
      if (model.sizes!.isNotEmpty) {
        for (var i = 0; i < model.sizes!.length; i++) {
          var uuidForSize = const Uuid();
          var uidSize = uuidForSize.v1();
          await firestore
              .collection('produtos')
              .doc(model.uid)
              .collection('tamanhos')
              .doc(uidSize)
              .set({
            "tamanho": model.sizes![i]['tamanho'],
            "preco": model.sizes![i]['preco'],
            "uid": uidSize,
          });
        }
      }
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }

    Navigator.of(context).pop();
  }
}
