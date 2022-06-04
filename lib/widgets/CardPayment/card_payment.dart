import 'package:flutter/material.dart';

class CardPayment extends StatelessWidget {
  final String textButton;
  final IconData icon;

  const CardPayment({
    Key? key,
    required this.textButton,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      width: 140,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(textButton, style: const TextStyle(fontSize: 24.0)),
            Icon(icon, size: 32.0),
          ],
        ),
      ),
    );
  }
}
