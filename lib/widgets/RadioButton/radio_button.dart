import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  const RadioButton(
      {Key? key,
      this.textRadioButton,
      this.value,
      this.groupValue,
      this.onChanged})
      : super(key: key);

  final String? textRadioButton;
  final dynamic value;
  final dynamic groupValue;
  final void Function(dynamic)? onChanged;

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          widget.textRadioButton!,
          style: const TextStyle(fontSize: 24.0),
        ),
        Radio(
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
          activeColor: const Color.fromARGB(255, 74, 44, 82),
        ),
      ],
    );
  }
}
