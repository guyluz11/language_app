import 'package:flutter/material.dart';

class TextInputAtom extends StatelessWidget {
  const TextInputAtom({
    required this.labelText,
    required this.onChanged,
    super.key,
    this.outlined = false,
    this.initialValue,
  });
  final String labelText;
  final bool outlined;
  final void Function(String) onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        border: outlined
            ? const OutlineInputBorder()
            : const UnderlineInputBorder(),
      ),
      onChanged: onChanged,
      controller: initialValue != null
          ? TextEditingController(text: initialValue)
          : null,
    );
  }
}
