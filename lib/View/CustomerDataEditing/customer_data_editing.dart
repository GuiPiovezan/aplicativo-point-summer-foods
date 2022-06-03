import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:pointsf/models/customer_model.dart';
import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/Services/Validators/user_validator.dart';
import 'package:pointsf/widgets/export_widgets.dart';

import 'package:brasil_fields/brasil_fields.dart';

class CustomerDataEditing extends StatefulWidget {
  const CustomerDataEditing({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerDataEditing> createState() => _CustomerDataEditingState();
}

class _CustomerDataEditingState extends State<CustomerDataEditing> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthService auth = AuthService();

  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerTelefone = TextEditingController();
  final _controllerCpf = TextEditingController();
  var oldModel = CustomerModel(
    nome: null,
    telefone: null,
    cpf: null,
    uid: null,
    admin: null,
  );

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setInfo();
  }

  getInfo() {
    oldModel = auth.model;
    setState(() {
      _controllerName.text = oldModel.nome ?? '';
      _controllerEmail.text = auth.getUserEmail();
      _controllerTelefone.text = oldModel.telefone ?? "";
      _controllerCpf.text = oldModel.cpf ?? "";
      isLoading = false;
    });
  }

  setInfo() async {
    setState(() => isLoading = true);
    await auth.setCustomerModel();
    getInfo();
  }

  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      formKey.currentState!.save();

      CustomerModel model = CustomerModel(
        nome: _controllerName.text.trim(),
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
    while (isLoading) {
      setInfo();
      getInfo();
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
              controller: _controllerEmail,
              labelText: 'E-mail',
              validator: (value) => UserValidator.validarEmail(value!),
              enable: false,
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
            CustomTextField(
              controller: _controllerCpf,
              labelText: 'CPF',
              validator: (value) => UserValidator.validarCPF(value!),
              enable: false,
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
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
