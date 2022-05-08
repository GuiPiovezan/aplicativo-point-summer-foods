import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 15, 15, 10),
                    width: 150,
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
                    // width: 267,
                    height: 51,
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
                          width: 1,
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
              Text(resultadoCEP),
            ],
          ),
        ),
      ),
    );
  }
}
