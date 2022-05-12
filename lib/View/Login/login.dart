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
      appBar: CustomAppBar(
        title: "Login",
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
