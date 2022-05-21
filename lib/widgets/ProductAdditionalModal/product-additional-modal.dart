import 'package:flutter/material.dart';

import 'package:pointsf/Services/CartService/cart-service.dart';
import 'package:pointsf/Services/ProductService/product-service.dart';
import 'package:pointsf/widgets/export-widgets.dart';

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
  int _itemAmount = 1;
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

  void _incrementItemAmount() {
    setState(() {
      _itemAmount++;
    });
  }

  void _decrementItemAmount() {
    setState(() {
      _itemAmount > 1 ? _itemAmount-- : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    while (widget.itens == null) {
      setItens();
      return ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 300,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ],
      );
    }
    return Container(
      color: Color.fromARGB(255, 74, 44, 82),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Text(
              widget.productPrimary["nome"],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 240, 240, 240),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.itens.length,
                itemBuilder: (ctx, index) {
                  return CheckboxListTile(
                    title: Text(
                        "${widget.itens[index]["nome"]} R\$: ${widget.itens[index]["preco"]}"),
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
          Container(
            color: Color.fromARGB(255, 240, 240, 240),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 200, 200, 200),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(7, 7, 0, 7),
                      child: CustomTextButton(
                        buttonText: "-",
                        onPressed: _decrementItemAmount,
                        heigth: 52,
                        width: 52,
                      ),
                    ),
                    Container(
                      color: Color.fromARGB(255, 200, 200, 200),
                      padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                      height: 66,
                      width: 52,
                      child: Center(
                        child: Text(
                          _itemAmount.toString(),
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 200, 200, 200),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(0, 7, 7, 7),
                      child: CustomTextButton(
                        buttonText: "+",
                        onPressed: _incrementItemAmount,
                        heigth: 52,
                        width: 52,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: CustomTextButton(
                    buttonText: "Adicionar",
                    onPressed: () {
                      CartService().setCartItem(
                        widget.productPrimary["nome"],
                        widget.itens,
                        _itemAmount,
                        widget.productPrimary["preco"],
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
