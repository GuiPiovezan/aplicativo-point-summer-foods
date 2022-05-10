import 'package:flutter/material.dart';

class TextInputPersonalizado extends StatelessWidget {
  final TextEditingController? controlador;
  final String? descricaoCampo;
  final String? placeholder;
  final double? width;
  final double? heigth;

  TextInputPersonalizado({
    this.controlador,
    this.descricaoCampo,
    this.placeholder,
    this.width,
    this.heigth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        height: heigth != null ? double?.parse(heigth.toString()) : 70,
        width: width != null ? double?.parse(width.toString()) : 320,
        child: TextField(
          controller: controlador,
          keyboardType: TextInputType.number,
          style: const TextStyle(
            fontSize: 24.0,
          ),
          decoration: InputDecoration(
            labelText: descricaoCampo,
            hintText: placeholder,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 83, 5, 64),
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
