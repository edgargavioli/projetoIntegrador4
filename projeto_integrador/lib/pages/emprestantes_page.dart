import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/emprestante.dart';
import 'package:projeto_integrador/services/emprestante_service.dart';

class EmprestantesPage extends StatefulWidget {
  const EmprestantesPage({super.key});

  @override
  State<EmprestantesPage> createState() => _EmprestantesPageState();
}

final TextEditingController _searchController = TextEditingController();

class _EmprestantesPageState extends State<EmprestantesPage> {
  List<Emprestante> emprestantes = [];

  @override
  void initState() {
    super.initState();
    _loadEmprestantes();
  }

  Future<void> _loadEmprestantes() async {
    try {
      final fetchedEmprestantes = await EmprestanteService.getEmprestantes();
      setState(() {
        emprestantes = fetchedEmprestantes;
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
    if (_searchController.text.isEmpty) {
      return emprestantes;
    } else {
      return emprestantes
          .where((emprestante) => emprestante.nome
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
            "Emprestantes",
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ListView.builder(
                itemCount: filteredEmprestantes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredEmprestantes[index].nome),
                    subtitle: Text(
                      filteredEmprestantes[index].num_identificacao,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
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
