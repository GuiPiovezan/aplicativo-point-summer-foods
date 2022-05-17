import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointsf/Services/Validators/user_validator.dart';
import 'package:pointsf/View/export-all-view.dart';
import 'package:pointsf/widgets/export-widgets.dart';

class CustomerRegistration extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  final tituloTela = 'Cadastro Usuário';

  String nome = '';
  String telefone = '';
  String email = '';
  String senha = '';
  String cpf = '';
  String confirmarSenha = '';

  TextEditingController senhaController = TextEditingController();

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      firestore.collection('usuarios').doc(result.user!.uid).set({
        "nome": nome,
        "uid": result.user!.uid,
        "telefone": telefone,
        "cpf": cpf,
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 220, 86),
      appBar: const CustomAppBar(
        title: "Customer Register",
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            CustomTextField(
              onSaved: (value) => nome = value!,
              labelText: 'Nome',
              validator: (value) => UserValidator.validarNome(value!),
            ),
            CustomTextField(
              onSaved: (value) => email = value!,
              labelText: 'E-mail',
              validator: (value) => UserValidator.validarEmail(value!),
            ),
            CustomTextField(
              onSaved: (value) => telefone = value!,
              labelText: 'Telefone',
              inputType: TextInputType.number,
              validator: (value) => UserValidator.validarTelefone(value!),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
            ),
            CustomTextField(
              onSaved: (value) => cpf = value!,
              labelText: 'CPF',
              inputType: TextInputType.number,
              validator: (value) => UserValidator.validarCPF(value!),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter()
              ],
            ),
            CustomTextField(
              onSaved: (value) => senha = value!,
              labelText: 'Senha',
              controller: senhaController,
              validator: (value) => UserValidator.validarSenha(value!),
            ),
            CustomTextField(
              onSaved: (value) => confirmarSenha = value!,
              labelText: 'Confirmar senha',
              validator: (value) => UserValidator.validarConfirmarSenha(
                  value!, senhaController.text),
            ),
            CustomTextButton(
              buttonText: 'Cadastrar',
              onPressed: () => save(context),
            ),
          ],
        ),
      ),
    );
  }
}
