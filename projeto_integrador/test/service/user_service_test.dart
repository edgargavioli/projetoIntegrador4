import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:projeto_integrador/models/user.dart';
import 'package:projeto_integrador/services/user_service.dart';

// Cria uma classe mock para o cliente HTTP
class MockClient extends Mock implements http.Client {}

void main() {
  group('UserService', () {
    MockClient client;
    UserService userService;

    // Inicializa o mock antes de cada teste
    setUp(() {
      client = MockClient();
      userService = UserService(client); 
    });

    test('getUsers returns a list of users if the http call completes successfully', () async {
      when(client.get(Uri.parse('http://localhost:8080/user/')))
          .thenAnswer((_) async => http.Response(
                jsonEncode([{'id': 1, 'name': 'John Doe'}]),
                200,
              ));

      final users = await UserService.getUsers(); 

      expect(users, isA<List<User>>());
      expect(users.length, 1);
      expect(users[0].nome, 'John Doe');
      
      // Verifique se o método get foi chamado com a URL correta
      verify(client.get(Uri.parse('http://localhost:8080/user/'))).called(1);
    });

    test('getUsers throws an exception if the http call completes with an error', () {
      when(client.get(Uri.parse('http://localhost:8080/user/')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() async => await userService.getUsers(), throwsA(isA<Exception>()));
      
      // Verifique se o método get foi chamado
      verify(client.get(Uri.parse('http://localhost:8080/user/'))).called(1);
    });

    test('registerUser returns true if the http call completes successfully', () async {
      final user = User(id: 1, name: 'John Doe');
      when(client.post(
        Uri.parse('http://localhost:8080/user/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      )).thenAnswer((_) async => http.Response('{"message": "success"}', 200));

      final result = await userService.registerUser(user); 

      expect(result, true);
      
      // Verifique se o método post foi chamado com os parâmetros corretos
      verify(client.post(
        Uri.parse('http://localhost:8080/user/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      )).called(1);
    });

    test('registerUser returns false if the http call completes with an error', () async {
      final user = User(id: 1, name: 'John Doe');
      when(client.post(
        Uri.parse('http://localhost:8080/user/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      )).thenAnswer((_) async => http.Response('{"message": "error"}', 400));

      final result = await userService.registerUser(user); 

      expect(result, false);
      
      // Verifique se o método post foi chamado
      verify(client.post(
        Uri.parse('http://localhost:8080/user/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      )).called(1);
    });
  });
}
