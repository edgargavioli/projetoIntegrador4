import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/auth_guard.dart';
import 'package:projeto_integrador/pages/create_account_page.dart';
import 'package:projeto_integrador/pages/emprestimo_page.dart';
import 'package:projeto_integrador/pages/home_page.dart';
import 'package:projeto_integrador/pages/item_registration_page.dart';
import 'package:projeto_integrador/pages/login_page.dart';
import 'package:projeto_integrador/themes/light_mode.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginPage(),
      '/createAccount': (context) => CreateAccountPage(),
      '/home': (context) => AuthGuard(HomePage()),
      '/itemRegistration': (context) => AuthGuard(ItemRegistrationPage()),
      '/emprestimo': (context) => AuthGuard(EmprestimoPage()),
    },
    theme: lightMode,
    debugShowCheckedModeBanner: false,
  ));
}
