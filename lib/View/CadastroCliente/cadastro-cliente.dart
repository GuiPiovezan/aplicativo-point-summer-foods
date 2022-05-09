import 'package:flutter/material.dart';
import 'package:pointsf/View/CadastroCliente/cliente.dart';
import 'package:pointsf/components/button-primary.dart';
import 'package:pointsf/components/text-input-personalizado.dart';

class CadastroCliente extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Cliente cliente = Cliente();

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorTelefone = TextEditingController();
  final TextEditingController _controladorCpf = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();
  final TextEditingController _controladorConfirmarSenha =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 254, 220, 86),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 254, 220, 86),
        actions: [
          Image.asset(
            'images/logo-escrita.png',
            width: 100,
            height: 30,
          ),
        ],
        title: Text(
          "Cadastro usuário",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back,
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            TextInputPersonalizado(
              controlador: _controladorNome,
              descricaoCampo: 'Nome',
              placeholder: 'Gustavo de Freitas',
            ),
            TextInputPersonalizado(
              controlador: _controladorEmail,
              descricaoCampo: 'E-mail',
              placeholder: 'email@email.com',
            ),
            TextInputPersonalizado(
              controlador: _controladorTelefone,
              descricaoCampo: 'Telefone',
              placeholder: '(17) 99999-9999',
            ),
            TextInputPersonalizado(
              controlador: _controladorCpf,
              descricaoCampo: 'CPF',
              placeholder: '999.999.999-99',
            ),
            TextInputPersonalizado(
              controlador: _controladorSenha,
              descricaoCampo: 'Senha',
              placeholder: '*********',
            ),
            TextInputPersonalizado(
              controlador: _controladorConfirmarSenha,
              descricaoCampo: 'Confirmar senha',
              placeholder: '*********',
            ),
            ButtonPrimary('Cadastrar'),
          ],
        ),
      ),
    );
  }
}
