import 'package:flutter/material.dart';
import 'package:pointsf/Services/AuthService/auth-service.dart';

import 'package:pointsf/View/export-all-view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
      backgroundColor: const Color.fromARGB(255, 254, 220, 86),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 83, 5, 64),
            ),
            currentAccountPicture: CircleAvatar(
              child: Text(getFirtsLastLetterFullName()),
            ),
            accountName: Text(auth.userName!),
            accountEmail: Text(email.toString()),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            title: const Text("Conta"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              print("Conta");
            },
          ),
          ListTile(
            title: const Text("Home"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              print("Home");
            },
          ),
          ListTile(
            title: const Text("Pedidos"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              print("Pedidos");
            },
          ),
          ListTile(
            title: const Text("Meus endereços"),
            trailing: const Icon(Icons.house),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ListAddress()),
              );
            },
          ),
        ],
      ),
    );
  }
}
