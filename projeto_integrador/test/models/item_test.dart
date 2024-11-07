import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/models/item.dart';


void main() {
  group('Item', () {
    test('Deve instanciar corretamente o objeto Item', () {
      final item = Item(
        id: 1,
        descricao: 'Item de teste',
        localizacaoAtual: 'Almoxarifado',
        potencia: 100,
        estado: 'Bom',
        numeroDeSerie: '123456',
        numeroNotaFiscal: '78910',
        comentarioManutencao: 'Revisado recentemente',
        patrimonio: 'PAT1234',
        categoria: 2,
        status: 'Disponível',
        modelo: 3,
        marca: 'MarcaTeste',
        localizacao: 4,
        dataEntrada: DateTime(2024, 10, 29),
        ultimaQualificacao: DateTime(2024, 10, 20),
        dataNotaFiscal: DateTime(2024, 10, 10),
        proximaQualificacao: DateTime(2025, 10, 10),
        prazoManutencao: DateTime(2025, 5, 15),
      );

      expect(item.id, 1);
      expect(item.descricao, 'Item de teste');
      expect(item.localizacaoAtual, 'Almoxarifado');
      expect(item.potencia, 100);
      expect(item.estado, 'Bom');
      expect(item.numeroDeSerie, '123456');
      expect(item.numeroNotaFiscal, '78910');
      expect(item.comentarioManutencao, 'Revisado recentemente');
      expect(item.patrimonio, 'PAT1234');
      expect(item.categoria, 2);
      expect(item.status, 'Disponível');
      expect(item.modelo, 3);
      expect(item.marca, 'MarcaTeste');
      expect(item.localizacao, 4);
      expect(item.dataEntrada, DateTime(2024, 10, 29));
      expect(item.ultimaQualificacao, DateTime(2024, 10, 20));
      expect(item.dataNotaFiscal, DateTime(2024, 10, 10));
      expect(item.proximaQualificacao, DateTime(2025, 10, 10));
      expect(item.prazoManutencao, DateTime(2025, 5, 15));
    });

    test('Deve converter Item para JSON corretamente', () {
      final item = Item(
        id: 1,
        descricao: 'Item de teste',
        localizacaoAtual: 'Almoxarifado',
        potencia: 100,
        estado: 'Bom',
        numeroDeSerie: '123456',
        numeroNotaFiscal: '78910',
        comentarioManutencao: 'Revisado recentemente',
        patrimonio: 'PAT1234',
        categoria: 2,
        status: 'Disponível',
        modelo: 3,
        marca: 'MarcaTeste',
        localizacao: 4,
        dataEntrada: DateTime(2024, 10, 29),
        ultimaQualificacao: DateTime(2024, 10, 20),
        dataNotaFiscal: DateTime(2024, 10, 10),
        proximaQualificacao: DateTime(2025, 10, 10),
        prazoManutencao: DateTime(2025, 5, 15),
      );

      final json = item.toJson();

      expect(json['id_item'], 1);
      expect(json['descricao'], 'Item de teste');
      expect(json['localizacao_atual'], 'Almoxarifado');
      expect(json['potencia'], 100);
      expect(json['estado'], 'Bom');
      expect(json['numero_de_serie'], '123456');
      expect(json['numero_nota_fiscal'], '78910');
      expect(json['comentario_manutencao'], 'Revisado recentemente');
      expect(json['patrimonio'], 'PAT1234');
      expect(json['categoria'], 2);
      expect(json['status'], 'Disponível');
      expect(json['modelo'], 3);
      expect(json['marca'], 'MarcaTeste');
      expect(json['localizacao'], 4);
      expect(json['data_entrada'], DateTime(2024, 10, 29).toIso8601String());
      expect(json['ultima_qualificacao'], DateTime(2024, 10, 20).toIso8601String());
      expect(json['data_nota_fiscal'], DateTime(2024, 10, 10).toIso8601String());
      expect(json['proxima_qualificacao'], DateTime(2025, 10, 10).toIso8601String());
      expect(json['prazo_manutencao'], DateTime(2025, 5, 15).toIso8601String());
    });

    test('Deve criar Item a partir de JSON corretamente', () {
      final json = {
        'id_item': 1,
        'descricao': 'Item de teste',
        'localizacao_atual': 'Almoxarifado',
        'potencia': 100,
        'estado': 'Bom',
        'numero_de_serie': '123456',
        'numero_nota_fiscal': '78910',
        'comentario_manutencao': 'Revisado recentemente',
        'patrimonio': 'PAT1234',
        'categoria': 2,
        'status': 'Disponível',
        'modelo': 3,
        'marca': 'MarcaTeste',
        'localizacao': 4,
        'data_entrada': '2024-10-29T00:00:00.000',
        'ultima_qualificacao': '2024-10-20T00:00:00.000',
        'data_nota_fiscal': '2024-10-10T00:00:00.000',
        'proxima_qualificacao': '2025-10-10T00:00:00.000',
        'prazo_manutencao': '2025-05-15T00:00:00.000',
      };

      final item = Item.fromJson(json);

      expect(item.id, 1);
      expect(item.descricao, 'Item de teste');
      expect(item.localizacaoAtual, 'Almoxarifado');
      expect(item.potencia, 100);
      expect(item.estado, 'Bom');
      expect(item.numeroDeSerie, '123456');
      expect(item.numeroNotaFiscal, '78910');
      expect(item.comentarioManutencao, 'Revisado recentemente');
      expect(item.patrimonio, 'PAT1234');
      expect(item.categoria, 2);
      expect(item.status, 'Disponível');
      expect(item.modelo, 3);
      expect(item.marca, 'MarcaTeste');
      expect(item.localizacao, 4);
      expect(item.dataEntrada, DateTime.parse('2024-10-29T00:00:00.000'));
      expect(item.ultimaQualificacao, DateTime.parse('2024-10-20T00:00:00.000'));
      expect(item.dataNotaFiscal, DateTime.parse('2024-10-10T00:00:00.000'));
      expect(item.proximaQualificacao, DateTime.parse('2025-10-10T00:00:00.000'));
      expect(item.prazoManutencao, DateTime.parse('2025-05-15T00:00:00.000'));
    });
  });
}
