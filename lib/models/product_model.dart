class ProductModel {
  String? categoria;
  String? nome;
  List<Map<String, dynamic>>? sizes;
  String? status;
  String? tipo;
  String? uid;

  ProductModel({
    required this.categoria,
    required this.nome,
    required this.sizes,
    required this.status,
    required this.tipo,
    required this.uid,
  });

  ProductModel.fromMap(Map<String, dynamic> map) {
    categoria = map['categoria'];
    nome = map['nome'];
    sizes = map['sizes'];
    status = map['status'];
    tipo = map['tipo'];
    uid = map['uid'];
  }
}
