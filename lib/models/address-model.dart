class AddressModel {
  String? bairro;
  String? cep;
  String? cidade;
  String? complemento;
  String? logradouro;
  String? nome;
  String? numero;
  String? uid;

  AddressModel({
    required this.bairro,
    required this.cep,
    required this.cidade,
    required this.complemento,
    required this.logradouro,
    required this.nome,
    required this.numero,
    required this.uid,
  });

  AddressModel.fromMap(Map<String, dynamic> map) {
    bairro = map['bairro'];
    cep = map['cep'];
    cidade = map['cidade'];
    complemento = map['complemento'];
    logradouro = map['logradouro'];
    nome = map["nome"];
    numero = map['numero'];
    uid = map['uid'];
  }
}
