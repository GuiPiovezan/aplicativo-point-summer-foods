import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? value;
  final Void Function(Object?) onChanged;
  final List<DropdownMenuItem<Object>>? items;

  const CustomDropdownButton({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.value,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 74, 44, 82),
          ),
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 74, 44, 82),
          ),
          labelText: labelText,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 74, 44, 82),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 240, 0, 0),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 74, 44, 82),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 74, 44, 82),
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        itemHeight: 70,
        style: const TextStyle(
          color: Color.fromARGB(255, 74, 44, 82),
        ),
        borderRadius: BorderRadius.circular(20),
        value: value,
        isExpanded: false,
        elevation: 16,
        validator: (value) {
          if (value == null) return "Selecione um";
          return null;
        },
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}
