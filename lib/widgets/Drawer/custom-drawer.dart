import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String? user;
  final String? email;

  CustomDrawer({
    this.user,
    this.email,
  });

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
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 83, 5, 64),
            ),
            currentAccountPicture: CircleAvatar(
              child: Text("V"),
            ),
            accountName: Text(user ?? ""),
            accountEmail: Text(email ?? ""),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            title: Text("Conta"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print("Conta");
            },
          ),
          ListTile(
            title: Text("Home"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print("Home");
            },
          ),
          ListTile(
            title: Text("Pedidos"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print("Pedidos");
            },
          ),
        ],
      ),
    );
  }
}
