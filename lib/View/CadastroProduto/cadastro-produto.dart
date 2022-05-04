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
<<<<<<< HEAD
              Padding(padding: EdgeInsets.fromLTRB(50, 15, 50, 15)),
              Image.asset("images/logo.png",
              width: 180,
              height: 180,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Nome",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Tipo",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Status",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                    ),
                  ),
                ),
              ),
=======
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
>>>>>>> 9add534be604c2d762620fcb693ff69e868f2f2c
            ],
          ),
        ),
      ),
      //bottomNavigationBar: ,
    );
  }
}
