import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pointsf/View/export-all-view.dart';

import 'package:pointsf/widgets/export-widgets.dart';

import 'package:pointsf/Services/Validators/user_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email, senha;

  Future _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await auth.signInWithEmailAndPassword(email: email!, password: senha!);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => Home()), (route) => false);
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Email não encontrado. Cadastre-se.',
              ),
            ),
          );
        } else if (ex.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Senha incorreta. Tente novamente',
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 220, 86),
      appBar: const CustomAppBar(
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
                validator: (value) => UserValidator.validarEmail(value!),
              ),
              CustomTextField(
                descricaoCampo: "Senha",
                placeholder: "********",
                obscureText: true,
                onSaved: (value) => senha = value,
                validator: (value) => UserValidator.validarSenha(value!),
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
