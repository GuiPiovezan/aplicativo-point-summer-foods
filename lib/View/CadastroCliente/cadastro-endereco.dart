import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pointsf/components/button-primary.dart';
import 'package:pointsf/components/text-input-personalizado.dart';

class CadastroEndereco extends StatefulWidget {
  const CadastroEndereco({Key? key}) : super(key: key);

  @override
  State<CadastroEndereco> createState() => _CadastroEndereco();
}

class _CadastroEndereco extends State<CadastroEndereco> {
  String resultadoCEP = "";
  TextEditingController txtCEP = TextEditingController();

  Future<void> buscarCEP() async {
    String cep = txtCEP.text;
    var url = Uri.https('viacep.com.br', '/ws/$cep/json/', {'q': '{http}'});
    http.Response response;

    response = await http.get(url);

    print('Resposta:' + response.body);

    print('Resposta Servidor:' + response.statusCode.toString());
    Map<String, dynamic> dados = json.decode(response.body);

    String logradouro = dados["logradouro"];
    String complemento = dados["complemento"];
    String bairro = dados["bairro"];
    String localidade = dados["localidade"];

    String respostaCEP =
        "Endereço\n$logradouro\nComplemento:\n$complemento\nBairro:\n$bairro\nCidade:\n$localidade";

    setState(() {
      resultadoCEP = respostaCEP;
    });
  }

  final TextEditingController _controladorLogradouro = TextEditingController();
  final TextEditingController _controladorNumero = TextEditingController();
  final TextEditingController _controladorComplemento = TextEditingController();
  final TextEditingController _controladorBairro = TextEditingController();
  final TextEditingController _controladorCidade = TextEditingController();

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
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    width: 150,
                    height: 52,
                    child: TextField(
                      controller: txtCEP,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "CEP",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 83, 5, 64),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 52,
                    child: TextButton(
                      onPressed: buscarCEP,
                      child: Text(
                        "Buscar CEP",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        backgroundColor: Color.fromARGB(255, 83, 5, 64),
                        side: BorderSide(
                          color: Colors.white,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextInputPersonalizado(
                controlador: _controladorLogradouro,
                descricaoCampo: 'Logradouro',
                placeholder: 'Rua José Pereira',
              ),
              TextInputPersonalizado(
                controlador: _controladorNumero,
                descricaoCampo: 'Numero',
                placeholder: '547',
              ),
              TextInputPersonalizado(
                controlador: _controladorComplemento,
                descricaoCampo: 'Complemento',
                placeholder: 'Apartamento 13',
              ),
              TextInputPersonalizado(
                controlador: _controladorBairro,
                descricaoCampo: 'Bairro',
                placeholder: 'Jardim das Flores',
              ),
              TextInputPersonalizado(
                controlador: _controladorCidade,
                descricaoCampo: 'Cidade',
                placeholder: 'São José do Rio Preto',
              ),
              ButtonPrimary(
                textoBotao: "Cadastrar",
                funcao: () {},
              ),
              
              Text(resultadoCEP),
            ],
          ),
        ),
      ),
    );
  }
}
