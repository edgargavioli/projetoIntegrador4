import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:projeto_integrador/models/user.dart';

import '../../test/service/user_service_test.dart';

class UserService {
  UserService(MockClient client);

  static Future<String> getApiUrl() async {
    await dotenv.load(fileName: ".env");
    return dotenv.env['API_URL'] ?? '';
  }

  static Future<List<User>> getUsers() async {
    final apiUrl = await getApiUrl();
    final url = Uri.parse("$apiUrl/user/");
    final response = await get(url);

    if (response.statusCode == 200) {
      final List<dynamic> userJson =
          jsonDecode(utf8.decode(response.bodyBytes));
      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar usuários');
    }
  }

  static Future<bool> registerUser(User user) async {
    final apiUrl = await getApiUrl();
    final response = await post(
      Uri.parse("$apiUrl/user/"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      print('Usuário cadastrado com sucesso!');
      return true;
    } else {
      print('Erro no cadastro: ${response.body}');
      return false;
    }
  }
}
