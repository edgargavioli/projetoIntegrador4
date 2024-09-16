import 'package:flutter/material.dart';
import 'package:projeto_integrador/pages/create_account_page.dart';
import 'package:projeto_integrador/pages/home_page.dart';
import 'package:projeto_integrador/pages/login_page.dart';
import 'package:projeto_integrador/themes/light_mode.dart';
import 'package:projeto_integrador/pages/notifications_page.dart';
import 'package:projeto_integrador/pages/users_page.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginPage(),
      '/createAccount': (context) => CreateAccountPage(),
      '/home': (context) => HomePage(),
      '/users': (context) => UsersPage(),
      '/notifications': (context) => NotificationsPage(),
    },
    theme: lightMode,
    debugShowCheckedModeBanner: false,
  ));
}