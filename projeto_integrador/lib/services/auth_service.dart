import 'package:http/http.dart';
import 'dart:convert';

import 'package:projeto_integrador/models/token.dart';

class AuthService {
  static bool isLoggedIn = false; // Simulação de estado de login

  static bool isAuthenticated() {
    // Verificar se o usuário está autenticado (pode ser feito verificando um token armazenado, por exemplo)
    return isLoggedIn;
  }

  // Simulação de login
  static Future<Token> login(username, password) async {
      final body = {
        'email': username,
        'password': password,
      };
      final response = await post(
      Uri.parse("http://10.0.2.2:8080/login"), // substituir pela URL do servidor
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
