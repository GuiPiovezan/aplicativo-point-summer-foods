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
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: firestore
                        .collection('produtos')
                        .where("categoria", isEqualTo: "Açai")
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 10),
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(50, 10, 10, 10),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Color.fromARGB(255, 255, 217, 65),
                            ),
                            child: Text(
                              snapshot.data!.docs[index]["nome"],
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
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
