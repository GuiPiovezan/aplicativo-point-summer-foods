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

  bool enableStreet = false;
  bool enableNumber = false;
  bool enableComplement = false;
  bool enableDistrict = false;
  bool enableCity = false;
  String cepSearched = "";

  void save(BuildContext context) async {
    if (cepSearched == controller.cep!.text) {
      AddressModel model = AddressModel(
        bairro: controller.district!.text,
        cep: controller.cep!.text,
        cidade: controller.city!.text,
        complemento: controller.complement!.text,
        logradouro: controller.street!.text, 
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
      enableNumber = true;
      controller.city!.text != "" ? enableCity = false : enableCity = true;
      controller.complement!.text != ""
          ? enableComplement = false
          : enableComplement = true;
      controller.district!.text != ""
          ? enableDistrict = false
          : enableDistrict = true;
      controller.street!.text != ""
          ? enableStreet = false
          : enableStreet = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
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
              enable: enableStreet,
            ),
            CustomTextField(
              controller: controller.number,
              labelText: 'Numero',
              placeholder: '547',
              inputType: TextInputType.number,
              enable: enableNumber,
            ),
            CustomTextField(
              controller: controller.complement,
              labelText: 'Complemento',
              placeholder: 'Apartamento 13',
              enable: enableComplement,
            ),
            CustomTextField(
              controller: controller.district,
              labelText: 'Bairro',
              placeholder: 'Jardim das Flores',
              enable: enableDistrict,
            ),
            CustomTextField(
              controller: controller.city,
              labelText: 'Cidade',
              placeholder: 'São José do Rio Preto',
              enable: enableCity,
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
