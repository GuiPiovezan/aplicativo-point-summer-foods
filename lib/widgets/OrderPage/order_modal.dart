import 'package:flutter/material.dart';

import 'package:pointsf/Services/OrderService/order_service.dart';
import 'package:pointsf/widgets/export_widgets.dart';

import 'package:intl/intl.dart';

class OrderModal extends StatelessWidget {
  final order;
  OrderModal({
    Key? key,
    required this.order,
  }) : super(key: key);
  final OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 0, 0, 0),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Id - ${order["uid"]}"),
                  Text(DateFormat("dd/MM/yy").format(order["data"].toDate())),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Card(
                  child: order["pedidoConcluido"] != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle),
                            Text(
                                "Pedido concluido as ${DateFormat("HH:mm").format(order["pedidoConcluido"].toDate())}")
                          ],
                        )
                      : order["pedidoAceito"] != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.check_rounded),
                                Text(
                                    "Pedido aceito as ${DateFormat("HH:mm").format(order["pedidoAceito"].toDate())}"),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.airplane_ticket_outlined),
                                Text(
                                  "Pedido enviado as ${DateFormat("HH:mm").format(order["data"].toDate())}",
                                )
                              ],
                            )),
            ),
            const Divider(
              color: Color.fromARGB(255, 16, 18, 19),
              endIndent: 20,
              thickness: 1,
              height: 10,
              indent: 20,
            ),
            RenderItensModal(order: order),
            const Divider(
              color: Color.fromARGB(255, 16, 18, 19),
              endIndent: 20,
              thickness: 1,
              height: 10,
              indent: 20,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "SubTotal",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text("R\$: ${order["valorTotalProdutos"]}")
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Taxa de Entrega",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text("R\$ ${order["taxaEntrega"]}")
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "R\$ ${order["valorTotalProdutos"] + order["taxaEntrega"]}",
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 16, 18, 19),
              endIndent: 20,
              thickness: 1,
              height: 10,
              indent: 20,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pagamento no ${order["tipoPagamento"]}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      //fontFamily: ,
                    ),
                  ),
                  order["troco"] != null
                      ? Text("R\$ ${order["troco"]}")
                      : Row(
                          children: [
                            const Icon(Icons.credit_card_rounded),
                            Text("${order["pagamento"]}")
                          ],
                        )
                ],
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 16, 18, 19),
              endIndent: 20,
              thickness: 1,
              height: 10,
              indent: 20,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: ListTile(
                leading: const Icon(
                  Icons.house_sharp,
                  size: 32.0,
                ),
                title: Text(
                  "${order["endereco"]}, ${order["numero"]}",
                ),
                subtitle: Text(
                  "${order["bairro"]} - ${order["cidade"]}",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: order["status"] == "enviado"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextButton(
                          buttonText: "Recusar",
                          onPressed: () {
                            orderService.rejectOrder(order["uid"], context);
                          },
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                        CustomTextButton(
                          buttonText: "Aceitar",
                          onPressed: () {
                            orderService.acceptOrder(order["uid"], context);
                          },
                          width: MediaQuery.of(context).size.width / 3,
                        )
                      ],
                    )
                  : order["status"] == "aceito"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Entregar",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Altere o Status",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            CustomTextButton(
                              onPressed: () {
                                orderService.finishOrder(order["uid"], context);
                              },
                              buttonText: "OK",
                              heigth: 50,
                              width: 80,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Pedido encerrado",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 74, 44, 82),
                              ),
                            ),
                          ],
                        ),
            )
          ],
        ));
  }
}
