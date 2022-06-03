import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointsf/Services/ConfigService/config_service.dart';

import 'package:pointsf/widgets/export_widgets.dart';

class Config extends StatefulWidget {
  const Config({Key? key}) : super(key: key);

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ConfigService configService = ConfigService();
  final _controllerDeliveryFee = TextEditingController();
  final _controllerDeliveryTime = TextEditingController();
  bool configDeliveryFee = false;
  bool configDeliveryTime = false;
  bool isLoading = false;
  bool configurationIsAtive = false;

  saveDeliveryFee() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      formKey.currentState!.save();
      try {
        await configService.updateDeliveryFee(_controllerDeliveryFee.text);
        setState(() {
          configDeliveryFee = false;
          configurationIsAtive = false;
          isLoading = false;
        });
      } on ConfigException catch (e) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  saveDeliveryTime() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      formKey.currentState!.save();
      try {
        await configService.updateDeliveryTime(_controllerDeliveryTime.text);
        setState(() {
          configDeliveryTime = false;
          configurationIsAtive = false;
          isLoading = false;
        });
      } on ConfigException catch (e) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: const CustomAppBar(
        title: "Configurações",
      ),
      body: Form(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: configService.getConfig(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (_, index) {
                return Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      configDeliveryFee
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  controller: _controllerDeliveryFee,
                                  labelText: "Taxa de entrega",
                                  placeholder: "1,50",
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CentavosInputFormatter(),
                                  ],
                                  prefix: const Text(
                                    "R\$ ",
                                    style: TextStyle(
                                      color: Color.fromARGB(200, 0, 0, 0),
                                    ),
                                  ),
                                  inputType: TextInputType.number,
                                  width: MediaQuery.of(context).size.width / 2,
                                  validator: (value) {
                                    if (value!.length < 3) {
                                      return "Digite uma taxa com 3 digitos";
                                    }
                                    return null;
                                  },
                                ),
                                (isLoading)
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(255, 74, 44, 82),
                                        ),
                                      )
                                    : CustomTextButton(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 0),
                                        buttonText: "Alterar",
                                        onPressed: () async {
                                          saveDeliveryFee();
                                        },
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        heigth: 70,
                                      ),
                              ],
                            )
                          : ListTile(
                              title: Text(
                                "Taxa de entrega: " +
                                    snapshot.data!.docs[index]["deliveryFee"],
                              ),
                              subtitle: const Text("Toque para alterar"),
                              onTap: () {
                                if (!configurationIsAtive) {
                                  setState(() {
                                    configDeliveryFee = true;
                                    configurationIsAtive = true;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Termine a configuração pendente",
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                      configDeliveryTime
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  controller: _controllerDeliveryTime,
                                  labelText: "Tempo de entrega",
                                  placeholder: "30~40min",
                                  width: MediaQuery.of(context).size.width / 2,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Digite o tempo de entrega";
                                    }
                                    return null;
                                  },
                                ),
                                (isLoading)
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(255, 74, 44, 82),
                                        ),
                                      )
                                    : CustomTextButton(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 0),
                                        buttonText: "Alterar",
                                        onPressed: () {
                                          saveDeliveryTime();
                                        },
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        heigth: 70,
                                      ),
                              ],
                            )
                          : ListTile(
                              title: Text(
                                "Tempo de entrega: " +
                                    snapshot.data!.docs[index]["deliveryTime"],
                              ),
                              subtitle: const Text("Toque para alterar"),
                              onTap: () {
                                if (!configurationIsAtive) {
                                  setState(() {
                                    configDeliveryTime = true;
                                    configurationIsAtive = true;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Termine a configuração pendente",
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
