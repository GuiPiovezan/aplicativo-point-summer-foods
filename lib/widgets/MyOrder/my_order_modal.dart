import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pointsf/widgets/export_widgets.dart';

class MyOrderModal extends StatelessWidget {
  final order;
  const MyOrderModal({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
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
                  child: order.toString().contains("pedidoConcluido")
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle),
                            Text(
                                "Pedido concluido as ${DateFormat("HH:mm").format(order["pedidoConcluido"].toDate())}")
                          ],
                        )
                      : order.toString().contains("pedidoAceito")
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
                    style: TextStyle(
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
              margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Row(
                children: const [
                  /*SizedBox(
                    width: 30,
                  ),*/
                  Icon(Icons.house_rounded, size: 24),
                  Text(
                    "Endereço:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 0, 20, 10),
              child: ListTile(
                /*leading: const Icon(
                  Icons.house_sharp,
                  size: 32.0,
                ),*/
                title: Text(
                  "${order["endereco"]}, ${order["numero"]}",
                ),
                subtitle: Text(
                  "${order["bairro"]} - ${order["cidade"]}",
                ),
              ),
            )
          ],
        ));
  }
}
