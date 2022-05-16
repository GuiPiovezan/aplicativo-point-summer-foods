import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String textoBotao;
  final VoidCallback onPressed;
  final double? width;
  final double? heigth;

  const CustomTextButton({
    Key? key,
    required this.textoBotao,
    required this.onPressed,
    this.width,
    this.heigth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: heigth != null ? double?.parse(heigth.toString()) : 52,
        width: width != null ? double?.parse(width.toString()) : 300,
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            textoBotao,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor: const Color.fromARGB(255, 83, 5, 64),
            side: const BorderSide(
              color: Colors.white,
              width: 2,
              style: BorderStyle.solid,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
