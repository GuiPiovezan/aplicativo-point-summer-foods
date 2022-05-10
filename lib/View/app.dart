import 'package:flutter/material.dart';

import 'export-all-view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CadastroEndereco(),
      debugShowCheckedModeBanner: false,
    );
  }
}
