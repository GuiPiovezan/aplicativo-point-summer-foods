import 'package:flutter/material.dart';

import 'package:pointsf/models/address_model.dart';

class CardAddress extends StatelessWidget {
  final AddressModel? model;

  const CardAddress({
    Key? key,
    required this.model,
  }) : super(key: key);

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
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                model!.nome!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              leading: const Icon(
                Icons.house_sharp,
                size: 32.0,
              ),
              title: Text(
                "${model!.logradouro}, ${model!.numero}",
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${model!.bairro} - ${model!.cidade}",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onLongPress: () {

              },
            )
          ],
        ),
      ),
    );
  }
}
