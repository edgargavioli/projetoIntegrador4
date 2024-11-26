import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/emprestante.dart';
import 'package:projeto_integrador/pages/emprestante_edit_page.dart';
import 'package:projeto_integrador/pages/emprestante_registration_page.dart';
import 'package:projeto_integrador/services/emprestante_service.dart';

class EmprestantesPage extends StatefulWidget {
  const EmprestantesPage({super.key});

  @override
  State<EmprestantesPage> createState() => _EmprestantesPageState();
}

class _EmprestantesPageState extends State<EmprestantesPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Emprestante> emprestantes = [];
  bool _isSelecting = false;
  List<bool> _selectedEmprestantes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEmprestantes();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _navigateToEmprestanteRegistrationPage() async {
    final bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const EmprestanteRegistrationPage()),
    );

    if (result == true) {
      _loadEmprestantes();
    }
  }

  Future<void> _loadEmprestantes() async {
    try {
      final fetchedEmprestantes = await EmprestanteService.getEmprestantes();
      setState(() {
        fetchedEmprestantes.removeWhere(
            (emprestante) => emprestante.status_emprestante != 'Ativo');
        emprestantes = fetchedEmprestantes;
        _selectedEmprestantes = List<bool>.filled(emprestantes.length, false);
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar emprestantes: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  List<Emprestante> get filteredEmprestantes {
    return emprestantes.where((emprestante) {
      return emprestante.nome
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
    }).toList();
  }

  void _toggleSelection(int index) {
    setState(() {
      _selectedEmprestantes[index] = !_selectedEmprestantes[index];
      _isSelecting = _selectedEmprestantes.contains(true);
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
                final selectedIndices = _selectedEmprestantes
                    .asMap()
                    .entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList();

                for (var index in selectedIndices) {
                  try {
                    await EmprestanteService.deleteEmprestante(
                        emprestantes[index].id_emprestante);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Emprestante excluído com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } catch (e) {
                    print('Erro ao excluir o emprestante: $e');
                  }
                }
                _isSelecting = false;
                Navigator.of(context).pop();
                _loadEmprestantes();
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

  void _navigateToEmprestanteEditPage(
      BuildContext context, Emprestante selectedEmprestante) async {
    try {
      final bool? result = await Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              EmprestanteEditPage(emprestante: selectedEmprestante),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );

      if (result == true) {
        _isSelecting = false;
        _loadEmprestantes();
      }
    } catch (e) {
      print(e);
    }
  }

  void _editEmprestante(int index) {
    final selectedEmprestante = emprestantes[index];
    _navigateToEmprestanteEditPage(context, selectedEmprestante);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Stack(
        children: [
          Column(
            children: [
              Text(
                "Emprestantes",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(thickness: 1, color: Color(0xFFCAC4D0)),
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
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ListView.builder(
                          itemCount: filteredEmprestantes.length,
                          itemBuilder: (context, index) {
                            final emprestante = filteredEmprestantes[index];
                            return GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  _isSelecting = true;
                                  _selectedEmprestantes[index] =
                                      !_selectedEmprestantes[index];
                                });
                              },
                              onTap: () {
                                if (!_isSelecting) {
                                  _editEmprestante(index);
                                }
                                if (_isSelecting) {
                                  _toggleSelection(index);
                                }
                              },
                              child: ListTile(
                                title: Text(emprestante.nome),
                                subtitle: Text(
                                  emprestante.num_identificacao,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                                trailing: _isSelecting
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Checkbox(
                                          value: _selectedEmprestantes[index],
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          checkColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          onChanged: (bool? value) {
                                            _toggleSelection(index);
                                          },
                                        ),
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isSelecting) ...[
                  FloatingActionButton(
                    backgroundColor: const Color(0xFFB3261E),
                    onPressed: () => _showDeleteConfirmation(context),
                    child: const Icon(Icons.delete_outline),
                  ),
                  const SizedBox(height: 10),
                ],
                if (!_isSelecting)
                  FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      _navigateToEmprestanteRegistrationPage();
                    },
                    child: const Icon(Icons.add),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
