import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/widgets/export-widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  var _email;
  var _user;

  @override
  void initState() {
    super.initState();
    _email = auth.currentUser!.email;
    firestore
        .collection("usuarios")
        .where("uid", isEqualTo: auth.currentUser!.uid)
        .get()
        .then((event) {
      setState(() {
        _user = event.docs[0]["nome"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        email: _email,
        user: _user,
      ),
      appBar: const CustomAppBarHome(
        icon: Icon(Icons.man_sharp),
        title: "Rua João Silva, SP",
      ),
      body: PageView(
        children: [
          ProductPage(
            category: "Açai",
          ),
          ProductPage(
            category: "Salgados",
          ),
          ProductPage(
            category: "Porções",
          ),
        ],
      ),
    );
  }
}
