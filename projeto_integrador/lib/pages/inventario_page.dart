import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_textfield.dart';
import 'package:projeto_integrador/models/item.dart';
import 'package:http/http.dart' as http;

class InventarioPage extends StatefulWidget {
  const InventarioPage({super.key});

  @override
  State<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Item> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/item/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          _isLoading = false;
          _items = jsonResponse.map((json) => Item.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Text(item.descricao),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      );
  }
}