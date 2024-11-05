import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_integrador/services/category_service.dart';

void main() async {
  // Inicializa o dotenv antes de executar os testes
  await dotenv.load(fileName: ".env");

  test('fetchCategorias returns a list of categories', () async {
    // Tente capturar a lista de categorias
    try {
      final categories = await CategoryService.fetchCategorias();

      // Verifica se a resposta é uma lista
      expect(categories, isA<List<Map<String, dynamic>>>());
      expect(categories.isNotEmpty, true); // Espera que a lista não esteja vazia
    } catch (e) {
      
      fail('Erro ao buscar categorias: $e');
    }
  });

  test('fetchCategorias throws an exception on failure', () async {
   
    try {
      await CategoryService.fetchCategorias(); // Isso deve falhar
      fail('Expected an exception but did not get one.');
    } catch (e) {
      // Verifica se a exceção lançada é a esperada
      expect(e, isA<Exception>());
      expect(e.toString(), contains('Erro ao buscar categorias'));
    }
  });
}
