import 'package:flutter/material.dart';

class CadastroEndereco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 220, 86),
      appBar: AppBar(
        actions: [
          Image.asset(
            'images/logo-escrita.png',
            width: 100,
            height: 50,
          ),
        ],
        backgroundColor: Color.fromARGB(255, 254, 220, 86),
        title: Center(
          child: Text("Endereço"),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(children: [
            TextField(
              decoration: InputDecoration(
                hintText: "CEP",
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
