import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/models/emprestante.dart';


void main() {
  group('Emprestante Model', () {
    test('Deve instanciar corretamente o objeto Emprestante', () {
      final emprestante = Emprestante(
        id_emprestante: 1,
        num_identificacao: '123456',
        nome: 'João Silva',
      );

      expect(emprestante.id_emprestante, 1);
      expect(emprestante.num_identificacao, '123456');
      expect(emprestante.nome, 'João Silva');
    });

    test('Deve converter Emprestante para JSON corretamente', () {
      final emprestante = Emprestante(
        id_emprestante: 1,
        num_identificacao: '123456',
        nome: 'João Silva',
      );

      final json = emprestante.toJson();
      expect(json, {
        'id_emprestante': 1,
        'num_identificacao': '123456',
        'nome': 'João Silva',
      });
    });

    test('Deve criar Emprestante a partir de JSON corretamente', () {
      final json = {
        'id_emprestante': 1,
        'num_identificacao': '123456',
        'nome': 'João Silva',
      };

      final emprestante = Emprestante.fromJson(json);

      expect(emprestante.id_emprestante, 1);
      expect(emprestante.num_identificacao, '123456');
      expect(emprestante.nome, 'João Silva');
    });
  });
}
