import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/models/item_list.dart';


void main() {
  group('ItemList Model', () {
    test('Deve instanciar corretamente o objeto ItemList', () {
      final item = ItemList(
        id: 1,
        descricao: 'Microscópio',
        estado: 'disponível',
      );

      expect(item.id, 1);
      expect(item.descricao, 'Microscópio');
      expect(item.estado, 'disponível');
    });

    test('Deve converter ItemList para JSON corretamente', () {
      final item = ItemList(
        id: 2,
        descricao: 'Centrífuga',
        estado: 'em manutenção',
      );

      final json = item.toJson();

      expect(json, {
        'id_item': 2,
        'descricao': 'Centrífuga',
        'estado': 'em manutenção',
      });
    });

    test('Deve criar ItemList a partir de JSON corretamente', () {
      final json = {
        'id_item': 3,
        'descricao': 'Balança',
        'estado': 'emprestado',
      };

      final item = ItemList.fromJson(json);

      expect(item.id, 3);
      expect(item.descricao, 'Balança');
      expect(item.estado, 'emprestado');
    });
  });
}
