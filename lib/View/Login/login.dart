import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pointsf/View/export-all-view.dart';

import 'package:pointsf/widgets/export-widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _formKey = GlobalKey<FormState>();

  String? email, senha;

  Future _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await auth.signInWithEmailAndPassword(email: email!, password: senha!);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => Home()), (route) => false);
      } on FirebaseAuthException catch (ex) {
        print(ex.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 220, 86),
      appBar: CustomAppBar(
        title: "Login",
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: [
              CustomTextField(
                descricaoCampo: "Email",
                placeholder: "Ex. funalo@gmail.com",
                onSaved: (value) => email = value,
                validator: (value){},
              ),
              CustomTextField(
                descricaoCampo: "Senha",
                placeholder: "********",
                obscureText: true,
                onSaved: (value) => senha = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informa sua senha!';
                  } else if (value.length < 6) {
                    return 'Sua senha deve ter no mínimo 6 caracteres';
                  }
                  return null;
                },
              ),
              CustomTextButton(
                textoBotao: "Entrar",
                onPressed: () => {
                  _login(context),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
