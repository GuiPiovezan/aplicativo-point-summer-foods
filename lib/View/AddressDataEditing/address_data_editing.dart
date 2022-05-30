import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:pointsf/models/address_model.dart';
import 'package:pointsf/models/cep_model.dart';
import 'package:pointsf/Services/AddressService/address_service.dart';
import 'package:pointsf/Services/AddressService/cep_service.dart';
import 'package:pointsf/Services/ControlerService/address_controler_service.dart';
import 'package:pointsf/widgets/export_widgets.dart';

import 'package:brasil_fields/brasil_fields.dart';

class AddressDataEditing extends StatefulWidget {
  final AddressModel model;
  const AddressDataEditing({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<AddressDataEditing> createState() => _AddressDataEditing();
}

class _AddressDataEditing extends State<AddressDataEditing> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddressControllerService controller = AddressControllerService();

  bool enableStreet = false;
  bool enableNumber = true;
  bool enableComplement = true;
  bool enableDistrict = false;
  bool enableCity = false;
  bool enableName = true;
  String cepSearched = "";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      controller.district!.text = widget.model.bairro!;
      controller.cep!.text = widget.model.cep!;
      controller.city!.text = widget.model.cidade!;
      controller.complement!.text = widget.model.complemento!;
      controller.street!.text = widget.model.logradouro!;
      controller.name!.text = widget.model.nome!;
      controller.number!.text = widget.model.numero!;
      cepSearched = widget.model.cep!;
    });
  }

  void save(BuildContext context) async {
    if (cepSearched == controller.cep!.text) {
      AddressModel newModel = AddressModel(
        bairro: controller.district!.text,
        cep: controller.cep!.text,
        cidade: controller.city!.text,
        complemento: controller.complement!.text,
        logradouro: controller.street!.text,
        nome: controller.name!.text,
        numero: controller.number!.text,
        uid: widget.model.uid,
      );
      AddressService().update(newModel, context);
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
        title: "Editar endereço",
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
                (isLoading)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 74, 44, 82),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: CustomTextButton(
                          buttonText: "Buscar",
                          onPressed: searchCEP,
                          width: 100,
                          heigth: 70,
                        ),
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
                  return "Campo nome é obrigatorio!";
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
                  return "Campo nome é obrigatorio!";
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
                  return "Campo nome é obrigatorio!";
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
                  return "Campo nome é obrigatorio!";
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
                  return "Campo nome é obrigatorio!";
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
                  return "Campo nome é obrigatorio!";
                }
                return null;
              },
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: CustomTextButton(
                buttonText: "Salvar",
                onPressed: () => save(context),
              ),
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
