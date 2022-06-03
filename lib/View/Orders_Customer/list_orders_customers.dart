import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../widgets/AppBar/custom_appbar.dart';

class ListOrdersCustomers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Meus Pedidos",
      ),
      /*body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: 
        builder:(_, snapshot){
          if (snapshot.hasError) return const Text("Erro ao carregar os dados");
          if (snapshot.hasData) return const CircularProgressIndicator();
        },
      ),*/
    );
  }
}
