class OrderValidator {
  static String? validarTroco(String trocoRecebido) {
    if (trocoRecebido.isEmpty) return 'Troco é obrigatório';
    return null;
  }
}
