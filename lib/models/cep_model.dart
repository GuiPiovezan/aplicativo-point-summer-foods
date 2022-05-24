class CepModel {
  String? bairro;
  String? cep;
  String? cidade;
  String? complemento;
  String? logradouro;

  CepModel({
    this.bairro,
    this.cep,
    this.cidade,
    this.complemento,
    this.logradouro,
  });

  CepModel.fromMap(Map<String, dynamic> map) {
    bairro = map['bairro'];
    cep = map['cep'];
    cidade = map['cidade'];
    complemento = map['complemento'];
    logradouro = map['logradouro'];
  }
}
