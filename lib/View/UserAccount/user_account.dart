import 'package:flutter/material.dart';
import 'package:pointsf/widgets/AppBar/custom_appbar.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 74, 44, 82),
                minRadius: 20,
                maxRadius: 40,
                child: Text(
                  "UU",
                  style: TextStyle(
                    color: Color.fromARGB(255, 240, 240, 240),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "user user",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              "user@email.com",
              style: TextStyle(
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
                children: const <Widget>[
                  Text(
                    "Nome: ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "user user",
                    style: TextStyle(
                        color: Color.fromARGB(255, 23, 23, 23),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(50, 15, 50, 0),
              child: Row(
                children: const <Widget>[
                  Text(
                    "Email: ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "user@email.com",
                    style: TextStyle(
                        color: Color.fromARGB(255, 23, 23, 23),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(50, 15, 50, 0),
              child: Row(
                children: const <Widget>[
                  Text(
                    "Telefone: ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "(17) 99777-7997",
                    style: TextStyle(
                        color: Color.fromARGB(255, 23, 23, 23),
                        fontWeight: FontWeight.w500),
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
                    onPressed: () {},
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
