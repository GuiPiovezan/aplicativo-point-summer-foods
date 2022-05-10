import 'package:flutter/material.dart';
import 'package:pointsf/View/CadastroProduto/cadastro-produto.dart';

import 'CadastroCliente/cadastro-cliente.dart';
import 'CadastroCliente/cadastro-endereco.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CadastroCliente(),
      debugShowCheckedModeBanner: false,
    );
  }
}
