import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {

  static Future<List<Map<String, dynamic>>> fetchLocais() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/page/'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Erro ao buscar locais');
    }
  }

}