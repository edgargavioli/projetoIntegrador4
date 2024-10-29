import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/models/marca.dart';


void main() {
  group('Marca', () {
    test('Deve instanciar corretamente o objeto Marca', () {
      final marca = Marca(
        id_marca: 1,
        nome: 'MarcaTeste',
      );

      expect(marca.id_marca, 1);
      expect(marca.nome, 'MarcaTeste');
    });

    test('Deve permitir que o nome seja nulo', () {
      final marca = Marca(
        id_marca: 2,
        nome: null,
      );

      expect(marca.id_marca, 2);
      expect(marca.nome, isNull);
    });

    test('Deve converter Marca para JSON corretamente', () {
      final marca = Marca(
        id_marca: 1,
        nome: 'MarcaTeste',
      );

      final json = marca.toJson();

      expect(json['id_marca'], 1);
      expect(json['nome'], 'MarcaTeste');
    });

    test('Deve converter Marca para JSON corretamente quando nome é nulo', () {
      final marca = Marca(
        id_marca: 2,
        nome: null,
      );

      final json = marca.toJson();

      expect(json['id_marca'], 2);
      expect(json['nome'], isNull);
    });

    test('Deve criar Marca a partir de JSON corretamente', () {
      final json = {
        'id_marca': 1,
        'nome': 'MarcaTeste',
      };

      final marca = Marca.fromJson(json);

      expect(marca.id_marca, 1);
      expect(marca.nome, 'MarcaTeste');
    });

    test('Deve criar Marca a partir de JSON corretamente quando nome é nulo', () {
      final json = {
        'id_marca': 2,
        'nome': null,
      };

      final marca = Marca.fromJson(json);

      expect(marca.id_marca, 2);
      expect(marca.nome, isNull);
    });
  });
}
