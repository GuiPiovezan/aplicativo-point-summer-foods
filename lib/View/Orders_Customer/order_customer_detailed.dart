import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pointsf/main.dart';
import 'package:pointsf/models/address_model.dart';
import 'package:pointsf/widgets/export_widgets.dart';

class OrderCustomerDetailed extends StatefulWidget {
  @override
  State<OrderCustomerDetailed> createState() => _OrderCustomerState();
}

class _OrderCustomerState extends State<OrderCustomerDetailed> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? dropDownOrderStatus;
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
                  Divider(
                    color: Color.fromARGB(255, 16, 18, 19),
                    endIndent: 20,
                    thickness: 1,
                    height: 10,
                    indent: 20,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 74, 44, 82),
                        ),
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 74, 44, 82),
                        ),
                        labelText: "Selecione o Status do pedido",
                        hintText: "Selecione o Status do pedido",
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 74, 44, 82),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 240, 0, 0),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 74, 44, 82),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 74, 44, 82),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onChanged: (String? orderStatus) {
                        setState(() {
                          dropDownOrderStatus = orderStatus!;
                        });
                      },
                      items: orderStatus.map((String orderStatus) {
                        return DropdownMenuItem(
                          value: orderStatus,
                          child: Text(
                            orderStatus,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pronto",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Altere o Status",
                              style: TextStyle(
                                fontSize: 16,
                                //fontWeight: ,
                              ),
                            ),
                          ],
                        ),
                        CustomTextButton(
                          onPressed: () {},
                          buttonText: "Press",
                          heigth: 50,
                          width: 80,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Entregue",
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
                          onPressed: () {},
                          buttonText: "Press",
                          heigth: 50,
                          width: 80,
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

final statusOrderSelected = TextEditingController();

List<String> orderStatus = [
  "Aprovado",
  "Cancelado",
];
