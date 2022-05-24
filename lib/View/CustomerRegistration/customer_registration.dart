import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:pointsf/models/customer_model.dart';
import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/Services/Validators/user_validator.dart';
import 'package:pointsf/widgets/export_widgets.dart';

import 'package:brasil_fields/brasil_fields.dart';

class CustomerRegistration extends StatefulWidget {
  const CustomerRegistration({Key? key}) : super(key: key);

  @override
  State<CustomerRegistration> createState() => _CustomerRegistrationState();
}

class _CustomerRegistrationState extends State<CustomerRegistration> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final tituloTela = 'Cadastro Usuário';

  String nome = '';

  String telefone = '';

  String email = '';

  String senha = '';

  String cpf = '';

  String confirmarSenha = '';

  TextEditingController senhaController = TextEditingController();

  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      CustomerModel model = CustomerModel(
        nome: nome,
        uid: null,
        telefone: telefone,
        cpf: cpf,
        admin: false,
      );

      AuthService().register(email, senha, model, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
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
