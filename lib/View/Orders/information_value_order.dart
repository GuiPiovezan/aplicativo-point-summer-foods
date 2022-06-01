import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InformationValueOrder extends StatefulWidget {
  double? valueTotal;

  InformationValueOrder({
    Key? key,
    this.valueTotal,
  }) : super(key: key);

  @override
  State<InformationValueOrder> createState() => _InformationValueOrderState();
}

class _InformationValueOrderState extends State<InformationValueOrder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Sub. Total',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                UtilBrasilFields.obterReal(widget.valueTotal!),
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                'Taxa de entrega',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                'R\$1,50',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                UtilBrasilFields.obterReal((widget.valueTotal! + 1.50)),
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
