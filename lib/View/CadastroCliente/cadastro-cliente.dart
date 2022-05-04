import 'package:flutter/material.dart';

class CadastroCliente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 254, 220, 86),
        actions: [
          Image.asset(
            'images/logo-escrita.png',
            width: 100,
            height: 30,
          ),
        ],
        leading: Icon(
          Icons.arrow_back,
        ),
      ),
      body: Text("Olá mundo"),
    );
  }
}
