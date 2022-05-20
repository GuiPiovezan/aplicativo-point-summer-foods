import 'package:flutter/material.dart';

import 'package:pointsf/Services/ProductService/product-service.dart';

class ProductAdditionalModal extends StatefulWidget {
  final productPrimary;
  var itens;
  ProductAdditionalModal({
    key,
    required this.productPrimary,
    this.itens,
  }) : super(key: key);

  @override
  State<ProductAdditionalModal> createState() => _ProductAdditionalModalState();
}

class _ProductAdditionalModalState extends State<ProductAdditionalModal> {
  final ProductService productSertvice = ProductService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setItens();
  }

  setItens() async {
    await productSertvice
        .getAdditionalByCategory(widget.productPrimary["categoria"]);
    setState(() {
      widget.itens = productSertvice.itens;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itens == null) return CircularProgressIndicator();
    return Container(
      child: Column(
        children: [
          Text(widget.productPrimary["nome"]),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: widget.itens.length,
                itemBuilder: (ctx, index) {
                  return CheckboxListTile(
                    title: Text(widget.itens[index]["nome"]),
                    subtitle: Text(
                      "Este item ${widget.itens[index]['check'] ? '' : 'não '}está selecionado",
                    ),
                    value: widget.itens[index]["check"],
                    onChanged: (newValue) {
                      setState(() {
                        widget.itens[index]["check"] = newValue;
                      });
                      print(
                        "Mudou check da palavra ${widget.itens[index]["nome"]}para: $newValue",
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
