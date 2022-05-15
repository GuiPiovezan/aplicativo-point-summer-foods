import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/View/CustomerRegistration/address-registration.dart';
import 'package:pointsf/widgets/AppBar/custom-appbar.dart';

class ListAddress extends StatelessWidget {
  ListAddress({Key? key}) : super(key: key);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Meus endereços'),
      body: ListView(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const AddressRegistration())));
          }),
    );
  }
}
