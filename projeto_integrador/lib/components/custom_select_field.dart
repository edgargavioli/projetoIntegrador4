import 'package:flutter/material.dart';

class CustomSelectField extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<String>> items;
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  const CustomSelectField({
    super.key,
    required this.label,
    required this.items,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: const TextStyle(color: Color(0xFF8F8F8F)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF8F8F8F)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF8F8F8F)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF8F8F8F)),
        ),
        focusColor: const Color(0xFF8F8F8F),
      ),
      items: items,
      onChanged: onChanged,
      dropdownColor: Colors.white,
    );
  }
}
