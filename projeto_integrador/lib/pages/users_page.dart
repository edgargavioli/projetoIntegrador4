import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/user.dart';
import 'package:projeto_integrador/services/user_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}
class _UsersPageState extends State<UsersPage> {
  final TextEditingController _searchController = TextEditingController();
  List<User> users = [];
  String _selectedFilter = "Todos"; // Filtro inicial

  @override
  void initState() {
    super.initState();
    _loadUsers();

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    try {
      final fetchedUsers = await UserService.getUsers();
      setState(() {
        users = fetchedUsers;
      });
    } catch (e) {
      if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        content: Text('Erro ao carregar usuários: $e'),
        backgroundColor: Colors.red,
        ),
      );
      }
    }
  }

  List<User> get filteredUsers {
    return users.where((user) {
      final matchesSearch = user.nome
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          user.sobrenome
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());

      final matchesFilter = _selectedFilter == 'Todos' ||
          user.tipo_usuario == _selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
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
            child: Column(
              children: [
                CustomTextfield(
                  controller: _searchController,
                  icon: const Icon(Icons.search),
                  label: "Buscar...",
                  obscureText: false,
                ),
                const SizedBox(height: 10), // Espaçamento entre os componentes
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: [
                    'Todos',
                    'Administrador',
                    'Colaborador',
                    'Aluno',
                  ].map((String filter) {
                    return DropdownMenuItem<String>(
                      value: filter,
                      child: Text(filter),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                  isExpanded: true,
                ),
              ],
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
                    title: Text(
                      "${filteredUsers[index].nome} ${filteredUsers[index].sobrenome}",
                    ),
                    subtitle: Text(
                      filteredUsers[index].tipo_usuario,
                      style: TextStyle(
                        color: filteredUsers[index].tipo_usuario ==
                                "Administrador"
                            ? Theme.of(context).colorScheme.primary
                            : filteredUsers[index].tipo_usuario == "Colaborador"
                                ? Theme.of(context).colorScheme.inversePrimary
                                : filteredUsers[index].tipo_usuario == "Aluno"
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.onSurface,
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
