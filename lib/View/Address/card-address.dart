import 'package:flutter/material.dart';

import 'package:pointsf/models/address-model.dart';

class CardAddress extends StatelessWidget {
  final AddressModel model;

  CardAddress(
    this.model,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(30, 10, 10, 10),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(
                Icons.house_sharp,
                size: 32.0,
              ),
              title: Text(
                "${model.logradouro}, ${model.numero}",
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${model.bairro} - ${model.cidade}",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
