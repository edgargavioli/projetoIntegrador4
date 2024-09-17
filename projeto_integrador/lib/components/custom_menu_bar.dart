import 'package:flutter/material.dart';

class CustomMenuBar extends StatelessWidget {
  final int currentPageIndex;
  final Function(int) onPageSelected;

  const CustomMenuBar({
    super.key,
    this.currentPageIndex = 0,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      overlayColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.surface),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.inbox),
          label: "Inventário",
        ),
        NavigationDestination(
          icon: Icon(Icons.person_2_outlined),
          label: "Usuários",
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_outlined),
          label: "Avisos",
        ),
      ],
      indicatorColor: Theme.of(context).colorScheme.error,
      selectedIndex: currentPageIndex,
      onDestinationSelected: (int index) {
        onPageSelected(index);
      },
    );
  }
}
