import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String textoBotao;
  final VoidCallback funcao;

  ButtonPrimary({
    required this.textoBotao,
    required this.funcao,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 52,
        width: 300,
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
