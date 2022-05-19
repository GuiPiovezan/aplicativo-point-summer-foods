import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 102, 19, 131),
        title: Text("Meus Pedidos"),
        actions: [Image.asset('images/logo-escrita.png')],
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_rounded)),
      ),
      body: Container(
        child: TextButton(
          onPressed: (){},
          child: Container(
            child: Column(
              children: [
                Row(),
                Row(),
                Row()
              ],
            ),
          ),
        ),
      ),
    );
  }
}