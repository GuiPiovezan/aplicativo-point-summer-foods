import 'package:flutter/material.dart';

import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/View/Orders_Customer/card_order_customer.dart';
import 'package:pointsf/View/Routes/routes.dart';

class App extends StatelessWidget {
  final auth = AuthService();
  App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardOrderCustomer(// const MaterialApp
        /*home: RouteApp(),
      debugShowCheckedModeBanner: false,*/
        );
  }
}
