import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/model/cadastro-produto-model.dart';

enum status  { ativo, inativo }


class CadastroProduto extends StatelessWidget{
  //final CadastroProdutoModel _model;
  final CadastroProdutoModel _model = CadastroProdutoModel();
  


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
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              Padding(padding: EdgeInsets.fromLTRB(50, 15, 50, 15)),
              Image.asset("images/logo.png",
              width: 180,
              height: 180,
              ),
              TextFormField(
                onSaved: (value) => _model.nome = value,
                decoration: InputDecoration(
                  hintText: "Nome",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                    ),
                  ),
                ),
              ),
              TextFormField(
                onSaved: (value) => _model.tipoProdutoOuAdicional = value,
                decoration: InputDecoration(
                  hintText: "Tipo",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                    ),
                  ),
                ),
              ),
              TextFormField(
                onSaved: (value) => _model.status = value,
                decoration: InputDecoration(
                  hintText: "Status",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                    ),
                  ),
                ),
              ),
              DropdownButton(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                isExpanded: true,
                hint: Text("Selecione a categoria desejada"),
                items: categories.map((String categories) {
                return DropdownMenuItem(
                  value: categories,
                  child: Text(categories),
                );
              }).toList(), onChanged: (String? value) {  },
              ),
              DropdownButton(
                isExpanded: true, // Espandir o botão de escolha
                hint: Text("Selecione a unidade de medida"), // deixar uma mensagem indicando o que o usurio deve fazer clicando no botão 
                //hint: , // para exiir no botão a opção escolhida  
                //focusColor: Colors.purple, // cor que o botão irá ficar quando for pressionado
                //alignment: , // decidir se ficara ao meio ou aos lados
                //elevation: , // decidir para qual lado irá ser elevado o menu quando for clicado 
                items: measure.map((String measure) {
                return DropdownMenuItem(
                  value: measure,
                  child: Text(measure),
                );
              }).toList(), onChanged: (String? value) {  },
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