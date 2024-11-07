import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/item.dart';
import 'package:projeto_integrador/models/item_list.dart';
import 'package:projeto_integrador/pages/emprestimo_page.dart';
import 'package:projeto_integrador/pages/inventario_item_selecionado.dart';
import 'package:projeto_integrador/services/item_service.dart';
import 'package:projeto_integrador/pages/item_registration_page.dart';
// Importando a tela de edição

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
    _searchController.dispose();
    super.dispose();
  }

  void _devolucaoItem() async {
  try {
    final List<int> itemIds = _items
        .asMap()
        .entries
        .where((entry) => _selectedItems[entry.key])
        .map((entry) => entry.value.id)
        .toList();

    if (itemIds.isNotEmpty) {
      await ItemService.returnItems(itemIds);

      // Atualiza o estado local dos itens apenas para os que foram devolvidos
      this.loading();

      this._isSelecting = false;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Itens devolvidos com sucesso'),
        backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhum item selecionado para devolução')),
      );
    }
  } catch (e) {
    print("Erro ao devolver itens: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Erro ao devolver itens')),
    );
  }
}

  void _navigateToEmprestimoPage(BuildContext context) async {
    try {
      final List<ItemList> selectedItems = _items
          .asMap()
          .entries
          .where((entry) => _selectedItems[entry.key])
          .map((entry) => entry.value)
          .toList();

      final bool? result = await Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              EmprestimoPage(
            selectedItems: selectedItems,
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );

      if (result == true) {
        _isSelecting = false;
        loading();
      }
    } catch (e) {
      print(e);
    }
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

  // Método de navegação para tela de edição
  void _navigateToEditItem(int id) async {
    final bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemEditPage(id: id), // Passando o item selecionado
      ),
    );

    if (result == true) {
      loading(); // Recarrega a lista após a edição
    }
  }

  Future<void> loading() async {
    try {
      final items = await ItemService.fetchItemsInventarioPage();
      setState(() {
        _items = items;
        _filteredItems = items;
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
            'Você realmente deseja excluir o(s) item(s) selecionado permanentemente?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await ItemService.deleteItem(_items
                    .asMap()
                    .entries
                    .where((entry) => _selectedItems[entry.key])
                    .map((entry) => entry.value.id)
                    .toList());
                await loading();
                Navigator.of(context).pop();
                _isSelecting = false;
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: DropdownButton<String>(
                  value: _selectedStatus,
                  hint: const Text("Filtrar por Status"),
                  items: <String>[
                    'Todos',
                    'Disponivel',
                    'Emprestado',
                    'Manutencao',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = newValue;
                      _filterItems();
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
                              } else {
                                _navigateToEditItem(_items[index].id); // Navegando para a tela de edição
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
                                  item.estado == "Disponivel"
                                      ? "Disponível"
                                      : item.estado == "Emprestado"
                                          ? "Emprestado"
                                          : item.estado == "Manutencao"
                                              ? "Manutenção"
                                              : "Indefinido",
                                  style: TextStyle(
                                    color: item.estado == "Disponivel"     //acho valido usar um text e não mudar no banco
                                        ? Theme.of(context)
                                            .colorScheme
                                            .inversePrimary
                                        : item.estado == "Emprestado" ||
                                                item.estado == "Manutencao"
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
                  backgroundColor: Colors.red,
                  heroTag: 'delete',
                  onPressed: () => _showDeleteConfirmation(context),
                  child: const Icon(Icons.delete),
                ),
                const SizedBox(height: 20),
                FloatingActionButton(
                  onPressed: () => _navigateToEmprestimoPage(context),
                  child: const Icon(Icons.subdirectory_arrow_right),
                  backgroundColor: const Color.fromARGB(255, 30, 180, 63),
                ),
                const SizedBox(height: 20),
                FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 30, 95, 179),
                  onPressed: () { _devolucaoItem(); 
                  },
                  child: const Icon(Icons.subdirectory_arrow_left),
                ),
                const SizedBox(height: 10),
              ] else ...[
                FloatingActionButton(
                  onPressed: _navigateToItemRegistrationPage,
                  child: const Icon(Icons.add),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
