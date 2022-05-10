import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export-widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 220, 86),
      appBar: AppBar(
        actions: [
          Image.asset(
            'images/logo-escrita.png',
            width: 100,
            height: 50,
          ),
        ],
        backgroundColor: Color.fromARGB(255, 254, 220, 86),
        title: Center(
          child: Text(
            "Entrar",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            CustomTextField(
              descricaoCampo: "Email",
              placeholder: "Ex. funalo@gmail.com",
            ),
            CustomTextField(
              descricaoCampo: "Senha",
              placeholder: "********",
            ),
            CustomTextButton(
              textoBotao: "Entrar",
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
