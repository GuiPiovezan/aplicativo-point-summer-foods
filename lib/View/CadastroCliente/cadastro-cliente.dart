import 'package:flutter/material.dart';
import 'package:pointsf/View/CadastroCliente/cliente.dart';

import 'package:pointsf/widgets/export-widgets.dart';

class CadastroCliente extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final tituloTela = 'Cadastro Usuário';

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
          tituloTela,
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
            CustomTextField(
              controlador: _controladorNome,
              descricaoCampo: 'Nome',
              placeholder: 'Gustavo de Freitas',
            ),
            CustomTextField(
              controlador: _controladorEmail,
              descricaoCampo: 'E-mail',
              placeholder: 'email@email.com',
            ),
            CustomTextField(
              controlador: _controladorTelefone,
              descricaoCampo: 'Telefone',
              placeholder: '(17) 99999-9999',
            ),
            CustomTextField(
              controlador: _controladorCpf,
              descricaoCampo: 'CPF',
              placeholder: '999.999.999-99',
            ),
            CustomTextField(
              controlador: _controladorSenha,
              descricaoCampo: 'Senha',
              placeholder: '*********',
            ),
            CustomTextField(
              controlador: _controladorConfirmarSenha,
              descricaoCampo: 'Confirmar senha',
              placeholder: '*********',
            ),
            CustomTextButton(
              textoBotao: 'Cadastrar',
              onPressed: () {
                Cliente().salvar(
                  nome: _controladorNome,
                  email: _controladorEmail,
                  telefone: _controladorTelefone,
                  cpf: _controladorCpf,
                  senha: _controladorSenha,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
