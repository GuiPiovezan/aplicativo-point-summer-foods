import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/models/address_model.dart';

import 'package:uuid/uuid.dart';

class AddressException implements Exception {
  String message;
  AddressException(this.message);
}

class AddressService extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  registration(AddressModel model, BuildContext context) {
    var uuid = const Uuid();
    var uid = uuid.v1();
    try {
      firestore
          .collection('usuarios')
          .doc(AuthService().getUid())
          .collection("enderecos")
          .doc(uid)
          .set({
        "cep": model.cep,
        "logradouro": model.logradouro,
        "numero": model.numero,
        "complemento": model.complemento,
        "bairro": model.bairro,
        "nome": model.nome,
        "cidade": model.cidade,
        "uid": uid,
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }

    Navigator.of(context).pop();
  }

  update(AddressModel model, BuildContext context) {
    try {
      firestore
          .collection('usuarios')
          .doc(AuthService().getUid())
          .collection("enderecos")
          .doc(model.uid)
          .update({
        "cep": model.cep,
        "logradouro": model.logradouro,
        "numero": model.numero,
        "complemento": model.complemento,
        "bairro": model.bairro,
        "nome": model.nome,
        "cidade": model.cidade,
        "uid": model.uid
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }

    Navigator.of(context).pop();
  }

  getAddress() {
    return firestore
        .collection("usuarios")
        .doc(AuthService().getUid())
        .collection("enderecos")
        .snapshots();
  }
}
