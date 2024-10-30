import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_app_bar.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/item.dart';
import 'package:projeto_integrador/models/item_vizualizar.dart';
import 'package:projeto_integrador/services/item_service.dart';

class ItemEditPage extends StatefulWidget {
  final int id;

  const ItemEditPage({super.key, required this.id});

  @override
  State<ItemEditPage> createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController numeroSerieController = TextEditingController();
  final TextEditingController potenciaController = TextEditingController();
  final TextEditingController notaFiscalController = TextEditingController();
  final TextEditingController patrimonioController = TextEditingController();
  final TextEditingController comentarioManutencaoController = TextEditingController();
  final TextEditingController dataEntradaController = TextEditingController();
  final TextEditingController ultimaQualificacaoController = TextEditingController();
  final TextEditingController dataNotaFiscalController = TextEditingController();
  final TextEditingController proximaQualificacaoController = TextEditingController();
  final TextEditingController prazoManutencaoController = TextEditingController();

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
  late Future<ItemVizualizar> itemFuture;

  @override
  void initState() {
    super.initState();
    itemFuture = ItemService.fetchItemId(widget.id).then((item) {
      // Preenche os controladores e seleções com os dados do item para edição
      descricaoController.text = item.descricao;
      numeroSerieController.text = item.numeroDeSerie;
      potenciaController.text = item.potencia?.toString() ?? '';
      notaFiscalController.text = item.numeroNotaFiscal;
      patrimonioController.text = item.patrimonio;
      comentarioManutencaoController.text = item.comentarioManutencao;
      dataEntradaController.text = item.dataEntrada.toIso8601String();
      ultimaQualificacaoController.text = item.ultimaQualificacao.toIso8601String();
      dataNotaFiscalController.text = item.dataNotaFiscal.toIso8601String();
      proximaQualificacaoController.text = item.proximaQualificacao.toIso8601String();
      prazoManutencaoController.text = item.prazoManutencao.toIso8601String();

      selectedEstado = item.estado;
      selectedMarca = item.modelo.marca.toString();
      selectedModelo = item.modelo.toString();
      selectedCategoria = item.categoria.toString();
      selectedLocalOrigem = item.localizacao.toString();
      selectedLocalAtual = item.localizacaoAtual;
      selectedStatus = item.status;

      return item;
    });
  }

  Future<void> salvarItem() async {
    try {
      DateTime dataEntrada = DateTime.parse(dataEntradaController.text).add(const Duration(days: 1));
      DateTime ultimaQualificacao = DateTime.parse(ultimaQualificacaoController.text).add(const Duration(days: 1));
      DateTime dataNotaFiscal = DateTime.parse(dataNotaFiscalController.text).add(const Duration(days: 1));
      DateTime proximaQualificacao = DateTime.parse(proximaQualificacaoController.text).add(const Duration(days: 1));
      DateTime prazoManutencao = DateTime.parse(prazoManutencaoController.text).add(const Duration(days: 1));

      int? potencia;
      if (potenciaController.text.isNotEmpty) {
        potencia = int.tryParse(potenciaController.text);
      }

      Item item = Item(
        id: widget.id,
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

      await ItemService.update(item.id, item.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item salvo com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar o item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder<ItemVizualizar>(
        future: itemFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar item: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                        child: Text(
                          "Editar Item",
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
                    // Adicione aqui outros campos para editar o item
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: salvarItem,
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.check),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Item não encontrado.'));
          }
        },
      ),
    );
  }
}
