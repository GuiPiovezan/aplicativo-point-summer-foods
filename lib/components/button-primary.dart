import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String textoBotao;
  final VoidCallback funcao;
  final double? width;
  final double? heigth;

  const ButtonPrimary({
    required this.textoBotao,
    required this.funcao,
    this.width,
    this.heigth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: heigth != null ? double?.parse(heigth.toString()) : 52,
        width: width != null ? double?.parse(width.toString()) : 300,
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: TextButton(
          onPressed: funcao,
          child: Text(
            textoBotao,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(15),
            backgroundColor: Color.fromARGB(255, 83, 5, 64),
            side: BorderSide(
              color: Colors.white,
              width: 2,
              style: BorderStyle.solid,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
