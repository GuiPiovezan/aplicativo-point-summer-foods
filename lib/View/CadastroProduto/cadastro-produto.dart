import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/model/cadastro-produto-model.dart';

import 'package:pointsf/widgets/export-widgets.dart';

class CadastroProduto extends StatefulWidget {
  const CadastroProduto({ Key? key }) : super(key: key);

  @override
  State<CadastroProduto> createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  String? dropDawnUnidadeMedida ;
  String? dropDawnTipo ;
  final firestore = FirebaseFirestore.instance;
  final 

  //final CadastroProdutoModel _model;

  String nome = '';
  String tipoProdutoOuAdicional = '';
  bool status = false;
  String categoria = '';
  String medida = '';
  double preco = 0;

  //CadastroProduto(this._model);

  void salvarProduto(BuildContext context){

    firestore.collection('usuarios').add({
       "nome": nome,
       "tipo": tipoProdutoOuAdicional,
       "status": status,               // ESSA FUNÇÃO VAI SER MOVIDA FUTURAMENTE NÃO MEXER.
       "categoria": categoria,
       "medida": medida,
       "preco": preco,
      });
             
  }

  final TextEditingController _controladorNomeProduto = TextEditingController();
  final TextEditingController _controladorTipoProduto = TextEditingController();
  final TextEditingController _controladorStatusProduto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,254,220,86), //Cor na tela Toda 
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255,254,220,86) , //Cor no App Bar
        title: Center(
          child: Text("Cadastro de Produtos",
          textAlign: TextAlign.end,
            style: TextStyle(fontSize: 20,
            color: Colors.purple,
            ),
          ),
        ),
        leading: Icon(
          Icons.arrow_back_sharp,
          size: 30,
          color: Colors.purple,
        ),
        actions: [
           Image.asset('images/logo-escrita.png',
           width: 100,
           height: 30,
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              CustomTextField(
                controlador: _controladorNomeProduto,
                descricaoCampo: "Nome do Produto",
                placeholder: "Digite",
              ),
              CustomTextField(
                controlador: _controladorTipoProduto,
                descricaoCampo: "Tipo do Produto",
                placeholder: "Digite",
              ),
              CustomTextField(
                controlador: _controladorStatusProduto,
                descricaoCampo: "Status do Produto",
                placeholder: "Digite",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child: DropdownButton(
                  value: dropDawnUnidadeMedida,
                  isExpanded: false,
                  underline: Container(
                    height: 2,
                    color: Colors.purpleAccent,
                  ),
                  //disabledHint: Text("Selecione a categoria desejada"),
                  hint: Text("Selecione a categoria desejada"), 
                  items: categories.map((String categories) {
                  return DropdownMenuItem(
                    value: categories,
                    child: Text(categories),
                  );
                }).toList(), onChanged: (String? value) {  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child: DropdownButton(
                  value: dropDawnUnidadeMedida,
                  isExpanded: false, // Espandir o botão de escolha
                  //disabledHint: Text("Selecione a unidade de medida"), // deixar uma mensagem indicando o que o usurio deve fazer clicando no botão 
                  hint: Text("Selecione a unidade de medida"), // para exibir no botão a opção escolhida  
                  //focusColor: Colors.purple, // cor que o botão irá ficar quando for pressionado
                  //alignment: , // decidir se ficara ao meio ou aos lados
                  elevation: 16, // decidir para qual lado irá ser elevado o menu quando for clicado 
                  underline: Container(
                    height: 2,
                    color: Colors.purpleAccent,
                  ),
                  onChanged: (String? measure) { setState(() {
                   dropDawnUnidadeMedida = measure!;
                }); },
                  items: measure.map((String measure) {
                  return DropdownMenuItem(
                    value: measure,
                    child: Text(measure),
                  );
                }).toList(), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final categorySelected = TextEditingController();

List<String> categories = [
  "Açai",
  "Cupuaçu",
  "Salgados",
  "Porções",
];

final measureSelected = TextEditingController();

List<String> measure = [
  "Ml",
  "Gramas",
  "Unidade",
];