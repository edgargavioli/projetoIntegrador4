import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/item_list.dart';
import 'package:projeto_integrador/services/item_service.dart';
import 'package:projeto_integrador/pages/item_registration_page.dart';

class InventarioPage extends StatefulWidget {
  const InventarioPage({super.key});

  @override
  State<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ItemList> _items = [];
  List<ItemList> _filteredItems = [];
  bool _isLoading = true;
  bool _isSelecting = false;
  List<bool> _selectedItems = [];
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    loading();
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose(); // Certifique-se de descartar o controlador
    super.dispose();
  }

  Future<void> _navigateToItemRegistrationPage() async {
    final bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ItemRegistrationPage()),
    );

    if (result == true) {
      loading();
    }
  }

  Future<void> loading() async {
    try {
      final items = await ItemService.fetchItemsInventarioPage();
      setState(() {
        _items = items;
        _filteredItems = items; // Inicializa a lista filtrada
        _isLoading = false;
        _selectedItems = List<bool>.filled(_items.length, false);
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _items.where((item) {
        final matchesSearch = item.descricao.toLowerCase().contains(query);
        final matchesStatus = _selectedStatus == null || 
                             _selectedStatus == "Todos" || 
                             item.estado == _selectedStatus;
        return matchesSearch && matchesStatus;
      }).toList();
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      _selectedItems[index] = !_selectedItems[index];
      _isSelecting = _selectedItems.contains(true);
    });
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 10),
              Text('Excluir Item',
                  style: TextStyle(color: Color.fromARGB(255, 255, 254, 254))),
            ],
          ),
          content: const Text(
            'Você realmente deseja excluir o item selecionado permanentemente?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
              child: const Text('Cancelar'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Ação para excluir o item
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text('Excluir'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Text(
                "Inventário",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 36,
                    fontWeight: FontWeight.w600),
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
              const SizedBox(height: 10),

              // Dropdown para selecionar o status
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: DropdownButton<String>(
                  value: _selectedStatus,
                  hint: const Text("Filtrar por Status"),
                  items: <String>[
                    'Todos', // Adicionado "Todos"
                    'Disponível',
                    'Emprestado',
                    'Manutenção',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = newValue;
                      _filterItems(); // Filtra a lista quando o status é alterado
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          return GestureDetector(
                            onLongPress: () {
                              setState(() {
                                _isSelecting = true;
                                _selectedItems[index] = !_selectedItems[index];
                              });
                            },
                            onTap: () {
                              if (_isSelecting) {
                                _toggleSelection(index);
                              }
                            },
                            child: ListTile(
                              title: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Text(item.descricao),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Text(
                                  item.estado,
                                  style: TextStyle(
                                    color: item.estado == "Disponível"
                                        ? Theme.of(context)
                                            .colorScheme
                                            .inversePrimary
                                        : item.estado == "Manutenção" ||
                                                item.estado == "Manutenção"
                                            ? Theme.of(context)
                                                .colorScheme
                                                .inverseSurface
                                            : Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                  ),
                                ),
                              ),
                              trailing: _isSelecting
                                  ? Checkbox(
                                      value: _selectedItems[index],
                                      activeColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      checkColor:
                                          Theme.of(context).colorScheme.surface,
                                      onChanged: (bool? value) {
                                        _toggleSelection(index);
                                      },
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isSelecting) ...[
                FloatingActionButton(
                  backgroundColor: const Color(0xFF28A745),
                  onPressed: () {
                    // Ação do primeiro botão extra
                  },
                  child: const Icon(Icons.add_circle_outline),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: const Color(0xFFB3261E),
                  onPressed: () {
                    _showDeleteConfirmation(context); // Chama o diálogo de exclusão
                  },
                  child: const Icon(Icons.delete_outline),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: const Color(0xFF1E88E5),
                  onPressed: () {
                    // Ação do terceiro botão extra
                  },
                  child: const Icon(Icons.groups_2_outlined),
                ),
                const SizedBox(height: 10),
              ],
              if (!_isSelecting)
                FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    _navigateToItemRegistrationPage();
                  },
                  child: const Icon(Icons.add),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
