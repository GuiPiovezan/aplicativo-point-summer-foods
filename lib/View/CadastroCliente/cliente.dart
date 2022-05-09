import 'dart:html';

class Cliente {
  String? nome;
  String? email;
  String? telefone;
  String? cpf;
  String? senha;

  void salvar(Cliente cliente) {
    print('Nome: $cliente.nome');
  }
}
