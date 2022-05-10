import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/View/CadastroCliente/cliente.dart';

import 'package:pointsf/widgets/export-widgets.dart';

class CadastroCliente extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  final tituloTela = 'Cadastro Usuário';

  String nome = '';
  String telefone = '';
  String email = '';
  String senha = '';
  String cpf = '';
  String confirmarSenha = '';

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var result = await auth.createUserWithEmailAndPassword(
          email: email, password: senha);

      firestore.collection('usuarios').doc(result.user!.uid).set({
        "nome": nome,
        "uid": result.user!.uid,
        "telefone": telefone,
        "cpf": cpf,
      });
    }
  }

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
              onSaved: (value) => nome = value!,
              descricaoCampo: 'Nome',
              placeholder: 'Gustavo de Freitas',
            ),
            CustomTextField(
              onSaved: (value) => email = value!,
              descricaoCampo: 'E-mail',
              placeholder: 'email@email.com',
            ),
            CustomTextField(
              onSaved: (value) => telefone = value!,
              descricaoCampo: 'Telefone',
              placeholder: '(17) 99999-9999',
            ),
            CustomTextField(
              onSaved: (value) => cpf = value!,
              descricaoCampo: 'CPF',
              placeholder: '999.999.999-99',
            ),
            CustomTextField(
              onSaved: (value) => senha = value!,
              descricaoCampo: 'Senha',
              placeholder: '*********',
            ),
            CustomTextField(
              onSaved: (value) => confirmarSenha = value!,
              descricaoCampo: 'Confirmar senha',
              placeholder: '*********',
            ),
            CustomTextButton(
              textoBotao: 'Cadastrar',
              onPressed: () {
                save(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
