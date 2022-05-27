import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pointsf/widgets/export_widgets.dart';

import '../../widgets/TextFields/custom_text_field.dart';

class MoneyPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    double money = 0;
    return SingleChildScrollView(
      child: GestureDetector(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                CustomTextField(
                  onSaved: (value) => money = double.parse(value!.trim()),
                  labelText: 'Troco',
                  //validator: (value) => UserValidator.validarNome(value!),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: CustomTextButton(
                    buttonText: 'Pronto',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
