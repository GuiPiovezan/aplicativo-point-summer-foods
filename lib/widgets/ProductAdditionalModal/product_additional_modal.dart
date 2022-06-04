import 'package:flutter/material.dart';

import 'package:pointsf/Services/CartService/cart_service.dart';
import 'package:pointsf/Services/ProductService/product_service.dart';
import 'package:pointsf/widgets/export_widgets.dart';

class ProductAdditionalModal extends StatefulWidget {
  final productPrimary;
  var itens;
  var sizes;
  ProductAdditionalModal({
    key,
    required this.productPrimary,
    this.itens,
    this.sizes,
  }) : super(key: key);

  @override
  State<ProductAdditionalModal> createState() => _ProductAdditionalModalState();
}

class _ProductAdditionalModalState extends State<ProductAdditionalModal> {
  final ProductService productSertvice = ProductService();
  int _itemAmount = 1;
  var size;
  bool sizeError = false;
  @override
  void initState() {
    super.initState();
    setItens();
  }

  setItens() async {
    await productSertvice.getSizeProduct(widget.productPrimary["uid"]);
    setState(() {
      widget.sizes = productSertvice.sizes;
    });
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
    while (widget.itens == null || widget.sizes == null) {
      setItens();
      return ListView(
        children: [
          Column(
            children: const <Widget>[
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
      color: const Color.fromARGB(255, 74, 44, 82),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Text(
              widget.productPrimary["nome"],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 240, 240, 240),
              ),
            ),
          ),
          sizeError
              ? Container(
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(240, 240, 100, 100),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: const Center(
                    child: Text("Selecione um tamanho"),
                  ),
                )
              : Container(),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 240, 240, 240),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.sizes.length,
              itemBuilder: (_, index) {
                return RadioListTile(
                  title: Text("${widget.sizes[index]["tamanho"]} - R\$: ${widget.sizes[index]["preco"]}"),
                  value: index,
                  groupValue: size,
                  onChanged: (newValue) {
                    setState(() {
                      size = newValue;
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              decoration: const BoxDecoration(
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
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 240, 240, 240),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 200, 200, 200),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(7, 7, 0, 7),
                      child: CustomTextButton(
                        buttonText: "-",
                        onPressed: _decrementItemAmount,
                        heigth: 52,
                        width: 52,
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(255, 200, 200, 200),
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      height: 66,
                      width: 52,
                      child: Center(
                        child: Text(
                          _itemAmount.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 200, 200, 200),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 7, 7, 7),
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
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: CustomTextButton(
                    buttonText: "Adicionar",
                    onPressed: () {
                      if (size != null) {
                        CartService().setCartItem(
                          widget.productPrimary["nome"],
                          widget.itens,
                          _itemAmount,
                          widget.sizes[size]["tamanho"],
                          widget.sizes[size]["preco"],
                        );
                        Navigator.of(context).pop();
                      } else {
                        setState(() => sizeError = true);
                      }
                    },
                  ),
                ),
                const SizedBox(
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
