import 'package:flutter/material.dart';
import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/View/ProductAdministration/product_administration.dart';

import 'package:pointsf/View/export_all_view.dart';

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
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 40,
                  minRadius: 35,
                  child: Text(
                    getFirtsLastLetterFullName(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 240, 240, 240),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 74, 44, 82),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.userName!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          email.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 123, 123, 123),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
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
              Icons.arrow_forward,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductAdministration(),
                ),
              );
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
