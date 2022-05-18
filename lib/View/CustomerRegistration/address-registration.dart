import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:pointsf/models/address-model.dart';
import 'package:pointsf/models/cep-model.dart';

import 'package:pointsf/Services/AddressService/address-service.dart';
import 'package:pointsf/Services/AddressService/cep-service.dart';
import 'package:pointsf/Services/ControlerService/address-controler-service.dart';

import 'package:pointsf/widgets/export-widgets.dart';

import 'package:brasil_fields/brasil_fields.dart';

class AddressRegistration extends StatefulWidget {
  const AddressRegistration({Key? key}) : super(key: key);

  @override
  State<AddressRegistration> createState() => _AddressRegistration();
}

class _AddressRegistration extends State<AddressRegistration> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddressControllerService controller = AddressControllerService();

  bool enableLogradouro = false;
  bool enableNumero = false;
  bool enableComplemento = false;
  bool enableBairro = false;
  bool enableCidade = false;
  String cepSearched = "";

  void save(BuildContext context) async {
    if (cepSearched == controller.cep!.text) {
      AddressModel model = AddressModel(
        bairro: controller.cep!.text,
        cep: controller.street!.text,
        cidade: controller.city!.text,
        complemento: controller.complement!.text,
        logradouro: controller.district!.text,
        numero: controller.number!.text,
        uid: null,
      );
      AddressService().registration(model, context);
    }
  }

  searchCEP() async {
    cepSearched = controller.cep!.text;
    var cepService = CepService();

    try {
      await cepService.setCEP(cepSearched);
      CepModel result = cepService.getCEP();
      controller.setValue(result);
    } on CepException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    setState(() {
      controller.city ?? "";
      enableNumero = true;
      controller.city!.text != "" ? enableCidade = false : enableCidade = true;
      controller.complement!.text != ""
          ? enableComplemento = false
          : enableComplemento = true;
      controller.district!.text != ""
          ? enableBairro = false
          : enableBairro = true;
      controller.street!.text != ""
          ? enableLogradouro = false
          : enableLogradouro = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 220, 86),
      appBar: const CustomAppBar(
        title: "Endereço",
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  controller: controller.cep,
                  labelText: "CEP",
                  placeholder: "Ex 15200000",
                  width: 200,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                CustomTextButton(
                  buttonText: "Buscar",
                  onPressed: searchCEP,
                  width: 100,
                  heigth: 70,
                ),
              ],
            ),
            CustomTextField(
              controller: controller.street,
              labelText: 'Logradouro',
              placeholder: 'Rua José Pereira',
              enable: enableLogradouro,
            ),
            CustomTextField(
              controller: controller.number,
              labelText: 'Numero',
              placeholder: '547',
              inputType: TextInputType.number,
              enable: enableNumero,
            ),
            CustomTextField(
              controller: controller.complement,
              labelText: 'Complemento',
              placeholder: 'Apartamento 13',
              enable: enableComplemento,
            ),
            CustomTextField(
              controller: controller.district,
              labelText: 'Bairro',
              placeholder: 'Jardim das Flores',
              enable: enableBairro,
            ),
            CustomTextField(
              controller: controller.city,
              labelText: 'Cidade',
              placeholder: 'São José do Rio Preto',
              enable: enableCidade,
            ),
            CustomTextButton(
              buttonText: "Cadastrar",
              onPressed: () => save(context),
            ),
          ],
        ),
      ),
    );
  }
}
