import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:projeto_integrador/components/auth_guard.dart';
import 'package:projeto_integrador/pages/create_account_page.dart';
import 'package:projeto_integrador/pages/home_page.dart';
import 'package:projeto_integrador/pages/item_registration_page.dart';
import 'package:projeto_integrador/pages/login_page.dart';
import 'package:projeto_integrador/themes/light_mode.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeNotifications();
  runApp(MaterialApp(
    initialRoute: '/login',
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

void _initializeNotifications() {
  tz.initializeTimeZones();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}
