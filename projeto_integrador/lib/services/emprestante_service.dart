import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_integrador/models/emprestante.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmprestanteService {
  static Future<String> getApiUrl() async {
    await dotenv.load(fileName: ".env");
    return dotenv.env['API_URL'] ?? '';
  }

  static Future<List<Emprestante>> getEmprestantes() async {
    final baseUrl = await getApiUrl();
    final response = await http.get(Uri.parse('$baseUrl/emprestantes/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((emprestante) => Emprestante.fromJson(emprestante))
          .toList();
    } else {
      throw Exception('Failed to load emprestantes');
    }
  }
}
