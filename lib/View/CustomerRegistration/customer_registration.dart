import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pointsf/models/customer_model.dart';
import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/Services/ControlerService/customer_controler.dart';
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

  CustomerControllerService controller = CustomerControllerService();

  AuthService auth = AuthService();

  bool isLoading = false;

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      formKey.currentState!.save();
      try {
        CustomerModel model = CustomerModel(
          nome: controller.name!.text.trim(),
          uid: null,
          telefone: controller.cellphone!.text,
          cpf: controller.cpf!.text,
          admin: false,
        );

        await auth.register(
          controller.email!.text.trim(),
          controller.password!.text.trim(),
          model,
          context,
        );
      } on AuthException catch (e) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const CustomAppBar(
        title: "Cadastro",
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            CustomTextField(
              controller: controller.name,
              labelText: 'Nome',
              validator: (value) => UserValidator.validarNome(value!),
            ),
            CustomTextField(
              controller: controller.email,
              inputType: TextInputType.emailAddress,
              labelText: 'E-mail',
              validator: (value) => UserValidator.validarEmail(value!),
            ),
            CustomTextField(
              controller: controller.cellphone,
              labelText: 'Telefone',
              inputType: TextInputType.number,
              validator: (value) => UserValidator.validarTelefone(value!),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
            ),
            CustomTextField(
              controller: controller.cpf,
              labelText: 'CPF',
              inputType: TextInputType.number,
              validator: (value) => UserValidator.validarCPF(value!),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter()
              ],
            ),
            CustomTextField(
              controller: controller.password,
              labelText: 'Senha',
              validator: (value) => UserValidator.validarSenha(value!),
              obscureText: true,
            ),
            CustomTextField(
              controller: controller.confirmPassword,
              labelText: 'Confirmar senha',
              obscureText: true,
              validator: (value) => UserValidator.validarConfirmarSenha(
                  value!, controller.password!.text),
            ),
            (isLoading)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 74, 44, 82),
                    ),
                  )
                : CustomTextButton(
                    buttonText: 'Cadastrar',
                    onPressed: () => save(context),
                  ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
