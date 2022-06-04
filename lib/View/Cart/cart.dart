import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export_widgets.dart';

class Cart extends StatefulWidget {
  const Cart({
    Key? key,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: CustomAppBar(
        title: "Carrinho",
      ),
      body: CartPage(),
    );
  }
}
