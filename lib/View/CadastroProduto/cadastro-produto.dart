import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

class CadastroProduto extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBFFD941), //Cor na tela Toda 
      appBar: AppBar(
        backgroundColor:const Color(0xFFBFFD941) , //Cor no App Bar
        title: Center(
          child: Text("Point Summer Food's",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
              Image.asset('images/logo.png',
                width: 180,
                height: 180,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: ,
    );
  }
}