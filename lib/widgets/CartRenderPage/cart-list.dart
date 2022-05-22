import 'package:flutter/material.dart';

import 'package:pointsf/Services/CartService/cart-service.dart';
import 'package:pointsf/widgets/export-widgets.dart';

class CartList extends StatelessWidget {
  var cartItens;

  CartList({
    Key? key,
    required this.cartItens,
  }) : super(key: key);

  CartService cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView.builder(
        itemCount: cartItens.length,
        itemBuilder: (_, index) {
          return CartItemCard(
            cartItens: cartItens[index],
            index: index,
          );
        },
      ),
    );
  }
}
