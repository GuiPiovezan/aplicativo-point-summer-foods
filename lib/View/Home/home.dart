import 'package:flutter/material.dart';
import 'package:pointsf/widgets/AppBar/custom-appbar-home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: Color.fromARGB(255, 254, 220, 86),
      ),
      appBar: const CustomAppBarHome(
        icon: Icon(Icons.man_sharp),
        title: "Rua João Silva, SP",
      ),
      body: PageView(
        children: [
          Container(
            child: Center(
              child: Text("Tela1"),
            ),
            color: Color.fromARGB(255, 254, 220, 86),
          ),
          Container(
            child: Center(
              child: Text("Tela2"),
            ),
            color: Color.fromARGB(255, 254, 220, 86),
          ),
          Container(
            child: Center(
              child: Text("Tela3"),
            ),
            color: Color.fromARGB(255, 254, 220, 86),
          ),
        ],
      ),
    );
  }
}
