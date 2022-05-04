import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

class CadastroProduto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 254, 220, 86), //Cor na tela Toda
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 254, 220, 86), //Cor no App Bar
        title: Center(
          child: Text(
            "Cadastro de Produtos",
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 20,
              color: Colors.purple,
            ),
          ),
        ),
        leading: Icon(
          Icons.arrow_back_sharp,
          size: 30,
          color: Colors.purple,
        ),
        actions: [
          Image.asset(
            'images/logo-escrita.png',
            width: 100,
            height: 30,
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              Image.asset(
                "images/logo.png",
                width: 180,
                height: 180,
              ),
              TextField(
                decoration: InputDecoration(
                    //border: OutlinedBorder(side:),
                    hintText: "nome"),
              ),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: ,
    );
  }
}
