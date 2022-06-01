import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/Services/ProductService/product_service.dart';
import 'package:pointsf/View/ProductDataEditing/product_data_editing.dart';
import 'package:pointsf/models/product_model.dart';

class ProductAdministrationPage extends StatefulWidget {
  final String category;

  const ProductAdministrationPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ProductAdministrationPage> createState() =>
      _ProductAdministrationPageState();
}

class _ProductAdministrationPageState extends State<ProductAdministrationPage> {
  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  ProductService().getAllProductsByCategory(widget.category),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(25, 10, 10, 10),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Color.fromARGB(255, 240, 240, 240),
                      ),
                      child: TextButton(
                        child: Text(
                          snapshot.data!.docs[index]["nome"],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDataEditing(
                                model: ProductModel(
                                  categoria: snapshot.data!.docs[index]
                                      ["categoria"],
                                  nome: snapshot.data!.docs[index]["nome"],
                                  status: snapshot.data!.docs[index]["status"],
                                  tipo: snapshot.data!.docs[index]["tipo"],
                                  uid: snapshot.data!.docs[index]["uid"],
                                  sizes: null,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      color: const Color.fromARGB(255, 240, 240, 240),
    );
  }
}
