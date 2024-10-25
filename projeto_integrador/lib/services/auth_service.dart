import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:projeto_integrador/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static bool isLoggedIn = false; // Simulação de estado de login

  static Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    isLoggedIn = token != null;
    // Verificar se o usuário está autenticado (pode ser feito verificando um token armazenado, por exemplo)
    return isLoggedIn;
  }

  static Future<String> getApiUrl() async {
    await dotenv.load(fileName: ".env");
    return dotenv.env['API_URL'] ?? '';
  }

  // Simulação de login
static Future<Token> login(username, password) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    final body = {
      'email': username,
      'password': password,
    };

    final apiUrl = await getApiUrl();

    final response = await post(
      Uri.parse("$apiUrl/login"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      isLoggedIn = true;
      final responseBody = jsonDecode(response.body);
      await prefs.setString('token', responseBody['token']); // Adicione 'await' aqui
      return Token.fromJson(jsonDecode(response.body));
    } else {
      throw FormatException("Usuário ou senha inválidos");
    }
  } catch (e) {
    // Trate erros, como falhas na inicialização do SharedPreferences
    print("Erro ao acessar SharedPreferences: $e");
    rethrow; // Lança o erro novamente para ser tratado em outro lugar, se necessário
  }
}


  // Simulação de logout
  static void logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');
    isLoggedIn = false;
  }
}
