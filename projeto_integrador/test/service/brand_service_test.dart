import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:projeto_integrador/services/brand_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MockClient extends Mock implements http.Client {}

void main() {
  group('BrandService Testes', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('Retorna lista de marcas quando a resposta é 200', () async {
      // Dados simulados da resposta da API
      final mockData = [
        {"id": 1, "name": "Marca A"},
        {"id": 2, "name": "Marca B"},
      ];

      // URL da API simulada
      const apiUrl = 'https://mockapi.com';

      // Mock do URL da API
      when(BrandService.getApiUrl()).thenAnswer((_) async => apiUrl);

      // Mock da resposta da API
      when(mockClient.get(Uri.parse('$apiUrl/brands/'))).thenAnswer(
        (_) async => http.Response(jsonEncode(mockData), 200),
      );

      // Chamada do serviço para obter as marcas
      final result = await BrandService.fetchMarcas();

      // Verificação
      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.length, 2);
      expect(result[0]['name'], "Marca A");
      expect(result[1]['name'], "Marca B");
    });

    test('Lança uma exceção quando a resposta não é 200', () async {
      const apiUrl = 'https://mockapi.com';

      when(BrandService.getApiUrl()).thenAnswer((_) async => apiUrl);

      // Simulação de erro na resposta da API
      when(mockClient.get(Uri.parse('$apiUrl/brands/')))
          .thenAnswer((_) async => http.Response('Erro', 404));

      // Verificação se a função lança uma exceção
      expect(() async => await BrandService.fetchMarcas(), throwsException);
    });
  });
}
