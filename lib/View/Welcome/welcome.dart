import 'package:flutter/material.dart';
import 'package:pointsf/View/Login/login.dart';
import 'package:pointsf/View/export-all-view.dart';

import 'package:pointsf/widgets/export-widgets.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 220, 86),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'images/logo.png',
            ),
            CustomTextButton(
              textoBotao: "Cadastrar",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CustomerRegistration()),
                );
              },
            ),
            CustomTextButtonYellow(
              textoBotao: "Entrar",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
