import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {

  static Future<String> getApiUrl() async {
    await dotenv.load(fileName: ".env");
    return dotenv.env['API_URL'] ?? '';
  }

  static Future<List<Map<String, dynamic>>> fetchLocais() async {

    final apiUrl = await getApiUrl();

    final response = await http.get(Uri.parse('$apiUrl/page/'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Erro ao buscar locais');
    }
  }

}