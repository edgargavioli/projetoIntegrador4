import 'package:flutter/material.dart';

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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
