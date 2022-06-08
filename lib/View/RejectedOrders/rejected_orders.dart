import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export_widgets.dart';

class RejectedOrders extends StatefulWidget {
  const RejectedOrders({Key? key}) : super(key: key);

  @override
  State<RejectedOrders> createState() => _RejectedOrdersState();
}

class _RejectedOrdersState extends State<RejectedOrders> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(
        title: "Pedidos recusados",
      ),
      body: OrderPage(
        status: "recusado",
      ),
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
    );
  }
}
