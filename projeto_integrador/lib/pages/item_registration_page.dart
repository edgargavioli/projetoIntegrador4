import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/components/custom_select_field.dart';
import 'package:projeto_integrador/components/custom_date_field.dart';
import 'package:projeto_integrador/models/item.dart';
import 'package:projeto_integrador/services/brand_service.dart';
import 'package:projeto_integrador/services/category_service.dart';
import 'package:projeto_integrador/services/item_service.dart';
import 'package:projeto_integrador/services/location_service.dart';
import 'package:projeto_integrador/services/model_service.dart';

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
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      final data = await BrandService.fetchMarcas();
      setState(() {
        marcas = data
            .map((item) => DropdownMenuItem<String>(
                  value: item['id_marca'].toString(),
                  child: Text(item['nome']),
                ))
            .toList();
      });
    } catch (e) {
      print('Erro ao buscar marcas: $e');
    }

    try {
      final data = await CategoryService.fetchCategorias();
      setState(() {
        categorias = data
            .map((item) => DropdownMenuItem<String>(
                  value: item['id_categoria'].toString(),
                  child: Text(item['nome']),
                ))
            .toList();
      });
    } catch (e) {
      print('Erro ao buscar categorias: $e');
    }

    try {
      final data = await LocationService.fetchLocais();
      setState(() {
        locaisOrigem = data
            .map((item) => DropdownMenuItem<String>(
                  value: item['id_localizacao'].toString(),
                  child: Text(item['nome']),
                ))
            .toList();

        locaisAtual = data
            .map((item) => DropdownMenuItem<String>(
                  value: item['nome'],
                  child: Text(item['nome']),
                ))
            .toList();
      });
    } catch (e) {
      print('Erro ao buscar locais: $e');
    }
  }

  Future<void> carregarModelos(String marcaId) async {
    try {
      final data = await ModelService.fetchModelos(marcaId);
      setState(() {
        modelos = data
            .map((item) => DropdownMenuItem<String>(
                  value: item['id_modelo'].toString(),
                  child: Text(item['nome']),
                ))
            .toList();
      });
    } catch (e) {
      print('Erro ao buscar modelos: $e');
    }
  }

  Future<void> cadastrarProduto() async {
    try {
      DateTime dataEntrada = DateTime.parse(dataEntradaController.text)
          .add(const Duration(days: 1));
      DateTime ultimaQualificacao =
          DateTime.parse(ultimaQualificacaoController.text)
              .add(const Duration(days: 1));
      DateTime dataNotaFiscal = DateTime.parse(dataNotaFiscalController.text)
          .add(const Duration(days: 1));
      DateTime proximaQualificacao =
          DateTime.parse(proximaQualificacaoController.text)
              .add(const Duration(days: 1));
      DateTime prazoManutencao = DateTime.parse(prazoManutencaoController.text)
          .add(const Duration(days: 1));

        int? potencia;
        if(potenciaController.text.isNotEmpty){
          potencia = int.tryParse(potenciaController.text);
        }

      Item item = Item(
        id: 0,
        descricao: descricaoController.text,
        localizacaoAtual: selectedLocalAtual!,
        potencia: potencia,
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
        dataEntrada: dataEntrada,
        ultimaQualificacao: ultimaQualificacao,
        dataNotaFiscal: dataNotaFiscal,
        proximaQualificacao: proximaQualificacao,
        prazoManutencao: prazoManutencao,
      );

      await ItemService.createItem(item.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
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
                label: '*Item',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: numeroSerieController,
                label: '*Número de Série',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: '*Disponibilidade',
                items: const [
                  DropdownMenuItem(
                      value: 'Disponivel', child: Text('Disponível')),
                  DropdownMenuItem(
                      value: 'Emprestado', child: Text('Emprestado')),
                  DropdownMenuItem(
                      value: 'Manutencao', child: Text('Manutenção')),
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
                label: '*Marca',
                items: marcas,
                selectedValue: selectedMarca,
                onChanged: (value) {
                  setState(() {
                    selectedMarca = value;
                    selectedModelo = null;
                    isModeloEnabled = true;
                  });
                  carregarModelos(value!);
                },
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: '*Modelo',
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
                label: '*Categoria',
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
                label: '*Origem',
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
                label: '*Local Atual',
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
                obscureText: false,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: notaFiscalController,
                label: '*Nota Fiscal',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              CustomDateField(
                  controller: dataNotaFiscalController,
                  label: '*Data da Nota Fiscal'),
              const SizedBox(height: 16),
              CustomDateField(
                  controller: dataEntradaController, label: '*Data de Entrada'),
              const SizedBox(height: 16),
              CustomDateField(
                  controller: ultimaQualificacaoController,
                  label: '*Última Manutenção'),
              const SizedBox(height: 16),
              CustomDateField(
                  controller: proximaQualificacaoController,
                  label: '*Próxima Manutenção'),
              const SizedBox(height: 16),
              CustomDateField(
                  controller: prazoManutencaoController,
                  label: '*Prazo de Manutenção'),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: comentarioManutencaoController,
                label: 'Comentário Sobre a Última Manutenção',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: patrimonioController,
                label: '*Patrimônio',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              CustomSelectField(
                label: '*Status',
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
                    cadastrarProduto();
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
