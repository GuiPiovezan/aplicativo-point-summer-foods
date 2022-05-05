
import 'package:flutter/material.dart';


class CadastroProdutoModel{
  String? nome;
  String? tipoProdutoOuAdicional;
  bool? status;
  String? categoria;
  String? medida;

  CadastroProdutoModel(this.nome, this.tipoProdutoOuAdicional, this.status, this.categoria, this.medida);

  CadastroProdutoModel.fromMap(Map<String, dynamic> map){
    nome = map['nome'];
    tipoProdutoOuAdicional = map['tipo'];
    status = map['status'];
    categoria = map['categoria'];
    medida = map['medida'];
  }
}










