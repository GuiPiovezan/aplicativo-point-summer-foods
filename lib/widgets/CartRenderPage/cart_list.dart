import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export_widgets.dart';

class CartList extends StatelessWidget {
  final Map<int, Map<String, dynamic>> cartItens;

  const CartList({
    Key? key,
    required this.cartItens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView.builder(
        itemCount: cartItens.length,
        itemBuilder: (_, index) {
          return CartItemCard(
            cartItens: cartItens[index]!,
            index: index,
          );
        },
      ),
    );
  }
}
