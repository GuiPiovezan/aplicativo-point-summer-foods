import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/Services/AddressService/address_service.dart';
import 'package:pointsf/models/address_model.dart';
import 'package:pointsf/widgets/CardPayment/card_payment.dart';

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
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const CustomAppBar(
        title: 'Pagamento',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub. Total',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          'R\$15,00',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Taxa de entrega',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          'R\$4,50',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'R\$19,50',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                  onChanged: (AddressModel? value) {
                    setState(() {
                      addressSelected = value!;
                    });
                  },
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Pagamento",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              CardPayment(
                textButton: 'Dinheiro',
                icon: Icons.attach_money,
              ),
              CardPayment(
                textButton: 'Cartão',
                icon: Icons.credit_card,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
