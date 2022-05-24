import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

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

  _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await AuthService().login(email!, senha!, context);
      } on AuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 74, 44, 82),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 80),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 74, 44, 82),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(500, 70),
                    bottomRight: Radius.elliptical(500, 70),
                  ),
                ),
                child: Image.asset(
                  'images/logo-sem-fundo.png',
                  height: 250,
                ),
              ),
              SizedBox(
                height: 50,
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
                          builder: (context) => CustomerRegistration(),
                        ),
                      );
                    },
                    child: const Text(
                      'Cadastra-se',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
