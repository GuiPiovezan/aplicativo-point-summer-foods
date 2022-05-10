import 'package:flutter/material.dart';
import 'package:pointsf/View/Welcome/welcome.dart';

import 'export-all-view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CadastroCliente(),
      debugShowCheckedModeBanner: false,
    );
  }
}
