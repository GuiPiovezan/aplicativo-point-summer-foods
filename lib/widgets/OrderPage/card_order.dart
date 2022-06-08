import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export_widgets.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

class CardOrder extends StatelessWidget {
  final order;

  const CardOrder({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(25, 10, 10, 10),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  width: 3,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  style: BorderStyle.solid,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              // height: 125,
              child: TextButton(
                onPressed: () => showBarModalBottomSheet(
                  context: context,
                  builder: (context) => OrderModal(
                    order: order,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "id - ${order["uid"]}",
                            style: const TextStyle(
                              color: Color.fromARGB(100, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat("dd/MM/yy")
                                  .format(order["data"].toDate()),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            Text(
                              "R\$ ${order["valorTotalProdutos"]}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: Text(
                              "${order["endereco"]}, ${order["numero"]}, ${order["bairro"]}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.bookmark_add_outlined,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Text(
                                DateFormat("HH:mm")
                                    .format(order["data"].toDate()),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.verified_outlined,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Text(
                                order["pedidoAceito"] != null
                                    ? DateFormat("HH:mm")
                                        .format(order["pedidoAceito"].toDate())
                                    : "xx:xx",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.delivery_dining_outlined,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Text(
                                order["pedidoConcluido"] != null
                                    ? DateFormat("HH:mm").format(
                                        order["pedidoConcluido"].toDate())
                                    : "xx:xx",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      color: const Color.fromARGB(255, 240, 240, 240),
    );
  }
}
