import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/components/custom_select_field.dart';

class ItemRegistrationPage extends StatefulWidget {
  const ItemRegistrationPage({super.key});

  @override
  State<ItemRegistrationPage> createState() => _ItemRegistrationPageState();
}

class _ItemRegistrationPageState extends State<ItemRegistrationPage> {
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController numeroSerieController = TextEditingController();
  final TextEditingController potenciaController = TextEditingController();
  final TextEditingController notaFiscalController = TextEditingController();
  final TextEditingController patrimonioController = TextEditingController();
  final TextEditingController comentarioManutencaoController =
      TextEditingController();

  String? selectedEstado;
  String? selectedMarca;
  String? selectedModelo;
  String? selectedCategoria;
  String? selectedLocalOrigem;
  String? selectedLocalAtual;
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    "Novo Item",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 36,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color(0xFFCAC4D0),
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: descricaoController,
                label: 'Item',
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: numeroSerieController,
                label: 'Número de Série',
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: 'Disponibilidade',
                items: const [
                  DropdownMenuItem(
                      value: 'Disponível', child: Text('Disponível')),
                  DropdownMenuItem(
                      value: 'Indisponível', child: Text('Indisponível')),
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
                label: 'Marca',
                items: const [
                  DropdownMenuItem(value: 'Marca 1', child: Text('Marca 1')),
                  DropdownMenuItem(value: 'Marca 2', child: Text('Marca 2')),
                ],
                selectedValue: selectedMarca,
                onChanged: (value) {
                  setState(() {
                    selectedMarca = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: 'Modelo',
                items: const [
                  DropdownMenuItem(value: 'Modelo 1', child: Text('Modelo 1')),
                  DropdownMenuItem(value: 'Modelo 2', child: Text('Modelo 2')),
                ],
                selectedValue: selectedModelo,
                onChanged: (value) {
                  setState(() {
                    selectedModelo = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: 'Categoria',
                items: const [
                  DropdownMenuItem(
                      value: 'Categoria 1', child: Text('Categoria 1')),
                  DropdownMenuItem(
                      value: 'Categoria 2', child: Text('Categoria 2')),
                ],
                selectedValue: selectedCategoria,
                onChanged: (value) {
                  setState(() {
                    selectedCategoria = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: 'Origem',
                items: const [
                  DropdownMenuItem(value: 'Origem 1', child: Text('Origem 1')),
                  DropdownMenuItem(value: 'Origem 2', child: Text('Origem 2')),
                ],
                selectedValue: selectedLocalOrigem,
                onChanged: (value) {
                  setState(() {
                    selectedLocalOrigem = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: potenciaController,
                label: 'Potência',
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: notaFiscalController,
                label: 'Nota Fiscal',
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: patrimonioController,
                label: 'Patrimônio',
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: 'Status',
                items: const [
                  DropdownMenuItem(value: 'Ativo', child: Text('Ativo')),
                  DropdownMenuItem(value: 'Inativo', child: Text('Inativo')),
                ],
                selectedValue: selectedStatus,
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    // SUBMIT AQUI
                  },
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
