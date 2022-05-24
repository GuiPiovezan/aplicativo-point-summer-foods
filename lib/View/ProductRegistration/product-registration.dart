import 'package:flutter/material.dart';

import 'package:pointsf/models/product-model.dart';
import 'package:pointsf/Services/ProductService/product-service.dart';
import 'package:pointsf/widgets/export-widgets.dart';

class ProductRegistration extends StatefulWidget {
  const ProductRegistration({Key? key}) : super(key: key);

  @override
  State<ProductRegistration> createState() => _ProductRegistrationState();
}

class _ProductRegistrationState extends State<ProductRegistration> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? dropDownUnitOfMeasurement;
  String? dropDownCategory;
  String? dropDownStatus;
  String? dropDownType;

  String productName = '';
  String productPrice = '';

  final TextEditingController _controllerProductName = TextEditingController();
  final TextEditingController _controllerProductPrice = TextEditingController();

  void save(BuildContext context) {
    ProductModel model = ProductModel(
      categoria: dropDownCategory,
      medida: dropDownUnitOfMeasurement,
      nome: _controllerProductName.text,
      preco: _controllerProductPrice.text,
      status: dropDownStatus,
      tipo: dropDownType,
      uid: null,
    );

    ProductService().registration(model, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const CustomAppBar(
        title: "Cadastro de Produtos",
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
                  onSaved: (value) => productName = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Campo nome é obrigatorio!";
                    }
                    return null;
                  },
                  controller: _controllerProductName,
                  labelText: "Nome do Produto",
                  placeholder: "Nutella",
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: 350,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 74, 44, 82),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: DropdownButton(
                    itemHeight: 70,
                    style: TextStyle(
                      color: Color.fromARGB(255, 74, 44, 82),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    value: dropDownType,
                    isExpanded: false,
                    hint: const Text(
                      "Selecione o tipo de produto",
                      textAlign: TextAlign.center,
                    ),
                    elevation: 16,
                    underline: Container(),
                    onChanged: (String? typeProduct) {
                      setState(() {
                        dropDownType = typeProduct!;
                      });
                    },
                    items: typeProduct.map((String categories) {
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
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 74, 44, 82),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: DropdownButton(
                    itemHeight: 70,
                    style: TextStyle(
                      color: Color.fromARGB(255, 74, 44, 82),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    value: dropDownStatus,
                    hint: const Text("Selecione o Status do Produto"),
                    isExpanded: false,
                    elevation:
                        16, // decidir para qual lado irá ser elevado o menu quando for clicado
                    underline: Container(),
                    items: status.map((String status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (String? status) {
                      setState(() {
                        dropDownStatus = status!;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: 350,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 74, 44, 82),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: DropdownButton(
                    itemHeight: 70,
                    style: TextStyle(
                      color: Color.fromARGB(255, 74, 44, 82),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    value: dropDownCategory,
                    isExpanded: false,
                    hint: const Text(
                      "Selecione a categoria do produto",
                      textAlign: TextAlign.center,
                    ),
                    elevation: 16,
                    underline: Container(),
                    onChanged: (String? categories) {
                      setState(() {
                        dropDownCategory = categories!;
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
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(255, 74, 44, 82),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: DropdownButton(
                    itemHeight: 70,
                    style: TextStyle(
                      color: Color.fromARGB(255, 74, 44, 82),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    value: dropDownUnitOfMeasurement,
                    isExpanded: false,
                    hint: const Text("Selecione a unidade de medida"),
                    elevation: 16,
                    underline: Container(),
                    onChanged: (String? measure) {
                      setState(() {
                        dropDownUnitOfMeasurement = measure!;
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
                  onSaved: (value) => productPrice = value!,
                  validator: (value) {
                    if (value!.isEmpty) return "Campo preço é obrigatorio!";
                    return null;
                  },
                  controller: _controllerProductPrice,
                  labelText: "Preço por Unidade",
                  placeholder: "10,00",
                ),
                CustomTextButton(
                  buttonText: "Cadastrar",
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

// dropDawnTipo
final typeSelected = TextEditingController();

List<String> typeProduct = [
  "Primario",
  "Adicional",
];
