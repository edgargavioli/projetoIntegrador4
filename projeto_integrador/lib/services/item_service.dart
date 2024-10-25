import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_integrador/models/item_list.dart';
import 'package:projeto_integrador/models/item_notification.dart';

class ItemService {
  static Future<String> getApiUrl() async {
    await dotenv.load(fileName: ".env");
    return dotenv.env['API_URL'] ?? '';
  }

  static Future<List<ItemList>> fetchItemsInventarioPage() async {
    try {
      final apiUrl = await getApiUrl();

      final response = await http.get(Uri.parse('$apiUrl/item/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse =
            json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse
            .map((json) => ItemList.fromJson(json))
            .toList(); // problema: aqui é onde acontece o erro de marca dentro modelo
      } else {
        // Quando resolver o problema descrito em modelo.dart, trocar Item_List por Item, como era originalmente
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print('Error fetching items: $e');
      throw Exception('Failed to load items');
    }
  }

  static Future<List<ItemNotification>> fetchItemsNotificationsPage() async {
    try {
      final apiUrl = await getApiUrl();

      final response = await http.get(Uri.parse('$apiUrl/item/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse =
            json.decode(utf8.decode(response.bodyBytes));
        return jsonResponse
            .map((json) => ItemNotification.fromJson(json))
            .toList();
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

    final apiUrl = await getApiUrl();

    final response = await http.post(
      Uri.parse('$apiUrl/item/'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao cadastrar o item');
    }
  }

  static Future<void> deleteItem(List<int> item_array) async {
    final apiUrl = await getApiUrl();
    print(jsonEncode(item_array));

    final response = await http.delete(
      Uri.parse('$apiUrl/item/deleteSelected'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item_array),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar o item');
    }
  }

  static Future<List<ItemNotification>> fetchItemsNotifications() async {
    final apiUrl = await getApiUrl();

    final response = await http.get(Uri.parse('$apiUrl/item/notificacoes'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => ItemNotification.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao carregar notificações');
    }
  }
}
