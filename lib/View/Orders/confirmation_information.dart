import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointsf/Services/AddressService/address_service.dart';
import 'package:pointsf/Services/Validators/order_validator.dart';
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
  String? typeCardPaymentSelected;
  String? typePaymentSelected;
  List<AddressModel> addressList = [];
  final GlobalKey<FormState> formKeyMoney = GlobalKey<FormState>();
  final GlobalKey<FormState> formMainKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyCard = GlobalKey<FormState>();
  TextEditingController moneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    double valueTotal = calculteValueTotal(arguments);

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
                child: InformationValueOrder(valueTotal: valueTotal),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Form(
              key: formMainKey,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: AddressService().getAddress(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData)
                    return const CircularProgressIndicator();

                  if (snapshot.hasError) {
                    return const Text("Erro ao carregar os dados");
                  }

                  if (addressList.isEmpty) {
                    for (var element in snapshot.data!.docs) {
                      addressList.add(AddressModel.fromMap(element.data()));
                    }
                  }

                  return Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 74, 44, 82),
                        ),
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 74, 44, 82),
                        ),
                        labelText: "Selecione o endereço de entrega",
                        hintText: "Selecione o endereço de entrega",
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 74, 44, 82),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 240, 0, 0),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 74, 44, 82),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 74, 44, 82),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
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
                      validator: (value) {
                        if (value == null) {
                          return 'O endereço de entrega é obrigatório';
                        }

                        return null;
                      },
                    ),
                  );
                },
              ),
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
                                    key: formKeyMoney,
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(height: 16),
                                        CustomTextField(
                                          labelText: 'Troco',
                                          inputType: TextInputType.number,
                                          prefix: const Text("R\$"),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CentavosInputFormatter(),
                                          ],
                                          controller: moneyController,
                                          validator: (value) =>
                                              OrderValidator.validarTroco(
                                                  value!),
                                        ),
                                        const SizedBox(height: 16),
                                        CustomTextButton(
                                          buttonText: "Pronto",
                                          onPressed: () {
                                            if (formKeyMoney.currentState!
                                                .validate()) {
                                              formKeyMoney.currentState!.save();
                                              Navigator.of(context).pop();
                                            }
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
                                    key: formKeyCard,
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(height: 16),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 20),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  floatingLabelStyle:
                                                      const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 74, 44, 82),
                                                  ),
                                                  labelStyle: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 74, 44, 82),
                                                  ),
                                                  labelText:
                                                      "Selecione o tipo de bandeira do cartão",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 74, 44, 82),
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 240, 0, 0),
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 74, 44, 82),
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 74, 44, 82),
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                ),
                                                itemHeight: 70,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 44, 82),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                value: typeCardPaymentSelected,
                                                hint: const Text(
                                                  "Selecione a bandeira do cartão",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                elevation: 16,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    typeCardPaymentSelected =
                                                        value!;
                                                  });
                                                },
                                                items: typeCardPayment.map(
                                                    (String typeCardPayment) {
                                                  return DropdownMenuItem(
                                                    value: typeCardPayment,
                                                    child: Text(
                                                      typeCardPayment,
                                                      style: const TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'O tipo de bandeira do cartão é obrigatório';
                                                  }

                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 24.0,
                                              ),
                                              DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  floatingLabelStyle:
                                                      const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 74, 44, 82),
                                                  ),
                                                  labelStyle: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 74, 44, 82),
                                                  ),
                                                  labelText:
                                                      "Selecione a forma de pagameto",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 74, 44, 82),
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 240, 0, 0),
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 74, 44, 82),
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 2,
                                                      color: Color.fromARGB(
                                                          255, 74, 44, 82),
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                ),
                                                itemHeight: 70,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 44, 82),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                value: typePaymentSelected,
                                                hint: const Text(
                                                  "Selecione a forma de pagamento",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                elevation: 16,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    typePaymentSelected =
                                                        value!;
                                                  });
                                                },
                                                items: typePayment
                                                    .map((String typePayment) {
                                                  return DropdownMenuItem(
                                                    value: typePayment,
                                                    child: Text(
                                                      typePayment,
                                                      style: const TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'A forma de pagamento é obrigatório';
                                                  }

                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        CustomTextButton(
                                          buttonText: "Pronto",
                                          onPressed: () {
                                            if (formKeyCard.currentState!
                                                .validate()) {
                                              formKeyCard.currentState!.save();
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 24),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
            ),
            CustomTextButton(
              buttonText: 'Finalizar Pedido',
              onPressed: () {
                if (formMainKey.currentState!.validate()) {
                  formMainKey.currentState!.save();
                  print(addressSelected!.logradouro);
                  print(moneyController.text);
                  print(typeCardPaymentSelected);
                  print(typePaymentSelected);
                }
                print(arguments);
              },
            )
          ],
        ),
      ),
    );
  }
}

List<String> typeCardPayment = ["Visa", "MasterCard"];
List<String> typePayment = ["Crédito", "Débito"];

double calculteValueTotal(Map<dynamic, dynamic> itens) {
  double valueTotal = 0;

  var totalItens = itens['items'];

  valueTotal = _calculateValueTotalOrder(totalItens);

  return valueTotal;
}

double _calculateValueTotalOrder(dynamic itens) {
  double valueTotalOrder = 0;

  print(itens);

  if (itens.isNotEmpty) {
    int amount;

    for (var i = 0; i < itens.length; i++) {
      double priceTotalProducts = 0;

      String price = (itens[i]['preco'] as String).replaceAll(",", ".");
      priceTotalProducts = double.parse(price);
      amount = itens[i]['quantidade'];
      double priceTotalAdditional = 0;

      for (var j = 0; j < itens[i]['adicionais'].length; j++) {
        String price =
            (itens[i]['adicionais'][j]['preco'] as String).replaceAll(",", ".");

        priceTotalAdditional += double.parse(price);
      }

      valueTotalOrder += (priceTotalProducts + priceTotalAdditional) * amount;
    }

    return valueTotalOrder;
  }

  return valueTotalOrder;
}
