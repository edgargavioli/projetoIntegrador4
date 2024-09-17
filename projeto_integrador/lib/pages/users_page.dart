import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';
import 'package:projeto_integrador/components/custom_menu_bar.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Placeholder(),
    );
  }
}