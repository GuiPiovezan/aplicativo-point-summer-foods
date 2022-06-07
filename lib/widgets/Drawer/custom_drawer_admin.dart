import 'package:flutter/material.dart';

import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/View/export_all_view.dart';

class CustomDrawerAdmin extends StatefulWidget {
  int indexNavigatorBar;
  PageController pageController;
  CustomDrawerAdmin({
    Key? key,
    required this.indexNavigatorBar,
    required this.pageController,
  }) : super(key: key);

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

  void _logOut(context) {
    AuthService().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      child: Column(
        children: [
          Expanded(
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
                    setState(() {
                      widget.indexNavigatorBar = 0;
                    });
                    widget.pageController.jumpToPage(
                      0,
                    );
                    Navigator.of(context).pop();
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
                    setState(() {
                      widget.indexNavigatorBar = 1;
                    });
                    widget.pageController.jumpToPage(
                      1,
                    );
                    Navigator.of(context).pop();
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
                    setState(() {
                      widget.indexNavigatorBar = 2;
                    });
                    widget.pageController.jumpToPage(
                      2,
                    );
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text(
                    "Lista de produtos",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.icecream_outlined,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProductAdministration(),
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
                    Icons.new_label_outlined,
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
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Configurações ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Icon(
                  Icons.settings_sharp,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Config(),
                ),
              );
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Deslogar ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Icon(
                  Icons.logout_outlined,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
            onTap: () {
              _logOut(context);
            },
          ),
        ],
      ),
    );
  }
}
