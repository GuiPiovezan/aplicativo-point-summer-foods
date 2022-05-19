import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/Services/ProductService/product-service.dart';

class ProductAdditionalModal extends StatefulWidget {
  final productPrimary;
  const ProductAdditionalModal({
    key,
    required this.productPrimary,
  }) : super(key: key);

  @override
  State<ProductAdditionalModal> createState() => _ProductAdditionalModalState();
}

class _ProductAdditionalModalState extends State<ProductAdditionalModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(widget.productPrimary["nome"]),
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: ProductService()
                  .getAdditionalByCategory(widget.productPrimary["categoria"]),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                      height: 57,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(50, 10, 10, 10),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Color.fromARGB(255, 255, 217, 65),
                      ),
                      child: TextButton(
                        child: Text(
                          snapshot.data!.docs[index]["nome"],
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          print(snapshot.data!.docs[index]["nome"]);
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
    );
  }
}
