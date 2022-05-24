import 'package:flutter/material.dart';
import 'package:pointsf/Services/AuthService/auth-service.dart';

import 'package:pointsf/View/export-all-view.dart';

class CustomDrawerAdmin extends StatefulWidget {
  const CustomDrawerAdmin({Key? key}) : super(key: key);

  @override
  State<CustomDrawerAdmin> createState() => _CustomDrawerAdminState();
}

class _CustomDrawerAdminState extends State<CustomDrawerAdmin> {
  final AuthService auth = AuthService();
  String? user = "Loading";
  String? email = "Loading";

  @override
  void initState() {
    super.initState();
    auth;
    user = auth.userName;
    email = auth.getUserEmail();
  }

  setNome() async {
    await auth.setUserName();
    setState(() {
      user = auth.getUserName();
    });
  }

  getFirtsLastLetterFullName() {
    setNome();
    var firstLetterFirstName = user!.split("").first;
    var lastName = user!.split(" ").last;
    var firstLetterLastName = lastName.split("").first;

    return firstLetterFirstName + firstLetterLastName;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 89, 53, 99),
            ),
            currentAccountPicture: CircleAvatar(
              child: Text(
                getFirtsLastLetterFullName(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            accountName: Text(auth.userName!),
            accountEmail: Text(email.toString()),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            title: const Text(
              "Novos pedidos",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
            onTap: () {
              print("Novos pedidos");
            },
          ),
          ListTile(
            title: const Text(
              "Pedidos aceitos",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
            onTap: () {
              print("Pedidos aceitos");
            },
          ),
          ListTile(
            title: const Text(
              "Pedidos encerrados",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
            onTap: () {
              print("Pedidos encerrados");
            },
          ),
          ListTile(
            title: const Text(
              "Cadastro de produtos",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.house,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProductRegistration(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
