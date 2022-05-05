import 'package:flutter/material.dart';

class TextInputPersonalizado extends StatelessWidget {
  final TextEditingController? controlador;
  final String? descricaoCampo;
  final String? placeholder;

  TextInputPersonalizado(
      {this.controlador, this.descricaoCampo, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          labelText: descricaoCampo,
          hintText: placeholder,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
