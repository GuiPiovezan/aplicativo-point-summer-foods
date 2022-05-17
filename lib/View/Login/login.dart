import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export-widgets.dart';

import 'package:pointsf/Services/AuthService/auth-service.dart';
import 'package:pointsf/Services/Validators/user_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email = "", senha = "";

  _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthService().login(email!, senha!, context);
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
                labelText: "Email",
                placeholder: "Ex. funalo@gmail.com",
                inputType: TextInputType.emailAddress,
                onSaved: (value) => email = value,
                validator: (value) => UserValidator.validarEmail(value!),
              ),
              CustomTextField(
                labelText: "Senha",
                placeholder: "********",
                obscureText: true,
                onSaved: (value) => senha = value,
                validator: (value) => UserValidator.validarSenha(value!),
              ),
              CustomTextButton(
                buttonText: "Entrar",
                onPressed: () => _login(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
