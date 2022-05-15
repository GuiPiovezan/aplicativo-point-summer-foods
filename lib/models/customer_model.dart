class CustomerModel {
  String? nome;
  String? telefone;
  String? cpf;
  String? uid;

  CustomerModel(
      {required this.nome,
      required this.telefone,
      required this.cpf,
      required this.uid});

  CustomerModel.fromMap(Map<String, dynamic> map) {
    nome = map['nome'];
    telefone = map['telefone'];
    cpf = map['cpf'];
    uid = map['uid'];
  }
}
