import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_integrador/models/item.dart';
import 'package:projeto_integrador/models/item_list.dart';
import 'package:projeto_integrador/models/item_notification.dart';
import 'package:projeto_integrador/models/item_vizualizar.dart';

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

  static Future<ItemVizualizar> fetchItemId(int id) async {
    try {
      final apiUrl = await getApiUrl();

      final response = await http.get(Uri.parse('$apiUrl/item/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> itemJson = json.decode(response.body);
        return ItemVizualizar.fromJson(itemJson);
      } else {
        throw Exception('Failed to load item');
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

  static Future<void> deleteItem(List<int> itemArray) async {
    final apiUrl = await getApiUrl();
    print(jsonEncode(itemArray));

    final response = await http.delete(
      Uri.parse('$apiUrl/item/deleteSelected'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(itemArray),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar o item');
    }
  }

  static Future<void> returnItems(List<int> itemIds) async {
  final apiUrl = await getApiUrl();
  final url = Uri.parse('$apiUrl/item/devolucao');

  try {
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(itemIds),
    );
  } catch (e) {
    print('Erro ao processar devolução: $e');
    throw Exception('Erro ao devolver os itens');
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

  static update(int id, Map<String, dynamic> json) async {
    final apiUrl = await getApiUrl();

    print(id);

    try {
      final response = await http.put(
        Uri.parse('$apiUrl/item/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(json),
      );

        print(response.body);
      if (response.statusCode == 200) {
        return "Item atualizado com sucesso";
      }
    } catch (e) {
      print('Error updating item: $e');
      throw Exception('Failed to update item');
    }

  }
}
