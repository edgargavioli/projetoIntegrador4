import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_integrador/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Cria um mock de SharedPreferences para simular armazenamento local
class MockSharedPreferences extends Mock implements SharedPreferences {}

// Cria um mock para a API http
class MockClient extends Mock implements http.Client {}

void main() {
  late MockSharedPreferences mockPrefs;
  late MockClient mockClient;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    mockClient = MockClient();
  });

  group('AuthService', () {
    test('isAuthenticated retorna true se o token estiver presente', () async {
      // Simula o token armazenado em SharedPreferences
      when(mockPrefs.getString('token')).thenReturn('token_de_teste');
      SharedPreferences.setMockInitialValues({'token': 'token_de_teste'});

      final result = await AuthService.isAuthenticated();

      expect(result, isTrue);
    });

    test('isAuthenticated retorna false se o token não estiver presente', () async {
      // Remove qualquer valor de token
      SharedPreferences.setMockInitialValues({});

      final result = await AuthService.isAuthenticated();

      expect(result, isFalse);
    });

    test('login salva o token e retorna um objeto Token ao sucesso', () async {
      // Configurações do login
      final username = 'vitordallanol@gmail.com';
      final password = 'adm';
      final apiUrl = 'http://localhost:3000';
      
      // Define a resposta de sucesso do servidor
      final response = {
        'token': 'token_de_teste',
      };

      // Simula o comportamento da resposta da API
      when(mockClient.post(
        Uri.parse('$apiUrl/login'),
        headers: anyNamed('headers'),
        body: jsonEncode({'email': username, 'password': password}),
      )).thenAnswer(
        (_) async => http.Response(jsonEncode(response), 200),
      );

      // Chama o método de login
      final token = await AuthService.login(username, password);

      // Verifica se o token foi salvo no SharedPreferences e o token correto foi retornado
      verify(mockPrefs.setString('token', response['token']!));
      expect(token.token, 'token_de_teste');
    });

    test('login lança uma exceção quando o login falha', () async {
      final username = 'user@example.com';
      final password = 'senha_incorreta';
      final apiUrl = 'http://localhost:3000';

      // Define uma resposta de falha do servidor
      when(mockClient.post(
        Uri.parse('$apiUrl/login'),
        headers: anyNamed('headers'),
        body: jsonEncode({'email': username, 'password': password}),
      )).thenAnswer(
        (_) async => http.Response('Usuário ou senha inválidos', 400),
      );

      // Verifica se o login lança uma exceção
      expect(
        () async => await AuthService.login(username, password),
        throwsFormatException,
      );
    });

    
  });
}
