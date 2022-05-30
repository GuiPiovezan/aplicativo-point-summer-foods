import 'package:flutter/material.dart';

import 'package:pointsf/models/product_model.dart';
import 'package:pointsf/Services/ProductService/product_service.dart';
import 'package:pointsf/widgets/export_widgets.dart';

class ProductRegistration extends StatefulWidget {
  const ProductRegistration({Key? key}) : super(key: key);

  @override
  State<ProductRegistration> createState() => _ProductRegistrationState();
}

class _ProductRegistrationState extends State<ProductRegistration> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> sizes = [];

  String? dropDownCategory;
  String? dropDownStatus;
  String? dropDownType;

  String productName = '';
  String productPrice = '';

  final TextEditingController _controllerProductName = TextEditingController();
  final TextEditingController _controllerProductSize = TextEditingController();
  final TextEditingController _controllerProductPrice = TextEditingController();

  void save(BuildContext context) {
    if (sizes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("É preciso adicionar um tamanho")),
      );
    } else if (formKey.currentState!.validate()) {
      ProductModel model = ProductModel(
        categoria: dropDownCategory,
        nome: _controllerProductName.text,
        status: dropDownStatus,
        tipo: dropDownType,
        uid: null,
        sizes: sizes,
      );

      ProductService().registration(model, context);
    }
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
                  child: DropdownButtonFormField(
                    itemHeight: 70,
                    style: const TextStyle(
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
                    validator: (value) {
                      if (value == null) return "Selecione um";
                      return null;
                    },
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
                  child: DropdownButtonFormField(
                    itemHeight: 70,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 74, 44, 82),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    value: dropDownStatus,
                    hint: const Text("Selecione o Status do Produto"),
                    isExpanded: false,
                    elevation: 16,
                    validator: (value) {
                      if (value == null) return "Selecione um";
                      return null;
                    },
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
                  child: DropdownButtonFormField(
                    itemHeight: 70,
                    style: const TextStyle(
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
                    validator: (value) {
                      if (value == null) return "Selecione um";
                      return null;
                    },
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
                if (sizes.isNotEmpty)
                  SizedBox(
                    height: 100,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: sizes.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "tamanho: ${sizes[index]['size']}, Preço: ${sizes[index]['price']}",
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                else
                  Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      width: 140,
                      controller: _controllerProductSize,
                      labelText: "Tamanho",
                      placeholder: "500ml",
                    ),
                    const SizedBox(width: 20),
                    CustomTextField(
                      width: 140,
                      controller: _controllerProductPrice,
                      labelText: "Preço",
                      placeholder: "15,00",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextButton(
                  buttonText: "Adicionar tamanho",
                  width: 280,
                  onPressed: () {
                    Map<String, dynamic> newSize = {
                      "size": _controllerProductSize.text,
                      "price": _controllerProductPrice.text,
                    };
                    setState(() {
                      sizes.add(newSize);
                    });
                    _controllerProductSize.clear();
                    _controllerProductPrice.clear();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextButton(
                  buttonText: "Cadastrar",
                  onPressed: () => save(context),
                ),
                const SizedBox(
                  height: 30,
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
  "Salgado",
  "Bebida",
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
