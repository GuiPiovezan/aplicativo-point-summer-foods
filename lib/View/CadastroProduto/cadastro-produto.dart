import 'dart:ui';

import 'package:flutter/material.dart';

class CadastroProduto extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Point Summer Food's",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Text("Text"),
      //bottomNavigationBar: ,
    );
  }
}