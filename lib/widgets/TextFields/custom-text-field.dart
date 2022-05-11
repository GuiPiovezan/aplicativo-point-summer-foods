import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controlador;
  final String? descricaoCampo;
  final String? placeholder;
  final double? width;
  final double? heigth;
  final TextInputType? inputType;
  final bool? enable;
  FormFieldSetter<String>? onSaved;
  FormFieldValidator<String>? validator;
  List<TextInputFormatter>? inputFormatters;

  CustomTextField({
    this.controlador,
    this.descricaoCampo,
    this.placeholder,
    this.width,
    this.heigth,
    this.inputType,
    this.enable = true,
    this.onSaved,
    this.validator,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        height: heigth != null ? double?.parse(heigth.toString()) : 70,
        width: width != null ? double?.parse(width.toString()) : 320,
        child: TextFormField(
          controller: controlador,
          onSaved: onSaved,
          validator: validator,
          inputFormatters: inputFormatters,
          keyboardType: inputType ?? TextInputType.text,
          style: const TextStyle(
            fontSize: 24.0,
          ),
          enabled: enable,
          decoration: InputDecoration(
            labelText: descricaoCampo,
            hintText: placeholder ?? '',
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 83, 5, 64),
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
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
