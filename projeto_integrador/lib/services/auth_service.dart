import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:projeto_integrador/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static bool isLoggedIn = false;

  // Verifica se o token está armazenado no SharedPreferences
  static Future<bool> isAuthenticated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }

    return isLoggedIn;
  }

  // Obter a URL da API do arquivo .env
  static Future<String> getApiUrl() async {
    await dotenv.load(fileName: ".env");
    return dotenv.env['API_URL'] ?? '';
  }

  // Método de login
  static Future<Token> login(String username, String password) async {
    final body = {
      'email': username,
      'password': password,
    };

    final apiUrl = await getApiUrl();

    final response = await post(
      Uri.parse("$apiUrl/login"), // substituir pela URL do servidor
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      isLoggedIn = true;
      final token = Token.fromJson(jsonDecode(response.body));

      // Salvar o token no SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token.token);

      return token;
    } else {
      throw FormatException("Usuário ou senha inválidos");
    }
  }

  // Método de logout
  static Future<void> logout() async {
    isLoggedIn = false;

    // Remover o token do SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
