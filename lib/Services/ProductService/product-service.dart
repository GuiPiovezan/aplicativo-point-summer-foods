import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/models/product-model.dart';

import 'package:pointsf/View/export-all-view.dart';
import 'package:uuid/uuid.dart';

class ProductException implements Exception {
  String message;
  ProductException(this.message);
}

class ProductService extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  registration(ProductModel model, BuildContext context) {
    var uuid = const Uuid();
    var uid = uuid.v1();
    try {
      firestore.collection('produtos').doc(uid).set({
        "categoria": model.categoria,
        "medida": model.medida,
        "nome": model.nome,
        "preco": model.preco,
        "status": model.status,
        "tipo": model.tipo,
        "uid": uid,
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }
}
