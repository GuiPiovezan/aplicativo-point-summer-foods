import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pointsf/View/export_all_view.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyOrders(),
      /* routes: {
        '/': (context) => const Login(),
        '/home': (context) => const Home(),
      },
      initialRoute: auth.currentUser == null ? '/' : '/home',
      debugShowCheckedModeBanner: false,*/
    );
  }
}
