import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/item_list.dart';
import 'package:projeto_integrador/services/item_service.dart';

class InventarioPage extends StatefulWidget {
  const InventarioPage({super.key});

  @override
  State<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ItemList> _items = [];
  bool _isLoading = true;
  bool _isSelecting = false;
  List<bool> _selectedItems = [];
  List<int> _selectedItemsId = [];

  @override
  void initState() {
    super.initState();
    loading();
  }

  Future<void> loading() async {
    try {
      final items = await ItemService.fetchItemsInventarioPage();
      setState(() {
        _items = items;
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

  void _toggleSelection(int index) {
    setState(() {
      _selectedItems[index] = !_selectedItems[index];
      _selectedItemsId.add(_items[index].id);
      _isSelecting = _selectedItems.contains(true);
    });
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary, // Cor de fundo personalizada
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Row(
            children: const [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 10),
              Text('Excluir Item', style: TextStyle(color: Color.fromARGB(255, 255, 254, 254))),
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
                foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.secondary, // Cor do botão Cancelar
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                // Ação para excluir o item
                await ItemService.deleteItem(_selectedItemsId);
                await loading();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text('Excluir'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, 
                foregroundColor: Colors.white
              ),
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
              const SizedBox(height: 40),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
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
                                                .error,
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
                    Navigator.pushNamed(context, '/itemRegistration');
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
