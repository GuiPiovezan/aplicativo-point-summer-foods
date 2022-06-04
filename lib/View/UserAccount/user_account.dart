import 'package:flutter/material.dart';

import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/View/export_all_view.dart';
import 'package:pointsf/widgets/AppBar/custom_appbar.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final AuthService auth = AuthService();
  String? user = "Loading";
  String? email = "Loading";
  String? phone = "Loading";

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

  setPhone() async {
    await auth.setUserPhone();
    setState(() {
      phone = auth.getUserPhone();
    });
  }

  getFirtsLastLetterFullName() {
    setNome();
    setPhone();
    var firstLetterFirstName = user!.split("").first;
    var lastName = user!.split(" ").last;
    var firstLetterLastName = lastName.split("").first;

    return firstLetterFirstName + firstLetterLastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        title: "Informações da conta",
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: const Color.fromARGB(255, 152, 201, 53),
                  style: BorderStyle.solid,
                ),
                // BorderSide(
                borderRadius: const BorderRadius.all(Radius.circular(500)),
              ),
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 74, 44, 82),
                minRadius: 20,
                maxRadius: 40,
                child: Text(
                  getFirtsLastLetterFullName(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 240, 240, 240),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              user!,
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              email!,
              style: const TextStyle(
                color: Color.fromARGB(255, 30, 30, 30),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: const Color.fromARGB(255, 193, 193, 193),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(50, 15, 50, 0),
              child: Row(
                children: <Widget>[
                  const Text(
                    "Nome: ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    user!,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 23, 23, 23),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(50, 15, 50, 0),
              child: Row(
                children: <Widget>[
                  const Text(
                    "Email: ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    email!,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 23, 23, 23),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(50, 15, 50, 0),
              child: Row(
                children: <Widget>[
                  const Text(
                    "Telefone: ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    phone!,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 23, 23, 23),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CustomerDataEditing()),
                      );
                    },
                    child: const Text(
                      "editar",
                      style: TextStyle(
                        color: Color.fromARGB(255, 74, 44, 82),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
