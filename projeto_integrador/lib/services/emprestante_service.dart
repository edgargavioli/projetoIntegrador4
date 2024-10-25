import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_integrador/models/emprestante.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmprestanteService {
  static Future<String> getApiUrl() async {
    await dotenv.load(fileName: ".env");
    return dotenv.env['API_URL'] ?? '';
  }

  static Future<void> createEmprestante(
      Map<String, dynamic> emprestanteData) async {
    final baseUrl = await getApiUrl();
    final response = await http.post(
      Uri.parse('$baseUrl/emprestantes/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(emprestanteData),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao cadastrar emprestante: ${response.body}');
    }
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

  static Future<void> updateEmprestante(Emprestante emprestante) async {
    final baseUrl = await getApiUrl();
    final response = await http.put(
      Uri.parse('$baseUrl/emprestantes/edit/${emprestante.id_emprestante}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(emprestante.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao editar o emprestante.');
    }
  }

  static Future<void> deleteEmprestante(int id) async {
    final baseUrl = await getApiUrl();
    final response = await http.delete(Uri.parse('$baseUrl/emprestantes/$id'));

    if (response.statusCode != 204) {
      throw Exception('Falha ao excluir o emprestante');
    }
  }
}
