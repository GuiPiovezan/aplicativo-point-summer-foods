import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String textoBotao;

  ButtonPrimary(this.textoBotao);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(100, 50)),
          textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 24),
          ),
        ),
        onPressed: () {},
        child: Text(textoBotao),
      ),
    );
  }
}
