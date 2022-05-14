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

  int _value = 0;
  String? dropDawnUnidadeMedida ;
  String? dropDawnTipo ;
  String? dropDawnStatus ; 

  final firestore = FirebaseFirestore.instance;
  final 

  //final CadastroProdutoModel _model;

  String nome = '';
  String tipoProdutoOuAdicional = '';
  //bool status = false;
  String categoria = '';
  String medida = '';
  double preco = 0;

  final TextEditingController _controladorNomeProduto = TextEditingController();
  final TextEditingController _controladorTipoProduto = TextEditingController();
  final TextEditingController _controladorStatusProduto = TextEditingController();
  final TextEditingController _controladorPrecoUnidade = TextEditingController();

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
      body:     
       ListView(
        children: [
          Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                controlador: _controladorNomeProduto,
                descricaoCampo: "Nome do Produto",
                placeholder: "Nutella",
              ),
              CustomTextField(
                controlador: _controladorTipoProduto,
                descricaoCampo: "Tipo do Produto",
                placeholder: "Salgado",
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 2,
                    color: Color.fromARGB(255, 83, 5, 64),
                    style: BorderStyle.solid,
                  ),
                ),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(20),
                  value: dropDawnStatus,
                  hint: Text("Selecione o Status do Produto"),
                  isExpanded: false,
                  elevation: 16, // decidir para qual lado irá ser elevado o menu quando for clicado 
                  underline: Container(
                    height: 2,
                    color: Colors.purpleAccent,
                  ),
                  items: status.map((String status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                  onChanged: (String? status) { setState(() {
                   dropDawnStatus = status!;
                   }
                  );
                },
                )
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(value: 1, groupValue: _value, onChanged: (value){
                    setState(() {
                      //_value = value;
                    });
                  }),
                  SizedBox(width: 10.0,),
                  Text("Ativo")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio(value: 2, groupValue: _value, onChanged: (value){
                    setState(() {
                     // _value = value;
                    });
                  }),
                  SizedBox(width: 10.0,),
                  Text("Desativado")
                ]
              ),*/
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 2,
                    color: Color.fromARGB(255, 83, 5, 64),
                    style: BorderStyle.solid,
                  ),
                ),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(20),
                  value: dropDawnTipo,
                  isExpanded: false, // Espandir o botão de escolha
                  //disabledHint: Text("Selecione a unidade de medida"), // deixar uma mensagem indicando o que o usurio deve fazer clicando no botão 
                  hint: Text("Selecione o tipo de produto",
                  textAlign: TextAlign.center,
                  ), // para exibir no botão a opção escolhida  
                  //focusColor: Colors.purple, // cor que o botão irá ficar quando for pressionado
                  //alignment: , // decidir se ficara ao meio ou aos lados
                  elevation: 16, // decidir para qual lado irá ser elevado o menu quando for clicado 
                  underline: Container(
                    height: 2,
                    color: Colors.purpleAccent,
                  ),
                  onChanged: (String? categories) { setState(() {
                   dropDawnTipo = categories!;
                }); },
                  items: categories.map((String categories) {
                  return DropdownMenuItem(
                    value: categories,
                    child: Text(categories,
                    textAlign: TextAlign.center,
                    ),
                  );
                }).toList(), 
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0,20,0,5),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                width: 350,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 2,
                    color: Color.fromARGB(255, 83, 5, 64),
                    style: BorderStyle.solid,
                  ),
                ),
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(20),
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
              CustomTextField(
                controlador: _controladorPrecoUnidade,
                descricaoCampo: "Preço por Unidade",
                placeholder: "10,00", // passar esse placehouder como String
              ),
              CustomTextButton(
                textoBotao: "Cadastrar",
                onPressed: () {},
                
              ),
            ],
          ),
        ),
        ],
      )
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
  "ML",
  "Gramas",
  "Unidade",
];

final statusSelected = TextEditingController();

List<String> status = [
  "Ativo",
  "Desativo",
];