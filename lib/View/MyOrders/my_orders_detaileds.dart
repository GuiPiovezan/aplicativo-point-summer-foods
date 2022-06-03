import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pointsf/main.dart';
import 'package:pointsf/models/address_model.dart';

class MyOrdersDetaileds extends StatelessWidget {
  /* final AddressModel? model;

  const OrdersDetaileds({
    Key? key,
    required this.model,
  }) : super(key: key);
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //color: Color.fromARGB(252, 241, 241, 63),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Produto id - 6016511321616"),
                        Text("30/Abr")
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle),
                          Text("Pedido Concluido as 10:15")
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 16, 18, 19),
                    endIndent: 20,
                    thickness: 1,
                    height: 10,
                    indent: 20,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(60, 10, 60, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.filter_1_sharp),
                          Text("Açai 300ml c/ 2 Adicionais"),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Row(
                                children: [Text("Nutella")],
                              ),
                            ),
                            Row(
                              children: [Text("Banana")],
                            )
                          ],
                        ),
                        Text("RS 15,00")
                      ],
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 16, 18, 19),
                    endIndent: 20,
                    thickness: 1,
                    height: 10,
                    indent: 20,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      children: [Text("Soma dos Valores")],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("SubTotal"), Text("RS 15,00")],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Cupom"), Text("RS 4,00")],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Taxa de Entrega"), Text("RS 1,50")],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total"),
                        Text("RS 12,50"),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 16, 18, 19),
                    endIndent: 20,
                    thickness: 1,
                    height: 10,
                    indent: 20,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pagamento no Cartão"),
                        Row(
                          children: [
                            Icon(Icons.credit_card_rounded),
                            Text("Crédito")
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 16, 18, 19),
                    endIndent: 20,
                    thickness: 1,
                    height: 10,
                    indent: 20,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.house_rounded),
                            Text("Endereço")
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Row(
                      children: [Text("Av.Tarraf 3576, Portal Cidade Amiga")],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
