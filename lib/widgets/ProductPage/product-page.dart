import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  final String? categoria;

  ProductPage({
    required this.categoria,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestore
                  .collection('produtos')
                  .where("categoria", isEqualTo: categoria)
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
                      height: 57,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(50, 10, 10, 10),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Color.fromARGB(255, 255, 217, 65),
                      ),
                      child: TextButton(
                        child: Text(
                          snapshot.data!.docs[index]["nome"],
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          print(snapshot.data!.docs[index]["nome"]);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      color: const Color.fromARGB(255, 254, 220, 86),
    );
  }
}
