class ProductModel {
  String? categoria;
  String? nome;
  String? status;
  String? tipo;
  String? uid;
  List<Map<String, dynamic>>? sizes;

  ProductModel({
    required this.categoria,
    required this.nome,
    required this.status,
    required this.tipo,
    required this.uid,
    required this.sizes,
  });

  ProductModel.fromMap(Map<String, dynamic> map) {
    categoria = map['categoria'];
    nome = map['nome'];
    status = map['status'];
    tipo = map['tipo'];
    uid = map['uid'];
    sizes = map['sizes'];
  }
}
