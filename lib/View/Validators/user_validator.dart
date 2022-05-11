class UserValidator {
  static String? validarNome(String nome) {
    if (nome.isEmpty) {
      return 'Nome é obrigatório';
    }

    if (nome.length < 4) {
      return 'Nome inválido';
    }
  }

  static String? validarEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (email.isEmpty) return 'E-mail é obrigatório';
    if (!regex.hasMatch(email)) return 'E-mail inválido';
  }
}
