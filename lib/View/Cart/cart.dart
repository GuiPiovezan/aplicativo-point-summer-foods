import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export-widgets.dart';

class Cart extends StatefulWidget {
  Cart({
    Key? key,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: CustomAppBar(
        title: "Carrinho",
      ),
      body: CartPage(),
    );
  }
}
