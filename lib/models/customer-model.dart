class CustomerModel {
  String? nome;
  String? telefone;
  String? cpf;
  String? uid;
  bool? admin;

  CustomerModel(
      {required this.nome,
      required this.telefone,
      required this.cpf,
      required this.uid,
      required this.admin});

  CustomerModel.fromMap(Map<String, dynamic> map) {
    nome = map['nome'];
    telefone = map['telefone'];
    cpf = map['cpf'];
    uid = map['uid'];
    admin = map['admin'];
  }
}
