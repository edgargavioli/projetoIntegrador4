import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:projeto_integrador/models/token.dart';

class AuthService {
  static bool isLoggedIn = false; // Simulação de estado de login

  static bool isAuthenticated() {
    // Verificar se o usuário está autenticado (pode ser feito verificando um token armazenado, por exemplo)
    return isLoggedIn;
  }

  static Future<String> getApiUrl() async {
    await dotenv.load(fileName: ".env");
    return dotenv.env['API_URL'] ?? '';
  }

  // Simulação de login
  static Future<Token> login(username, password) async {
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
      return Token.fromJson(jsonDecode(response.body));
    } else {
      throw FormatException("Usuário ou senha inválidos");
    }
  }

  // Simulação de logout
  static void logout() {
    isLoggedIn = false;
  }
}
