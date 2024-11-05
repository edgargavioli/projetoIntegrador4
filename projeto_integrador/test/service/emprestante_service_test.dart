import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_integrador/services/emprestante_service.dart';
import 'package:projeto_integrador/models/emprestante.dart';

void main() async {
  
  await dotenv.load(fileName: ".env");

  test('createEmprestante should create a new emprestante', () async {
    final emprestanteData = {
      'nome': 'Test Emprestante',
      'email': 'test@example.com',
      // adicione outros campos conforme necessário
    };

    try {
      await EmprestanteService.createEmprestante(emprestanteData);
      // Suponha que a criação é bem-sucedida se não lançar exceção.
      expect(true, true); // Se não lançar exceção, o teste passa.
    } catch (e) {
      fail('Erro ao criar emprestante: $e');
    }
  });

  test('getEmprestantes returns a list of emprestantes', () async {
    try {
      final emprestantes = await EmprestanteService.getEmprestantes();
      expect(emprestantes, isA<List<Emprestante>>());
      expect(emprestantes.isNotEmpty, true); // Espera que a lista não esteja vazia
    } catch (e) {
      fail('Erro ao buscar emprestantes: $e');
    }
  });

  test('updateEmprestante should update an existing emprestante', () async {
    final emprestante = Emprestante(id_emprestante: 1, nome: 'Updated Name', email: 'updated@example.com', num_identificacao: '1');
    try {
      await EmprestanteService.updateEmprestante(emprestante);
      expect(true, true); // Supondo que a atualização foi bem-sucedida
    } catch (e) {
      fail('Erro ao atualizar emprestante: $e');
    }
  });

  test('deleteEmprestante should delete an existing emprestante', () async {
    try {
      await EmprestanteService.deleteEmprestante(1); // Use um ID existente
      expect(true, true); // Supondo que a exclusão foi bem-sucedida
    } catch (e) {
      fail('Erro ao excluir emprestante: $e');
    }
  });
}
