import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon? icon;

  const CustomTextfield({super.key, required this.controller, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        cursorColor: const Color(0xFF8F8F8F),
        decoration: InputDecoration(
            suffixIcon: icon,
            label: Text(label),
            labelStyle: const TextStyle(color: Color(0xFF8F8F8F)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF8F8F8F))),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8F8F8F)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8F8F8F)),
            ),
            focusColor: const Color(0xFF8F8F8F)
          )
        );
  }
}
