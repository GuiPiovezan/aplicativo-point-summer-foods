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
      drawer: Drawer(backgroundColor: Colors.blueGrey),
      appBar: CustomAppBarHome(
        icon: Icon(Icons.abc),
        title: "home",
      ),
      body: PageView(
        children: [
          Container(color: Colors.red,),
          Container(color: Colors.green,),
          Container(color: Colors.blue,),
        ],
      ),
    );
  }
}
