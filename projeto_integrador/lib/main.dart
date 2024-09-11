import 'package:flutter/material.dart';
import 'package:projeto_integrador/pages/login_page.dart';
import 'package:projeto_integrador/themes/light_mode.dart';

void main() {
  runApp(MaterialApp(
    home: const LoginPage(),
    theme: lightMode,
    debugShowCheckedModeBanner: false,
  ));
}