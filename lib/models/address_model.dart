class AddressModel {
  String? cep;
  String? logradouro;
  String? bairro;
  String? complemento;
  String? numero;
  String? cidade;

  AddressModel.fromMap(Map<String, dynamic> map) {
    cep = map['cep'];
    logradouro = map['logradouro'];
    bairro = map['bairro'];
    complemento = map['complemento'];
    numero = map['numero'];
    cidade = map['cidade'];
  }
}
