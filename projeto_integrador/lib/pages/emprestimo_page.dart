import 'package:flutter/material.dart';
import 'package:projeto_integrador/models/item.dart';
import 'package:projeto_integrador/models/item_list.dart';

class EmprestimoPage extends StatelessWidget {
  final List<ItemList> selectedItems;
  const EmprestimoPage({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    // Obtém os itens selecionados passados como argumento
    // final List<ItemList> data = ModalRoute.of(context)?.settings.arguments as List<ItemList>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Empréstimo de Itens'),
      ),
      body: Text('Empréstimo de ${selectedItems.length} itens'),
    );
  }
}
