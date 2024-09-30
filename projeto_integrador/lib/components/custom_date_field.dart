import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon? icon;

  const CustomDateField({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: icon ?? Icon(Icons.calendar_today),
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
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          controller.text = formattedDate;
        }
      },
    );
  }
}
