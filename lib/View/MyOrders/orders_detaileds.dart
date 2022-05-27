import 'package:flutter/material.dart';
import 'package:pointsf/models/address_model.dart';

class OrdersDetaileds extends StatelessWidget {
  /* final AddressModel? model;

  const OrdersDetaileds({
    Key? key,
    required this.model,
  }) : super(key: key);
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 30, 15, 30),
            height: MediaQuery.of(context).size.width,
            width: 380,
            //color: Color.fromARGB(252, 241, 241, 63),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color.fromARGB(252, 241, 241, 63),
                width: 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
