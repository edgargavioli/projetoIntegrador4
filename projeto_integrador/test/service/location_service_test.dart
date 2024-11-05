import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_integrador/services/location_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'dart:convert';

class MockClient extends Mock implements http.Client {}

void main() async {
  await dotenv.load(fileName: ".env");

  group('LocationService', () {
    final client = MockClient();
    final apiUrl = dotenv.env['API_URL'];

    setUp(() {
      // Any setup code goes here.
    });

    test('fetchLocais returns a list of locations', () async {
     
      when(client.get(Uri.parse('$apiUrl/page/')))
          .thenAnswer((_) async => http.Response(
                json.encode([{'id': 1, 'name': 'Location 1'}]),
                200,
              ));

      // Chama o método e verifica o resultado
      final locais = await LocationService.fetchLocais();

      expect(locais, isA<List<Map<String, dynamic>>>());
      expect(locais.length, 1);
      expect(locais[0]['id'], 1);
      expect(locais[0]['name'], 'Location 1');
    });

    test('fetchLocais throws an exception when the response is not 200', () async {
      // Simula uma resposta de erro da API
      when(client.get(Uri.parse('$apiUrl/page/')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() async => await LocationService.fetchLocais(),
          throwsA(isA<Exception>()));
    });
  });
}
