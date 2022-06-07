class CustomerModel {
  bool? admin;
  String? cpf;
  String? nome;
  String? telefone;
  String? uid;

  CustomerModel({
    required this.admin,
    required this.cpf,
    required this.nome,
    required this.telefone,
    required this.uid,
  });

  CustomerModel.fromMap(Map<String, dynamic> map) {
    admin = map['admin'];
    cpf = map['cpf'];
    nome = map['nome'];
    telefone = map['telefone'];
    uid = map['uid'];
  }
}
