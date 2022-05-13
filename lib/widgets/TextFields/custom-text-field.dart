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
  final bool obscureText;
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
    this.validator = null,
    this.inputFormatters,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
        child: Container(
          height: heigth != null
              ? validator != null
                  ? double?.parse(heigth.toString()) + 30
                  : double?.parse(heigth.toString())
              : validator != null
                  ? 90
                  : 70,
          width: width != null ? double?.parse(width.toString()) : 350,
          child: TextFormField(
            controller: controlador,
            onSaved: onSaved,
            validator: validator,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: inputType ?? TextInputType.text,
            style: const TextStyle(
              fontSize: 24.0,
            ),
            enabled: enable,
            decoration: InputDecoration(
              labelText: descricaoCampo,
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 83, 5, 64),
              ),
              hintText: placeholder ?? '',
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 83, 5, 64),
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 83, 5, 64),
                  width: 2,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 83, 5, 64),
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
