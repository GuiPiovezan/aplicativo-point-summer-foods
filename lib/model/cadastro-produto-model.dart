import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/Database/DBFirestore.dart';

class CadastroProdutoModel {
  late FirebaseFirestore firestore;

  String? nome;
  String? tipoProdutoOuAdicional;
  bool? status;
  String? categoria;
  String? medida;
  double? preco;

  void iniciarFirestore() {
    firestore = DBFirestore.get();
  }

  CadastroProdutoModel();

  CadastroProdutoModel.fromMap(Map<String, dynamic> map) {
    nome = map['nome'];
    tipoProdutoOuAdicional = map['tipo'];
    status = map['status'];
    categoria = map['categoria'];
    medida = map['medida'];
    preco = map['preco'];
  }

  void salvarProduto(BuildContext context) {
    iniciarFirestore();
    firestore.collection('usuarios').add({
      "nome": nome,
      "tipo": tipoProdutoOuAdicional,
      "status": status,
      "categoria": categoria,
      "medida": medida,
      "preco": preco,
    });
  }
}
