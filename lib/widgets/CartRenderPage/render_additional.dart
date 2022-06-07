import 'package:flutter/material.dart';

import 'package:pointsf/Services/CartService/cart_service.dart';

class RenderAdditional extends StatelessWidget {
  final CartService cartService = CartService();
  final Map<int, dynamic> cartItensAdditional;

  RenderAdditional({
    Key? key,
    required this.cartItensAdditional,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 15, 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cartItensAdditional.length,
        itemBuilder: (_, index) {
          return Text(
            cartItensAdditional[index]["adicional"] +
                " - " +
                cartItensAdditional[index]["preco"],
            style: const TextStyle(
              fontSize: 18,
            ),
          );
        },
      ),
    );
  }
}
