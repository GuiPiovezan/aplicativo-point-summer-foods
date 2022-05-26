import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/View/Orders/confirmation_information.dart';

import 'package:pointsf/View/export_all_view.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const Login(),
        '/home': (context) => const Home(),
        '/confirmationInformation': ((context) =>
            const ConfirmationInformation())
      },
      initialRoute: auth.currentUser == null ? '/' : '/home',
      debugShowCheckedModeBanner: false,
    );
  }
}
