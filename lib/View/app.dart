import 'package:flutter/material.dart';
import 'package:pointsf/View/CadastroProduto/cadastro-produto.dart';
import 'package:pointsf/View/Welcome/welcome.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
