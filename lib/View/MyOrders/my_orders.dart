import 'package:flutter/material.dart';
import 'package:pointsf/View/MyOrders/orders_detaileds.dart';
import 'package:pointsf/main.dart';
import 'package:pointsf/widgets/AppBar/custom_appbar.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Meus Pedidos",
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      //  Colocar sombreamento em volta do card bottom
                      color: Colors.grey, // cor do sombreamento
                      spreadRadius: 3, // espeçura do circulo em volta do bottom
                      blurRadius: 7, // a intensidade da sombra
                    ),
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 3,
                    color: Color.fromARGB(255, 255, 255, 255),
                    style: BorderStyle.solid,
                  )),
              width: MediaQuery.of(context).size.width,
              height: 125,
              child: TextButton(
                onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => OrdersDetaileds(),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)))),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("30/Abr"),
                            Text("id - 1321546861532"),
                            Text("R 30,00"),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Ricardo Brito Teixeira 627, PQ. das Flores")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle_rounded),
                              Text("10:00"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.restaurant),
                              Text("10:15"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.delivery_dining),
                              Text("10:30")
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
