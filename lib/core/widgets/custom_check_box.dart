import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final bool value;
  final Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Color(0xFF15B86C),
      checkColor: Color(0xFFFFFCFC),
      value: value,

      onChanged: (value) => onChanged(value),
    );
  }
}
