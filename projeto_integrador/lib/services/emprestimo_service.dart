import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmprestimoService {
  static Future<String> getApiUrl() async {
    await dotenv.load(fileName: ".env");
    return dotenv.env['API_URL'] ?? '';
  }

  static Future<void> realizarEmprestimo(
    List<Map<String, dynamic>> emprestimos) async {
    var body = jsonEncode(emprestimos);

    final apiUrl = await getApiUrl();

    final response = await http.post(
      Uri.parse('$apiUrl/action/emprestarItens'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
  }
}
