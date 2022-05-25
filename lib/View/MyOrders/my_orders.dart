import 'package:flutter/material.dart';
import 'package:pointsf/widgets/AppBar/custom_appbar.dart';

class MyOrders extends StatelessWidget{
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
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 102, 19, 131),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 3,
                      color: Color.fromARGB(0, 74, 44, 82),
                      style: BorderStyle.solid,
                    )
                  ),
              width: 345,
              height: 100,
              child: TextButton(
                onPressed: (){},
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
                        children: [
                          Text("Ricardo Brito Teixeira 627, PQ. das Flores")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check_circle_rounded),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 75, 0),
                            child: Text("10:00"),
                          ),
                          Icon(Icons.restaurant),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
                            child: Text("10:15"),
                          ),
                          Icon(Icons.delivery_dining),
                          Text("10:30")
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