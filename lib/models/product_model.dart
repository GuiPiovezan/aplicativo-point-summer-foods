class ProductModel {
  String? categoria;
  String? medida;
  String? nome;
  String? preco;
  String? status;
  String? tipo;
  String? uid;

  ProductModel({
    required this.categoria,
    required this.medida,
    required this.nome,
    required this.preco,
    required this.status,
    required this.tipo,
    required this.uid,
  });

  ProductModel.fromMap(Map<String, dynamic> map) {
    categoria = map['categoria'];
    medida = map['medida'];
    nome = map['nome'];
    preco = map['preco'];
    status = map['status'];
    tipo = map['tipo'];
    uid = map['uid'];
  }
}
