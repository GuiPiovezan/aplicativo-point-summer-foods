import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:pointsf/View/export-all-view.dart';

import 'package:pointsf/widgets/export-widgets.dart';

class AddressRegistration extends StatefulWidget {
  const AddressRegistration({Key? key}) : super(key: key);

  @override
  State<AddressRegistration> createState() => _AddressRegistration();
}

class _AddressRegistration extends State<AddressRegistration> {
  TextEditingController txtCEP = TextEditingController();
  TextEditingController _controladorLogradouro = TextEditingController();
  TextEditingController _controladorNumero = TextEditingController();
  TextEditingController _controladorComplemento = TextEditingController();
  TextEditingController _controladorBairro = TextEditingController();
  TextEditingController _controladorCidade = TextEditingController();
  bool enableLogradouro = false;
  bool enableNumero = false;
  bool enableComplemento = false;
  bool enableBairro = false;
  bool enableCidade = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  void save(BuildContext context) async {
    var result = await auth.currentUser!.uid;

    firestore.collection('usuarios').doc(result).collection("enderecos").add({
      "cep": txtCEP.text,
      "logradouro": _controladorLogradouro.text,
      "numero": _controladorNumero.text,
      "complemento": _controladorComplemento.text,
      "bairro": _controladorBairro.text,
      "cidade": _controladorCidade.text,
    });
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  Future<void> searchCEP() async {
    String cep = txtCEP.text;
    cep = cep.replaceAll(".", "");
    cep = cep.replaceAll("-", "");

    var url = Uri.https('viacep.com.br', '/ws/$cep/json/', {'q': '{http}'});
    http.Response response;

    response = await http.get(url);

    print('Resposta:' + response.body);

    print('Resposta Servidor:' + response.statusCode.toString());

    if (response.statusCode.toString() == "200") {
      Map<String, dynamic> dados = json.decode(response.body);

      setState(() {
        enableNumero = true;
        if (dados["logradouro"] != "") {
          _controladorLogradouro =
              TextEditingController(text: dados["logradouro"]);
          enableLogradouro = false;
        } else {
          _controladorLogradouro = TextEditingController(text: "");
          enableLogradouro = true;
        }

        if (dados["complemento"] != "") {
          _controladorComplemento =
              TextEditingController(text: dados["complemento"]);
          enableComplemento = false;
        } else {
          _controladorComplemento = TextEditingController(text: "");
          enableComplemento = true;
        }

        if (dados["bairro"] != "") {
          _controladorBairro = TextEditingController(text: dados["bairro"]);
          enableBairro = false;
        } else {
          _controladorBairro = TextEditingController(text: "");
          enableBairro = true;
        }

        if (dados["localidade"] != "") {
          _controladorCidade = TextEditingController(text: dados["localidade"]);
          enableCidade = false;
        } else {
          _controladorCidade = TextEditingController(text: "");
          enableCidade = true;
        }
      });
    } else {
      setState(() {
        _controladorLogradouro = TextEditingController(text: "");
        enableLogradouro = true;
        _controladorComplemento = TextEditingController(text: "");
        enableComplemento = true;
        _controladorBairro = TextEditingController(text: "");
        enableBairro = true;
        _controladorCidade = TextEditingController(text: "");
        enableCidade = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 220, 86),
      appBar: CustomAppBar(
        title: "Endereço",
        enableIconBack: false,
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  controlador: txtCEP,
                  descricaoCampo: "CEP",
                  placeholder: "Ex 15200000",
                  width: 200,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                CustomTextButton(
                  textoBotao: "Buscar",
                  onPressed: searchCEP,
                  width: 100,
                  heigth: 70,
                ),
              ],
            ),
            CustomTextField(
              controlador: _controladorLogradouro,
              descricaoCampo: 'Logradouro',
              placeholder: 'Rua José Pereira',
              enable: enableLogradouro,
            ),
            CustomTextField(
              controlador: _controladorNumero,
              descricaoCampo: 'Numero',
              placeholder: '547',
              inputType: TextInputType.number,
              enable: enableNumero,
            ),
            CustomTextField(
              controlador: _controladorComplemento,
              descricaoCampo: 'Complemento',
              placeholder: 'Apartamento 13',
              enable: enableComplemento,
            ),
            CustomTextField(
              controlador: _controladorBairro,
              descricaoCampo: 'Bairro',
              placeholder: 'Jardim das Flores',
              enable: enableBairro,
            ),
            CustomTextField(
              controlador: _controladorCidade,
              descricaoCampo: 'Cidade',
              placeholder: 'São José do Rio Preto',
              enable: enableCidade,
            ),
            CustomTextButton(
              textoBotao: "Cadastrar",
              onPressed: () {
                save(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
