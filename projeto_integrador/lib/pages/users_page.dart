import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/user.dart';
import 'package:projeto_integrador/services/user_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

// Controlador para o campo de busca
final TextEditingController _searchController = TextEditingController();

class _UsersPageState extends State<UsersPage> {
  List<User> users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final fetchedUsers = await UserService.getUsers();
      setState(() {
        users = fetchedUsers;
        _isLoading = false;
        print(users);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar usuários: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  List<User> get filteredUsers {
    if (_searchController.text.isEmpty) {
      return users;
    } else {
      return users
          .where((user) =>
              user.nome
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              user.sobrenome
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
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
              obscureText: false,
            ),
          ),
          const SizedBox(height: 20),
          // Lista de usuários
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            "${filteredUsers[index].nome} ${filteredUsers[index].sobrenome}",
                          ),
                          subtitle: Text(
                            filteredUsers[index].tipo_usuario,
                            style: TextStyle(
                              color: filteredUsers[index].tipo_usuario ==
                                      "Administrador"
                                  ? Theme.of(context).colorScheme.primary
                                  : filteredUsers[index].tipo_usuario ==
                                          "Colaborador"
                                      ? Theme.of(context)
                                          .colorScheme
                                          .inversePrimary
                                      : filteredUsers[index].tipo_usuario ==
                                              "Aluno"
                                          ? Theme.of(context)
                                              .colorScheme
                                              .tertiary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                            ),
                          ),
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
