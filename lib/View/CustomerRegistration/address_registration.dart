import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:pointsf/models/address_model.dart';
import 'package:pointsf/models/cep_model.dart';
import 'package:pointsf/Services/AddressService/address_service.dart';
import 'package:pointsf/Services/AddressService/cep_service.dart';
import 'package:pointsf/Services/ControlerService/address_controler_service.dart';
import 'package:pointsf/widgets/export_widgets.dart';

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
  bool enableName = false;
  String cepSearched = "";

  bool isLoading = false;
  bool registerIsLoading = false;

  void save(BuildContext context) async {
    if (cepSearched.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("É necessário buscar por um CEP primeiro"),
        ),
      );
    } else if (cepSearched == controller.cep!.text) {
      if (formKey.currentState!.validate()) {
        try {
          setState(() => registerIsLoading = true);
          AddressModel model = AddressModel(
            bairro: controller.district!.text,
            cep: controller.cep!.text,
            cidade: controller.city!.text,
            complemento: controller.complement!.text,
            logradouro: controller.street!.text,
            nome: controller.name!.text,
            numero: controller.number!.text,
            uid: null,
          );
          AddressService().registration(model, context);
        } on AddressException catch (e) {
          setState(() => registerIsLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message)),
          );
        }
      }
    } else {
      setState(() => registerIsLoading = false);
    }
  }

  searchCEP() async {
    setState(() => isLoading = true);
    cepSearched = controller.cep!.text;
    var cepService = CepService();
    try {
      await cepService.setCEP(cepSearched);
      CepModel result = cepService.getCEP();
      controller.setValue(result);

      setState(() {
        controller.city ?? "";
        enableNumber = true;
        enableName = true;
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
        isLoading = false;
      });
    } on CepException catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const CustomAppBar(
        title: "Endereço",
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextField(
                    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    controller: controller.cep,
                    labelText: "CEP",
                    placeholder: "Ex 15200000",
                    width: MediaQuery.of(context).size.width / 2,
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                  ),
                  (isLoading)
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 74, 44, 82),
                          ),
                        )
                      : CustomTextButton(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          buttonText: "Buscar",
                          onPressed: searchCEP,
                          width: MediaQuery.of(context).size.width / 4,
                          heigth: 70,
                        ),
                ],
              ),
              CustomTextField(
                controller: controller.name,
                labelText: 'Nome do endereço',
                placeholder: 'Ex. Trabalho',
                enable: enableName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "De um nome para o endereço";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: controller.street,
                labelText: 'Logradouro',
                placeholder: 'Rua José Pereira',
                enable: enableStreet,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Digite seu logradouro";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: controller.number,
                labelText: 'Numero',
                placeholder: '547',
                inputType: TextInputType.number,
                enable: enableNumber,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Digite o número da sua casa";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: controller.complement,
                labelText: 'Complemento',
                placeholder: 'Apartamento 13',
                enable: enableComplement,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Digite um complemento";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: controller.district,
                labelText: 'Bairro',
                placeholder: 'Jardim das Flores',
                enable: enableDistrict,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Digite o bairro onde reside";
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: controller.city,
                labelText: 'Cidade',
                placeholder: 'São José do Rio Preto',
                enable: enableCity,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Digite sua cidade";
                  }
                  return null;
                },
              ),
              (registerIsLoading)
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 74, 44, 82),
                      ),
                    )
                  : CustomTextButton(
                    buttonText: "Cadastrar",
                    onPressed: () => save(context),
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
