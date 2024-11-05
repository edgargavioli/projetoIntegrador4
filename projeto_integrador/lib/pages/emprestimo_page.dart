import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';
import 'package:projeto_integrador/components/custom_date_field.dart';
import 'package:projeto_integrador/components/custom_select_field.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/item_list.dart';
import 'package:projeto_integrador/services/emprestante_service.dart';
import 'package:projeto_integrador/services/emprestimo_service.dart';
import 'package:projeto_integrador/services/location_service.dart';
import 'package:projeto_integrador/services/user_service.dart';

class EmprestimoPage extends StatefulWidget {
  final List<ItemList> selectedItems;

  const EmprestimoPage({super.key, required this.selectedItems});

  @override
  State<EmprestimoPage> createState() => _EmprestimoPageState();
}

class _EmprestimoPageState extends State<EmprestimoPage> {
  final TextEditingController entidadeController = TextEditingController();
  final TextEditingController dataEmprestimoController =
      TextEditingController();
  final TextEditingController dataDevolucaoController = TextEditingController();
  final TextEditingController emprestanteController = TextEditingController();
  final TextEditingController prazoManutencaoController =
      TextEditingController();
  final TextEditingController anexoController = TextEditingController();

  String? selectedEstado;
  String? selectedUsuario;
  String? selectedLocalizacao;
  String? selectedEmprestante;

  List<DropdownMenuItem<String>> locaisAtual = [];
  List<DropdownMenuItem<String>> usuariosDropdown = [];
  List<DropdownMenuItem<String>> emprestantesDropdown = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarEmprestantes() async {
    try {
      final emprestantes = await EmprestanteService.getEmprestantes();
      setState(() {
        emprestantesDropdown = emprestantes.map((emprestante) {
          final displayName =
              "${emprestante.nome} (${emprestante.num_identificacao})";
          return DropdownMenuItem<String>(
            value: emprestante.num_identificacao,
            child: Text(displayName),
          );
        }).toList();
      });
    } catch (e) {
      print('Erro ao carregar emprestantes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar emprestantes')),
      );
    }
  }

  Future<void> carregarLocais() async {
    try {
      final locais = await LocationService.fetchLocais();
      setState(() {
        locaisAtual = locais.map((local) {
          return DropdownMenuItem<String>(
            value: local['id_localizacao'].toString(),
            child: Text(local['nome']),
          );
        }).toList();
      });
    } catch (e) {
      print('Erro ao carregar locais: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar locais')),
      );
    }
  }

  Future<void> carregarUsuarios() async {
    try {
      final usuarios = await UserService.getUsers();
      setState(() {
        usuariosDropdown = usuarios.map((user) {
          return DropdownMenuItem<String>(
            value: user.id.toString(),
            child: Text(user.nome),
          );
        }).toList();
      });
    } catch (e) {
      print('Erro ao carregar usuários: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar usuários')),
      );
    }
  }

  Future<void> carregarDados() async {
    setState(() {
      isLoading = true;
    });

    await carregarLocais();
    await carregarUsuarios();
    await carregarEmprestantes();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> realizarEmprestimo() async {
    try {
      List<Map<String, dynamic>> emprestimos = widget.selectedItems.map((item) {
        return {
          "entidade": entidadeController.text,
          "data_emprestimo": dataEmprestimoController.text,
          "data_devolucao": dataDevolucaoController.text,
          "id_usuario": int.parse(selectedUsuario!),
          "id_item": item.id,
          "num_identificacao_emprestante": emprestanteController.text,
          "id_localizacao_atual": int.parse(selectedLocalizacao!),
          "status_emprestimo": false,
          "estado": selectedEstado,
          "id_anexos": 1,
          "prazo_manutencao": prazoManutencaoController.text,
        };
      }).toList();

      print(emprestimos);

      await EmprestimoService.realizarEmprestimo(emprestimos);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Empréstimo realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao realizar o empréstimo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          "Empréstimo de Itens",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const Divider(thickness: 1, color: Color(0xFFCAC4D0)),
                    const SizedBox(height: 16),
                    Text(
                      'Você selecionou ${widget.selectedItems.length} item(ns) para empréstimo.',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.selectedItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F7F7),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: const Color(0xFFCAC4D0)),
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.inventory,
                                    color: Colors.black),
                                title: Text(
                                  widget.selectedItems[index].descricao,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                subtitle: Text(
                                  'ID: ${widget.selectedItems[index].id}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextfield(
                      controller: entidadeController,
                      label: "Entidade",
                      obscureText: false,
                    ),
                    const SizedBox(height: 16),
                    CustomSelectField(
                      label: "Emprestante",
                      items: emprestantesDropdown,
                      selectedValue: selectedEmprestante,
                      onChanged: (value) {
                        setState(() {
                          selectedEmprestante = value;
                          emprestanteController.text = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomDateField(
                      controller: dataEmprestimoController,
                      label: "Data de Empréstimo",
                    ),
                    const SizedBox(height: 16),
                    CustomDateField(
                      controller: dataDevolucaoController,
                      label: "Data de Devolução",
                    ),
                    const SizedBox(height: 16),
                    CustomSelectField(
                      label: "Estado do Item",
                      items: const [
                        DropdownMenuItem(
                            value: "Disponível", child: Text("Disponível")),
                        DropdownMenuItem(
                            value: "Emprestado", child: Text("Emprestado")),
                        DropdownMenuItem(
                            value: "Manutenção", child: Text("Manutenção")),
                      ],
                      selectedValue: selectedEstado,
                      onChanged: (value) {
                        setState(() {
                          selectedEstado = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomSelectField(
                      label: "Localização Atual",
                      items: locaisAtual,
                      selectedValue: selectedLocalizacao,
                      onChanged: (value) {
                        setState(() {
                          selectedLocalizacao = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomSelectField(
                      label: "Responsável pelo Empréstimo",
                      items: usuariosDropdown,
                      selectedValue: selectedUsuario,
                      onChanged: (value) {
                        setState(() {
                          selectedUsuario = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomDateField(
                      controller: prazoManutencaoController,
                      label: "Prazo de Manutenção",
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: realizarEmprestimo,
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.check),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
