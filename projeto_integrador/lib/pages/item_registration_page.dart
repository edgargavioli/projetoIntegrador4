import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/components/custom_select_field.dart';
import 'package:projeto_integrador/components/custom_date_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projeto_integrador/models/item.dart';

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
  final TextEditingController dataEntradaController = TextEditingController();
  final TextEditingController ultimaQualificacaoController =
      TextEditingController();
  final TextEditingController dataNotaFiscalController =
      TextEditingController();
  final TextEditingController proximaQualificacaoController =
      TextEditingController();
  final TextEditingController prazoManutencaoController =
      TextEditingController();

  String? selectedEstado;
  String? selectedMarca;
  String? selectedModelo;
  String? selectedCategoria;
  String? selectedLocalOrigem;
  String? selectedLocalAtual;
  String? selectedStatus;

  List<DropdownMenuItem<String>> marcas = [];
  List<DropdownMenuItem<String>> modelos = [];
  List<DropdownMenuItem<String>> categorias = [];
  List<DropdownMenuItem<String>> locaisOrigem = [];
  List<DropdownMenuItem<String>> locaisAtual = [];

  bool isModeloEnabled = false;

  @override
  void initState() {
    super.initState();
    fetchMarcas();
    fetchCategorias();
    fetchLocais();
  }

  Future<void> fetchMarcas() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/brands/'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        marcas = data
            .map((item) => DropdownMenuItem<String>(
                  value: item['id_marca'].toString(),
                  child: Text(item['nome']),
                ))
            .toList();
      });
    }
  }

  Future<void> fetchModelos(String marcaId) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/models/$marcaId'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        modelos = data
            .map((item) => DropdownMenuItem<String>(
                  value: item['id_modelo'].toString(),
                  child: Text(item['nome']),
                ))
            .toList();
      });
    }
  }

  Future<void> fetchCategorias() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/categories/'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        categorias = data
            .map((item) => DropdownMenuItem<String>(
                  value: item['id_categoria'].toString(),
                  child: Text(item['nome']),
                ))
            .toList();
      });
    }
  }

  Future<void> fetchLocais() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/page/'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        locaisOrigem = data
            .map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
                  value: item['id_localizacao'].toString(),
                  child: Text(item['nome']),
                ))
            .toList();

        locaisAtual = data
            .map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
                  value: item['nome'],
                  child: Text(item['nome']),
                ))
            .toList();
      });
    }
  }

  Future<void> registrarProduto() async {
    Item item = Item(
      id: 0,
      descricao: descricaoController.text,
      localizacaoAtual: selectedLocalAtual!,
      potencia: int.parse(potenciaController.text),
      estado: selectedEstado!,
      numeroDeSerie: numeroSerieController.text,
      numeroNotaFiscal: notaFiscalController.text,
      comentarioManutencao: comentarioManutencaoController.text,
      patrimonio: patrimonioController.text,
      categoria: int.parse(selectedCategoria!),
      status: selectedStatus!,
      modelo: int.parse(selectedModelo!),
      marca: selectedMarca!,
      localizacao: int.parse(selectedLocalOrigem!),
      dataEntrada: DateTime.parse(dataEntradaController.text),
      ultimaQualificacao: DateTime.parse(ultimaQualificacaoController.text),
      dataNotaFiscal: DateTime.parse(dataNotaFiscalController.text),
      proximaQualificacao: DateTime.parse(proximaQualificacaoController.text),
      prazoManutencao: DateTime.parse(prazoManutencaoController.text),
    );

    var body = jsonEncode(item.toJson());

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/item/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      Navigator.pop(context,
          true); // retorna para o inventário apos o cadastro, mas não atualiza a lista
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao cadastrar o item')),
      );
    }
  }

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
                      value: 'Emprestado', child: Text('Emprestado')),
                  DropdownMenuItem(
                      value: 'Manutenção', child: Text('Manutenção')),
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
                items: marcas,
                selectedValue: selectedMarca,
                onChanged: (value) {
                  setState(() {
                    selectedMarca = value;
                    selectedModelo = null;
                    isModeloEnabled = true;
                  });
                  fetchModelos(value!);
                },
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: 'Modelo',
                items: modelos,
                selectedValue: selectedModelo,
                onChanged: isModeloEnabled
                    ? (value) {
                        setState(() {
                          selectedModelo = value;
                        });
                      }
                    : null,
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: 'Categoria',
                items: categorias,
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
                items: locaisOrigem,
                selectedValue: selectedLocalOrigem,
                onChanged: (value) {
                  setState(() {
                    selectedLocalOrigem = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: 'Local Atual',
                items: locaisAtual,
                selectedValue: selectedLocalAtual,
                onChanged: (value) {
                  setState(() {
                    selectedLocalAtual = value;
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
              CustomDateField(
                  controller: dataNotaFiscalController,
                  label: 'Data da Nota Fiscal'),
              const SizedBox(height: 16),
              CustomDateField(
                  controller: dataEntradaController, label: 'Data de Entrada'),
              const SizedBox(height: 16),
              CustomDateField(
                  controller: ultimaQualificacaoController,
                  label: 'Última Manutenção'),
              const SizedBox(height: 16),
              CustomDateField(
                  controller: proximaQualificacaoController,
                  label: 'Próxima Manutenção'),
              const SizedBox(height: 16),
              CustomDateField(
                  controller: prazoManutencaoController,
                  label: 'Prazo de Manutenção'),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: comentarioManutencaoController,
                label: 'Comentário Sobre a Última Manutenção',
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
                    registrarProduto();
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
