import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointsf/Services/AddressService/address_service.dart';
import 'package:pointsf/Services/AuthService/auth_service.dart';
import 'package:pointsf/Services/OrderService/order_service.dart';
import 'package:pointsf/Services/Validators/order_validator.dart';
import 'package:pointsf/models/address_model.dart';
import 'package:pointsf/models/enums/type_payment.dart';
import 'package:pointsf/models/order_model.dart';
import 'package:pointsf/widgets/RadioButton/radio_button.dart';
import 'package:pointsf/widgets/export_widgets.dart';
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
  final GlobalKey<FormState> formMainKey = GlobalKey<FormState>();
  TextEditingController moneyController = TextEditingController();
  double? valueTotal = 0;
  double? valueDelivery = 1.50;
  TypePayment _typePayment = TypePayment.money;

  Map<dynamic, dynamic>? arguments;

  String? cardFlagSelected;
  String? cardPaymentSelected;

  final AuthService auth = AuthService();
  String? userName;
  String? userEmail;
  String? userPhone;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    auth;
    userEmail = auth.getUserEmail();
  }

  onChangeRadioButton(TypePayment value) => setState(() {
        _typePayment = value;
      });

  @override
  Widget build(BuildContext context) {
    arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    double valueTotal = calculteValueTotal(arguments!);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const CustomAppBar(
        title: 'Pagamento',
      ),
      body: Form(
        key: formMainKey,
        child: ListView(
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
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: AuthService().getInformationUser(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return const Text("Erro ao carregar os dados");
                }

                userName = snapshot.data!.docs[0]['nome'];
                userPhone = snapshot.data!.docs[0]['telefone'];

                return Container();
              },
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: AddressService().getAddress(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

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
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              child: Center(
                child: Text(
                  "Selecione a forma de pagamento",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RadioButton(
                  textRadioButton: 'Dinheiro',
                  groupValue: _typePayment,
                  value: TypePayment.money,
                  onChanged: (value) => onChangeRadioButton(value),
                ),
                RadioButton(
                  textRadioButton: 'Cartão',
                  groupValue: _typePayment,
                  value: TypePayment.cardCredit,
                  onChanged: (value) => onChangeRadioButton(value),
                ),
              ],
            ),
            if (_typePayment == TypePayment.money)
              Center(
                child: CustomTextField(
                  controller: moneyController,
                  labelText: 'Troco',
                  inputType: TextInputType.number,
                  prefix: const Text("R\$"),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(),
                  ],
                  validator: (value) =>
                      OrderValidator.validarTroco(value!, valueTotal),
                  onSaved: (_) {
                    cardFlagSelected = '';
                    cardPaymentSelected = '';
                  },
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: Color.fromARGB(255, 74, 44, 82),
                          ),
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 74, 44, 82),
                          ),
                          labelText: "Selecione a bandeira do cartão",
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
                        validator: (value) {
                          if (value == null) {
                            return 'A bandeira do cartão é obrigatório';
                          }
                          return null;
                        },
                        items: typeCardPayment.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            cardFlagSelected = value;
                            moneyController.clear();
                          });
                        }),
                    const SizedBox(
                      height: 16.0,
                    ),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: Color.fromARGB(255, 74, 44, 82),
                          ),
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 74, 44, 82),
                          ),
                          labelText: "Selecione a forma de pagamento",
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
                        validator: (value) {
                          if (value == null) {
                            return 'Forma de pagamento é obrigatório';
                          }
                          return null;
                        },
                        items: typePayment.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            cardPaymentSelected = value;
                          });
                        }),
                  ],
                ),
              ),
            CustomTextButton(
              buttonText: 'Finalizar Pedido',
              onPressed: () {
                if (formMainKey.currentState!.validate()) {
                  formMainKey.currentState!.save();

                  setState(() {
                    isLoading = true;
                  });

                  OrderModel model = OrderModel(
                    address: addressSelected,
                    dateOrder: DateTime.now(),
                    userEmail: userEmail,
                    userName: userName,
                    userPhone: userPhone,
                    valueTotal: valueTotal,
                    valueDelivery: valueDelivery,
                    typePayment: _typePayment,
                    moneyChange: moneyController.text,
                    cardFlag: cardFlagSelected,
                    cardPayment: cardPaymentSelected,
                    itens: arguments!['items'],
                  );

                  OrderService().save(model, context);
                }
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
  OrderService service = OrderService();

  double valueTotal = 0;

  var totalItens = itens['items'];

  valueTotal = service.calculateValueTotalOrder(totalItens);

  return valueTotal;
}
