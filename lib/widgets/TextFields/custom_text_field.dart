import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? placeholder;
  final double? width;
  final double? height;
  final TextInputType? inputType;
  final bool? enable;
  final bool obscureText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? margin;
  final Widget? prefix;

  const CustomTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.placeholder,
    this.width,
    this.height,
    this.inputType,
    this.enable = true,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.obscureText = false,
    this.margin,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          bottom: (validator != null ? 7 : 0),
        ),
        child: Container(
          margin: margin ?? const EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: SizedBox(
            height: height ?? 90,
            width: width != null
                ? double?.parse(width.toString())
                : MediaQuery.of(context).size.width,
            child: TextFormField(
              controller: controller,
              onSaved: onSaved,
              validator: validator,
              obscureText: obscureText,
              inputFormatters: inputFormatters,
              keyboardType: inputType ?? TextInputType.text,
              style: const TextStyle(
                fontSize: 24.0,
              ),
              enabled: enable,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 74, 44, 82),
                ),
                hintText: placeholder ?? '',
                prefix: prefix,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 74, 44, 82),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 74, 44, 82),
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 74, 44, 82),
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
      ),
    );
  }
}
