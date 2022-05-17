import 'package:flutter/material.dart';
import 'package:pointsf/models/address-model.dart';

class CardAddress extends StatelessWidget {
  final AddressModel model;

  CardAddress(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
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
