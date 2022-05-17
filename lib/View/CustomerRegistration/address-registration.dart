import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';

import 'package:flutter/services.dart';
import 'package:pointsf/View/export-all-view.dart';
import 'package:pointsf/widgets/export-widgets.dart';
import 'package:uuid/uuid.dart';

import '../Home/home.dart';

class AddressRegistration extends StatefulWidget {
  const AddressRegistration({Key? key}) : super(key: key);

  @override
  State<AddressRegistration> createState() => _AddressRegistration();
}

class _AddressRegistration extends State<AddressRegistration> {
  final TextEditingController _controllerCEP = TextEditingController();
  TextEditingController _controllerStreet = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();
  TextEditingController _controllerComplement = TextEditingController();
  TextEditingController _controllerDistrict = TextEditingController();
  TextEditingController _controllerCity = TextEditingController();
  bool enableLogradouro = false;
  bool enableNumero = false;
  bool enableComplemento = false;
  bool enableBairro = false;
  bool enableCidade = false;
  String cepSearched = "";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  void save(BuildContext context) async {
    if (cepSearched == _controllerCEP.text) {
      var result = await auth.currentUser!.uid;

      var uuid = Uuid();
      var uid = uuid.v1();
      firestore.collection('usuarios').doc(result).collection("enderecos").doc(uid).set({
        "cep": _controllerCEP.text,
        "logradouro": _controllerStreet.text,
        "numero": _controllerNumber.text,
        "complemento": _controllerComplement.text,
        "bairro": _controllerDistrict.text,
        "cidade": _controllerCity.text,
        "uid": uid,
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }
  }

  Future<void> searchCEP() async {
    cepSearched = _controllerCEP.text;

    String cep = _controllerCEP.text;
    cep = cep.replaceAll(".", "");
    cep = cep.replaceAll("-", "");

    var url = Uri.https('viacep.com.br', '/ws/$cep/json/', {'q': '{http}'});
    http.Response response;

    response = await http.get(url);

    print('Resposta:' + response.body);

    print('Resposta Servidor:' + response.statusCode.toString());

    if (response.statusCode.toString() == "200") {
      Map<String, dynamic> resultingData = json.decode(response.body);

      setState(() {
        enableNumero = true;
        if (resultingData["logradouro"] != "") {
          _controllerStreet =
              TextEditingController(text: resultingData["logradouro"]);
          enableLogradouro = false;
        } else {
          _controllerStreet = TextEditingController(text: "");
          enableLogradouro = true;
        }

        if (resultingData["complemento"] != "") {
          _controllerComplement =
              TextEditingController(text: resultingData["complemento"]);
          enableComplemento = false;
        } else {
          _controllerComplement = TextEditingController(text: "");
          enableComplemento = true;
        }

        if (resultingData["bairro"] != "") {
          _controllerDistrict = TextEditingController(text: resultingData["bairro"]);
          enableBairro = false;
        } else {
          _controllerDistrict = TextEditingController(text: "");
          enableBairro = true;
        }

        if (resultingData["localidade"] != "") {
          _controllerCity = TextEditingController(text: resultingData["localidade"]);
          enableCidade = false;
        } else {
          _controllerCity = TextEditingController(text: "");
          enableCidade = true;
        }
      });
    } else {
      setState(() {
        _controllerStreet = TextEditingController(text: "");
        enableLogradouro = true;
        _controllerComplement = TextEditingController(text: "");
        enableComplemento = true;
        _controllerDistrict = TextEditingController(text: "");
        enableBairro = true;
        _controllerCity = TextEditingController(text: "");
        enableCidade = true;
      });
    }
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
                  controller: _controllerCEP,
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
              controller: _controllerStreet,
              labelText: 'Logradouro',
              placeholder: 'Rua José Pereira',
              enable: enableLogradouro,
            ),
            CustomTextField(
              controller: _controllerNumber,
              labelText: 'Numero',
              placeholder: '547',
              inputType: TextInputType.number,
              enable: enableNumero,
            ),
            CustomTextField(
              controller: _controllerComplement,
              labelText: 'Complemento',
              placeholder: 'Apartamento 13',
              enable: enableComplemento,
            ),
            CustomTextField(
              controller: _controllerDistrict,
              labelText: 'Bairro',
              placeholder: 'Jardim das Flores',
              enable: enableBairro,
            ),
            CustomTextField(
              controller: _controllerCity,
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
