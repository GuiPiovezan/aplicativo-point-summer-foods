import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:pointsf/models/customer_model.dart';
import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/Services/Validators/user_validator.dart';
import 'package:pointsf/widgets/export_widgets.dart';

import 'package:brasil_fields/brasil_fields.dart';

class CustomerDataEditing extends StatefulWidget {
  const CustomerDataEditing({Key? key}) : super(key: key);

  @override
  State<CustomerDataEditing> createState() => _CustomerDataEditingState();
}

class _CustomerDataEditingState extends State<CustomerDataEditing> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthService auth = AuthService();

  final _controllerName = TextEditingController();
  final _controllerTelefone = TextEditingController();

  bool isLoading = false;

  TextEditingController senhaController = TextEditingController();

  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      formKey.currentState!.save();

      CustomerModel model = CustomerModel(
        nome: _controllerName.text,
        uid: null,
        telefone: _controllerTelefone.text,
        cpf: null,
        admin: null,
      );

      auth.updateUser(model, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const CustomAppBar(
        title: "Alterar Dados",
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            CustomTextField(
              controller: _controllerName,
              labelText: 'Nome',
              validator: (value) => UserValidator.validarNome(value!),
            ),
            CustomTextField(
              controller: _controllerTelefone,
              labelText: 'Telefone',
              inputType: TextInputType.number,
              validator: (value) => UserValidator.validarTelefone(value!),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
            ),
            (isLoading)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 74, 44, 82),
                    ),
                  )
                : CustomTextButton(
                    buttonText: 'Atualizar',
                    onPressed: () => save(context),
                  ),
          ],
        ),
      ),
    );
  }
}
