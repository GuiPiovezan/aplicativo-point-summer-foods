import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/models/product_model.dart';
import 'package:pointsf/View/export_all_view.dart';

import 'package:uuid/uuid.dart';

class ProductException implements Exception {
  String message;
  ProductException(this.message);
}

class ProductService extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  Map<int, Map<String, dynamic>> itens = Map();

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

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  getActiveProductsByCategory(category) {
    return firestore
        .collection('produtos')
        .where("categoria", isEqualTo: category)
        .where("status", isEqualTo: "Ativo")
        .where("tipo", isEqualTo: "Primario")
        .snapshots();
  }

  getAdditionalByCategory(category) async {
    await firestore
        .collection('produtos')
        .where("categoria", isEqualTo: category)
        .where("status", isEqualTo: "Ativo")
        .where("tipo", isEqualTo: "Adicional")
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        itens[i] = value.docs[i].data();
        itens[i]!["check"] = false;
      }
    });
  }

  getAllProductsByCategory(category) {
    return firestore
        .collection('produtos')
        .where("categoria", isEqualTo: category)
        .snapshots();
  }
}
