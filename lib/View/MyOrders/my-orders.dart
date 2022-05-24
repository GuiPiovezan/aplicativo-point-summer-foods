import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 102, 19, 131),
        title: Text("Meus Pedidos"),
        actions: [Image.asset('assets/images/logo-escrita.png')],
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded)),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              
              width: 345,
              height: 100,
              color: Color.fromARGB(255, 102, 19, 131),
              child: TextButton(
                onPressed: (){},
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("30/Abr"),
                          Text("id - 1321546861532")
                          ],
                      ),
                      Row(),
                      Row()
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