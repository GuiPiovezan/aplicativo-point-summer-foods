import 'package:flutter/material.dart';

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
          Icons.man_sharp,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
        title: "Rua João Silva, SP",
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
    );
  }
}
