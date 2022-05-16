import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pointsf/widgets/export-widgets.dart';
import 'package:uuid/uuid.dart';

class CadastroProduto extends StatefulWidget {
  const CadastroProduto({Key? key}) : super(key: key);

  @override
  State<CadastroProduto> createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;

  int _value = 0;
  String? dropDawnUnidadeMedida;
  String? dropDawnTipo;
  String? dropDawnStatus;
  String nome = '';
  String tipoProdutoOuAdicional = '';
  String preco = '';

  final TextEditingController _controladorNomeProduto = TextEditingController();
  final TextEditingController _controladorTipoProduto = TextEditingController();
  final TextEditingController _controladorStatusProduto =
      TextEditingController();
  final TextEditingController _controladorPrecoUnidade =
      TextEditingController();

  void save(BuildContext context) {
    var uuid = const Uuid();
    var uid = uuid.v1();
    firestore.collection('produtos').doc(uid).set({
      "nome": _controladorNomeProduto.text,
      "tipo": _controladorTipoProduto.text,
      "status": dropDawnStatus,
      "categoria": dropDawnTipo,
      "medida": dropDawnUnidadeMedida,
      "preco": _controladorPrecoUnidade.text,
      "uid": uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 254, 220, 86), //Cor na tela Toda
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 254, 220, 86), //Cor no App Bar
        title: const Center(
          child: Text(
            "Cadastro de Produtos",
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 20,
              color: Colors.purple,
            ),
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_sharp,
          size: 30,
          color: Colors.purple,
        ),
        actions: [
          Image.asset(
            'images/logo-escrita.png',
            width: 100,
            height: 30,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  onSaved: (value) => nome = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo nome é obrigatorio!";
                    }
                    return null;
                  },
                  controlador: _controladorNomeProduto,
                  descricaoCampo: "Nome do Produto",
                  placeholder: "Nutella",
                ),
                CustomTextField(
                  onSaved: (value) => tipoProdutoOuAdicional = value!,
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Campo tipo do produto é obrigatorio!";
                    return null;
                  },
                  controlador: _controladorTipoProduto,
                  descricaoCampo: "Tipo do Produto",
                  placeholder: "Salgado",
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: 350,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 83, 5, 64),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(20),
                    value: dropDawnStatus,
                    hint: const Text("Selecione o Status do Produto"),
                    isExpanded: false,
                    elevation:
                        16, // decidir para qual lado irá ser elevado o menu quando for clicado
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
                    onChanged: (String? status) {
                      setState(() {
                        dropDawnStatus = status!;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: 350,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 83, 5, 64),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(20),
                    value: dropDawnTipo,
                    isExpanded: false,
                    hint: const Text(
                      "Selecione o tipo de produto",
                      textAlign: TextAlign.center,
                    ),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.purpleAccent,
                    ),
                    onChanged: (String? categories) {
                      setState(() {
                        dropDawnTipo = categories!;
                      });
                    },
                    items: categories.map((String categories) {
                      return DropdownMenuItem(
                        value: categories,
                        child: Text(
                          categories,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: 350,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 83, 5, 64),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(20),
                    value: dropDawnUnidadeMedida,
                    isExpanded: false,
                    hint: const Text("Selecione a unidade de medida"),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.purpleAccent,
                    ),
                    onChanged: (String? measure) {
                      setState(() {
                        dropDawnUnidadeMedida = measure!;
                      });
                    },
                    items: measure.map((String measure) {
                      return DropdownMenuItem(
                        value: measure,
                        child: Text(measure),
                      );
                    }).toList(),
                  ),
                ),
                CustomTextField(
                  onSaved: (value) => preco = value!,
                  validator: (value) {
                    if (value!.isEmpty) return "Campo preço é obrigatorio!";
                    return null;
                  },
                  controlador: _controladorPrecoUnidade,
                  descricaoCampo: "Preço por Unidade",
                  placeholder: "10,00",
                ),
                CustomTextButton(
                  textoBotao: "Cadastrar",
                  onPressed: () => save(context),
                ),
              ],
            ),
          ],
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
  "ML",
  "Gramas",
  "Unidade",
];

final statusSelected = TextEditingController();

List<String> status = [
  "Ativo",
  "Inativo",
];
