import 'package:flutter/material.dart';
import 'package:pointsf/View/Address/list_address.dart';
import 'package:pointsf/View/CadastroProduto/cadastro-produto.dart';

class CustomDrawer extends StatelessWidget {
  final String? user;
  final String? email;

  const CustomDrawer({
    Key? key,
    this.user,
    this.email,
  }) : super(key: key);

  getFirtsLastLetterFullName(String nome) {
    var firstLetterFirstName = nome.split("").first;
    var lastName = nome.split(" ").last;
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
              child: Text("${getFirtsLastLetterFullName(user!)}"),
            ),
            accountName: Text(user ?? ""),
            accountEmail: Text(email ?? ""),
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
          ListTile(
            title: const Text("Meus endereços"),
            trailing: const Icon(Icons.house),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CadastroProduto()),
              );
            },
          ),
        ],
      ),
    );
  }
}
