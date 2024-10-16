import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/auth_guard.dart';
import 'package:projeto_integrador/pages/create_account_page.dart';
import 'package:projeto_integrador/pages/home_page.dart';
import 'package:projeto_integrador/pages/item_registration_page.dart';
import 'package:projeto_integrador/pages/login_page.dart';
import 'package:projeto_integrador/themes/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final initialRoute = token.isEmpty ? '/login' : '/home';

  runApp(MaterialApp(
    initialRoute: initialRoute,
    routes: {
      '/login': (context) => LoginPage(),
      '/createAccount': (context) => CreateAccountPage(),
      '/home': (context) => AuthGuard(HomePage()),
      '/itemRegistration': (context) => AuthGuard(ItemRegistrationPage()),
    },
    theme: lightMode,
    debugShowCheckedModeBanner: false,
  ));
}