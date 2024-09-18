import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

// Controlador para o campo de busca
final TextEditingController _searchController = TextEditingController();

class User {
  String name;
  User(this.name);
}

class _UsersPageState extends State<UsersPage> {
  List<User> users = [
    User("User 1"),
    User("User 2"),
    User("User 3"),
    User("User 4"),
  ];

  List<User> get filteredUsers {
    if (_searchController.text.isEmpty) {
      return users;
    } else {
      return users
          .where((user) =>
              user.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Text(
            "Usuários",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 36,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(
            thickness: 1,
            color: Color(0xFFCAC4D0),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextfield(
              controller: _searchController,
              icon: const Icon(Icons.search),
              label: "Buscar...",
            ),
          ),
          const SizedBox(height: 20),
          // Lista de usuários
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredUsers[index].name),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
