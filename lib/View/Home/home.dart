import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/widgets/AppBar/custom-appbar-home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String? _email;

  @override
  void initState() {
    super.initState();
    _email = auth.currentUser!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 254, 220, 86),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 83, 5, 64),
              ),
              currentAccountPicture: CircleAvatar(
                child: Text("V"),
              ),
              accountName: Text("Usuario"),
              accountEmail: Text(_email ?? ""),
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              title: Text("Opção 1"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Opção 1");
              },
            ),
            ListTile(
              title: Text("Opção 2"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Opção 2");
              },
            ),
            ListTile(
              title: Text("Opção 3"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Opção 3");
              },
            ),
          ],
        ),
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
