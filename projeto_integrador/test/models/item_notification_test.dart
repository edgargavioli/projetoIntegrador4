import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/models/item_notification.dart';


void main() {
  group('ItemNotification', () {
    test('Deve instanciar corretamente o objeto ItemNotification', () {
      final notification = ItemNotification(
        descricao: 'Manutenção de rotina',
        proxima_qualificacao: DateTime(2024, 12, 25),
      );

      expect(notification.descricao, 'Manutenção de rotina');
      expect(notification.proxima_qualificacao, DateTime(2024, 12, 25));
    });

    test('Deve criar ItemNotification a partir de JSON corretamente', () {
      final json = {
        'descricao': 'Inspeção anual',
        'proxima_qualificacao': '2024-11-10T00:00:00.000Z',
      };

      final notification = ItemNotification.fromJson(json);

      expect(notification.descricao, 'Inspeção anual');
      expect(notification.proxima_qualificacao, DateTime.parse('2024-11-10T00:00:00.000Z'));
    });

    test('Deve criar ItemNotification a partir de JSON com proxima_qualificacao nula', () {
      final json = {
        'descricao': 'Inspeção sem data',
        'proxima_qualificacao': null,
      };

      final notification = ItemNotification.fromJson(json);

      expect(notification.descricao, 'Inspeção sem data');
      expect(notification.proxima_qualificacao, isNull);
    });
  });
}
