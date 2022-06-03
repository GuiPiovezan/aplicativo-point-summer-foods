import 'package:flutter/material.dart';
import 'package:pointsf/widgets/export_widgets.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: CustomAppBar(
        title: "Meus Pedidos",
      ),
      body: MyOrderList(),
    );
  }
}
