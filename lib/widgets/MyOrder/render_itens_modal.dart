import 'package:flutter/material.dart';

import 'package:pointsf/Services/OrderService/order_service.dart';
import 'package:pointsf/widgets/export_widgets.dart';

class RenderItensModal extends StatefulWidget {
  final order;
  const RenderItensModal({
    Key? key,
    this.order,
  }) : super(key: key);

  @override
  State<RenderItensModal> createState() => _RenderItensModalState();
}

class _RenderItensModalState extends State<RenderItensModal> {
  Map<int, Map<String, dynamic>>? orderItens;
  OrderService orderService = OrderService();
  @override
  void initState() {
    super.initState();
    setOrder();
  }

  Future<void> setOrder() async {
    await orderService.setMyOrdersItens(widget.order["uid"]);
    setState(() {
      orderItens = orderService.orderItens;
    });
  }

  @override
  Widget build(BuildContext context) {
    while (orderItens == null) {
      setOrder();
      return ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: const [
              SizedBox(
                height: 300,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ],
      );
    }
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 0, 15, 10),
              itemCount: orderItens!.length,
              itemBuilder: (_, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${orderItens![index]!["quantidade"].toString()}x, ${orderItens![index]!["produto"].toString()}, ${orderItens![index]!["tamanho"].toString()}, R\$ ${orderItens![index]!["preco"].toString()}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    RenderAdditionalOrder(
                        orderItensAdditional:
                            orderItens![index]!["adicionais"])
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
