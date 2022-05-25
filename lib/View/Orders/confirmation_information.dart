import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/Services/AddressService/address_service.dart';
import 'package:pointsf/models/address_model.dart';

import '../../widgets/AppBar/custom_appbar.dart';

class ConfirmationInformation extends StatefulWidget {
  const ConfirmationInformation({Key? key}) : super(key: key);

  @override
  State<ConfirmationInformation> createState() =>
      _ConfirmationInformationState();
}

class _ConfirmationInformationState extends State<ConfirmationInformation> {
  AddressModel? addressSelected;
  List<AddressModel> addressList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: AddressService().getAddress(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();

              if (snapshot.hasError) {
                return const Text("Erro ao carregar os dados");
              }

              if (addressList.isEmpty) {
                for (var element in snapshot.data!.docs) {
                  addressList.add(AddressModel.fromMap(element.data()));
                }
              }

              return Center(
                child: DropdownButton(
                  itemHeight: 70,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 74, 44, 82),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  value: addressSelected,
                  hint: const Text(
                    "Selecione o endereço de entrega",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  elevation: 16,
                  onChanged: (AddressModel? value) {},
                  items: addressList.map((AddressModel item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        '${item.logradouro!}, ${item.numero!}',
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
