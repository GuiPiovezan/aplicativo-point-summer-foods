import 'package:flutter/material.dart';

import 'package:pointsf/View/export-all-view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductRegistration(),
      debugShowCheckedModeBanner: false,
    );
  }
}
