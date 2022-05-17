import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pointsf/View/export-all-view.dart';

import 'package:pointsf/models/address-model.dart';
import 'package:pointsf/Services/AddressService/address-service.dart';

import 'package:pointsf/widgets/AppBar/custom-appbar.dart';

class ListAddress extends StatefulWidget {
  const ListAddress({Key? key}) : super(key: key);

  @override
  State<ListAddress> createState() => _ListAddressState();
}

class _ListAddressState extends State<ListAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Meus endereços'),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: AddressService().getAddress(),
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
        child: const Icon(Icons.add_location_alt_outlined),
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
