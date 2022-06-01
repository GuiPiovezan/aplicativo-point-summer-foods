import 'package:flutter/cupertino.dart';

import '../../widgets/TextFields/custom_text_field.dart';

// ignore: non_constant_identifier_names
Widget MoneyPayment(BuildContext context) => Wrap(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            child: Column(
              children: <Widget>[
                CustomTextField(
                  labelText: 'Troco',
                ),
              ],
            ),
          ),
        ),
      ],
    );
