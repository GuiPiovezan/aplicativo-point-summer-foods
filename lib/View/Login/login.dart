import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/Services/Validators/user_validator.dart';
import 'package:pointsf/View/CustomerRegistration/customer_registration.dart';
import 'package:pointsf/widgets/export_widgets.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService auth = AuthService();
  bool loading = false;

  String? email = "", senha = "";

  _login(BuildContext context) async {
    setState(() => loading = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await auth.login(email!, senha!, context);
      } on AuthException catch (e) {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } else {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 74, 44, 82),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
        preferredSize: const Size.fromHeight(0),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 80),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 74, 44, 82),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(500, 70),
                    bottomRight: Radius.elliptical(500, 70),
                  ),
                ),
                child: Image.asset(
                  'assets/images/logo-sem-fundo.png',
                  height: 250,
                ),
              ),
              const SizedBox(
                height: 20,
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
              (loading)
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 74, 44, 82),
                      ),
                    )
                  : CustomTextButton(
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
                          builder: (context) => const CustomerRegistration(),
                        ),
                      );
                    },
                    child: const Text(
                      'Cadastra-se',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
