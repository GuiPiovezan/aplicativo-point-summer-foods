import 'package:flutter/material.dart';

import 'package:pointsf/Services/AuthService/auth-service.dart';
import 'package:pointsf/Services/Validators/user_validator.dart';
import 'package:pointsf/View/CustomerRegistration/customer-registration.dart';
import 'package:pointsf/widgets/export-widgets.dart';

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
        enableIconBack: false,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: [
              Image.asset(
                'images/logo.png',
                height: 200.0,
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ainda não tem cadastro?',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CustomerRegistration()),
                        );
                      },
                      child: const Text('Cadastra-se',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 83, 5, 64))))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
