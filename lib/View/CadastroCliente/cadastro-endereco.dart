import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pointsf/widgets/export-widgets.dart';

class CadastroEndereco extends StatefulWidget {
  const CadastroEndereco({Key? key}) : super(key: key);

  @override
  State<CadastroEndereco> createState() => _CadastroEndereco();
}

class _CadastroEndereco extends State<CadastroEndereco> {
  TextEditingController txtCEP = TextEditingController();
  TextEditingController _controladorLogradouro = TextEditingController();
  TextEditingController _controladorNumero = TextEditingController();
  TextEditingController _controladorComplemento = TextEditingController();
  TextEditingController _controladorBairro = TextEditingController();
  TextEditingController _controladorCidade = TextEditingController();

  Future<void> buscarCEP() async {
    String cep = txtCEP.text;
    var url = Uri.https('viacep.com.br', '/ws/$cep/json/', {'q': '{http}'});
    http.Response response;

    response = await http.get(url);

    print('Resposta:' + response.body);

    print('Resposta Servidor:' + response.statusCode.toString());
    Map<String, dynamic> dados = json.decode(response.body);

    setState(() {
      _controladorLogradouro = TextEditingController(text: dados["logradouro"]);
      _controladorComplemento =
          TextEditingController(text: dados["complemento"]);
      _controladorBairro = TextEditingController(text: dados["bairro"]);
      _controladorCidade = TextEditingController(text: dados["localidade"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 220, 86),
      appBar: AppBar(
        actions: [
          Image.asset(
            'images/logo-escrita.png',
            width: 100,
            height: 50,
          ),
        ],
        backgroundColor: Color.fromARGB(255, 254, 220, 86),
        title: Center(
          child: Text(
            "Endereço",
            style: TextStyle(color: Colors.black),
          ),
        ),
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
                ),
                SizedBox(
                  width: 15,
                ),
                CustomTextButton(
                  textoBotao: "Buscar",
                  onPressed: buscarCEP,
                  width: 100,
                  heigth: 70,
                ),
              ],
            ),
            CustomTextField(
              controlador: _controladorLogradouro,
              descricaoCampo: 'Logradouro',
              placeholder: 'Rua José Pereira',
            ),
            CustomTextField(
              controlador: _controladorNumero,
              descricaoCampo: 'Numero',
              placeholder: '547',
              inputType: TextInputType.number,
            ),
            CustomTextField(
              controlador: _controladorComplemento,
              descricaoCampo: 'Complemento',
              placeholder: 'Apartamento 13',
            ),
            CustomTextField(
              controlador: _controladorBairro,
              descricaoCampo: 'Bairro',
              placeholder: 'Jardim das Flores',
            ),
            CustomTextField(
              controlador: _controladorCidade,
              descricaoCampo: 'Cidade',
              placeholder: 'São José do Rio Preto',
            ),
            CustomTextButton(
              textoBotao: "Cadastrar",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}