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
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.onPrimary,
      value: value,

      onChanged: (value) => onChanged(value),
    );
  }
}
