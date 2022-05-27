import 'package:flutter/material.dart';

class InformationValueOrder extends StatelessWidget {
  const InformationValueOrder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
