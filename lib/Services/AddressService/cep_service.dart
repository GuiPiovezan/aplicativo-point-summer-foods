import 'package:flutter/material.dart';

import 'package:pointsf/models/cep_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class CepException implements Exception {
  String message;
  CepException(this.message);
}

class CepService extends ChangeNotifier {
  CepModel? model;

  CepService() {
    _cepService();
  }

  _cepService() {
    model = (model == null) ? CepModel() : model;
    notifyListeners();
  }

  setCEP(cep) async {
    try {
      cep = cep.replaceAll(".", "");
      cep = cep.replaceAll("-", "");

      var url = Uri.https('viacep.com.br', '/ws/$cep/json/', {'q': '{http}'});
      http.Response response;

      response = await http.get(url);

      if (response.statusCode.toString() != "200")
        return throw response.statusCode.toString();

      print('Resposta:' + response.body);

      Map<String, dynamic> resultingData = await json.decode(response.body);
      
      if (!resultingData.containsKey('erro'))
        return throw "Cep não existe";

      model!.bairro = resultingData["bairro"];
      model!.cep = resultingData["cep"];
      model!.cidade = resultingData["localidade"];
      model!.complemento = resultingData["complemento"];
      model!.logradouro = resultingData["logradouro"];
    } catch (e) {
      throw CepException(
          "Erro ao buscar CEP. Server response: " + e.toString());
    }
  }

  getCEP() {
    return model;
  }
}
