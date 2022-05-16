import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/View/Address/card_address.dart';
import 'package:pointsf/View/CustomerRegistration/address-registration.dart';
import 'package:pointsf/models/address_model.dart';
import 'package:pointsf/widgets/AppBar/custom-appbar.dart';

class ListAddress extends StatefulWidget {
  const ListAddress({Key? key}) : super(key: key);

  @override
  State<ListAddress> createState() => _ListAddressState();
}

class _ListAddressState extends State<ListAddress> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Meus endereços'),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection("usuarios")
            .doc(auth.currentUser!.uid)
            .collection("enderecos")
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return const Text('Erro ao carregar dados');
          if (!snapshot.hasData) return const CircularProgressIndicator();

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (_, index) {
              return CardAddress(
                AddressModel.fromMap(
                  snapshot.data!.docs[index].data(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => const AddressRegistration()),
            ),
          );
        },
      ),
    );
  }
}
