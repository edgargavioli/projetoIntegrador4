import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/auth_guard.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';
import 'package:projeto_integrador/components/custom_menu_bar.dart';
import 'package:projeto_integrador/pages/inventario_page.dart';
import 'package:projeto_integrador/pages/notifications_page.dart';
import 'package:projeto_integrador/pages/users_page.dart';
import 'package:projeto_integrador/pages/emprestantes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  void _updatePageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: CustomMenuBar(
        currentPageIndex: _currentPageIndex,
        onPageSelected: _updatePageIndex,
      ),
      body: <Widget>[
        AuthGuard(InventarioPage()),
        AuthGuard(UsersPage()),
        AuthGuard(EmprestantesPage()),
        AuthGuard(NotificationsPage()),
      ][_currentPageIndex],
    );
  }
}
