import 'package:flutter/material.dart';

import 'package:pointsf/Services/CartService/cart-service.dart';
import 'package:pointsf/View/Cart/cart.dart';
import 'package:pointsf/widgets/export-widgets.dart';

class CartPage extends StatefulWidget {
  var cartItens;

  CartPage({
    Key? key,
    this.cartItens,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartService cartService = CartService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCart();
  }

  Future<void> setCart() async {
    await cartService.setCart();
    setState(() {
      widget.cartItens = cartService.cartItens;
    });
  }

  @override
  Widget build(BuildContext context) {
    while (widget.cartItens == null) {
      setCart();
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
      color: Color.fromARGB(0, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Seus produtos:",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: RefreshIndicator(
                      onRefresh: setCart,
                      child: ListView.builder(
                        itemCount: widget.cartItens.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            // color: Colors.amber,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 225, 225, 225),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 5, 0, 30),
                                        child: Text(
                                          widget.cartItens[index]["quantidade"]
                                                  .toString() +
                                              "x",
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                widget.cartItens[index]
                                                    ["produto"],
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 15, 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: widget
                                                    .cartItens[index]
                                                        ["adicionais"]
                                                    .length,
                                                itemBuilder:
                                                    (ctx, indexAdditional) {
                                                  return Container(
                                                    child: Text(
                                                      widget.cartItens[index]
                                                                  ["adicionais"]
                                                              [indexAdditional]
                                                          ["adicional"],
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  height: 40,
                                  width: 40,
                                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: IconButton(
                                    icon: Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      print(widget.cartItens[index]["uid"]);
                                      cartService.removeItemFromCard(
                                          widget.cartItens[index]["uid"]);
                                      widget.cartItens.remove(index);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: ((context) => Cart()),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              CustomTextButton(
                buttonText: "Finalizar",
                onPressed: () {},
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
