import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pointsf/models/address_model.dart';

class OrdersDetaileds extends StatelessWidget {
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
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.height,
              //color: Color.fromARGB(252, 241, 241, 63),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Color.fromARGB(252, 241, 241, 63),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        borderOnForeground: true,
                        color: Colors.blue,
                      )
                    ],
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.filter_1_sharp),
                          Text("Açai 300ml c/ 2 Adicionais"),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [Text("Nutella")],
                            ),
                            Row(
                              children: [Text("Banana")],
                            )
                          ],
                        ),
                        Text("R 15,00")
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
                  )
                ],
              ))
        ],
      ),
    );
  }
}
