import 'package:flutter/material.dart';
import 'package:projeto_integrador/services/auth_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      centerTitle: true,
      foregroundColor: Theme.of(context).colorScheme.surface,
      automaticallyImplyLeading: currentRoute != '/home',
      title: Image.asset("assets/images/logoAppBar.png"),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            AuthService.logout();
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
