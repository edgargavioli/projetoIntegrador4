import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_integrador/models/item_list.dart';
import 'package:projeto_integrador/models/item_notification.dart';

class ItemService {

  static Future<List<ItemList>> fetchItemsInventarioPage() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/item/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse.map((json) => ItemList.fromJson(json)).toList(); // problema: aqui é onde acontece o erro de marca dentro modelo
      } else { // Quando resolver o problema descrito em modelo.dart, trocar Item_List por Item, como era originalmente
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print('Error fetching items: $e');
      throw Exception('Failed to load items');
    }
  }

  static Future<List<ItemNotification>> fetchItemsNotificationsPage() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8080/item/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse.map((json) => ItemNotification.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print('Error fetching notification items: $e');
      throw Exception('Failed to load items');
    }
  }

  static Future<void> createItem(Map<String, dynamic> item) async {
    var body = jsonEncode(item);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/item/'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao cadastrar o item');
    }
  }
}
