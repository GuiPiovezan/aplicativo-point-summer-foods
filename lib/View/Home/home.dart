import 'package:flutter/material.dart';

import 'package:pointsf/View/Cart/cart.dart';
import 'package:pointsf/widgets/export-widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      drawer: CustomDrawer(),
      appBar: CustomAppBarHome(
        icon: Icon(
          Icons.screen_search_desktop_sharp,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
        title: " Cardapio",
      ),
      body: PageView(
        children: [
          ProductPage(
            category: "Açai",
          ),
          ProductPage(
            category: "Salgados",
          ),
          ProductPage(
            category: "Porções",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 74, 44, 82),
        child: const Icon(
          Icons.shopping_cart,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => Cart()),
            ),
          );
        },
      ),
    );
  }
}
