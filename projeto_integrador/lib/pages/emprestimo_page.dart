import 'package:flutter/material.dart';
import 'package:projeto_integrador/models/item.dart';
import 'package:projeto_integrador/models/item_list.dart';

class EmprestimoPage extends StatelessWidget {
  const EmprestimoPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ItemList> data =
        ModalRoute.of(context)?.settings.arguments as List<ItemList>;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Empréstimo de Itens'),
        ),
        body: Text(data.toString()));
  }
}
