import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pointsf/Services/AddressService/address_service.dart';
import 'package:pointsf/View/Orders/credit_payment.dart';
import 'package:pointsf/View/Orders/money_payment.dart';
import 'package:pointsf/models/address_model.dart';
import 'package:pointsf/widgets/CardPayment/card_payment.dart';
import 'package:pointsf/widgets/TextButtons/custom_text_button.dart';
import 'package:pointsf/widgets/TextFields/custom_text_field.dart';

import '../../widgets/AppBar/custom_appbar.dart';
import 'information_value_order.dart';

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
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const CustomAppBar(
        title: 'Pagamento',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 24.0),
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
                child: const InformationValueOrder(),
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
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 36.0, 8.0, 36.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Selecione a forma de pagamento",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Material(
                        child: InkWell(
                          onTap: () => showModalBottomSheet(
                            enableDrag: true,
                            isDismissible: true,
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
                            builder: (context) => Wrap(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Form(
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(height: 16),
                                        CustomTextField(
                                          labelText: 'Troco',
                                          inputType: TextInputType.number,
                                        ),
                                        const SizedBox(height: 16),
                                        CustomTextButton(
                                          buttonText: "Pronto",
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        const SizedBox(height: 24),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: const CardPayment(
                            textButton: 'Dinheiro',
                            icon: Icons.attach_money,
                          ),
                        ),
                      ),
                      Material(
                        child: InkWell(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) => CreditPayment(),
                            isScrollControlled: true,
                          ),
                          child: const CardPayment(
                            textButton: 'Cartão',
                            icon: Icons.credit_card,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            )
          ],
        ),
      ),
    );
  }
}
