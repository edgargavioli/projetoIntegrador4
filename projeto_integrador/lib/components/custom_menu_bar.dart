import 'package:flutter/material.dart';

class CustomMenuBar extends StatefulWidget {
  const CustomMenuBar({super.key});

  @override
  State<CustomMenuBar> createState() => _CustomMenuBarState();
}

class _CustomMenuBarState extends State<CustomMenuBar> {
  int currentPageIndex = 0;
  final List<String> _routes = ['/home', '/users', '/notifications'];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      overlayColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      destinations: const <Widget> [
        NavigationDestination(
          icon: Icon(Icons.inbox),
          label: "Inventário",
        ),
        NavigationDestination(
          icon: Icon(Icons.person_2_outlined),
          label: "Usuários"
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_outlined),
          label: "Avisos"
        ),
      ],
      indicatorColor: Theme.of(context).colorScheme.error,
      selectedIndex: currentPageIndex,
      onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          Navigator.pushNamed(context, _routes[index]);
      },
    );
  }
}