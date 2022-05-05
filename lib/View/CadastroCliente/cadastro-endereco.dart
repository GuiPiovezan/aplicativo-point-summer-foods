import 'package:flutter/material.dart';

class CadastroEndereco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 220, 86),
        AppBar: AppBar(
          actions: [
            Image.asset(
              'images/logo-escrita',
              width: 100,
              height: 50,
            )
          ],
        ));
  }
}
