import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/models/item_vizualizar.dart'; // Altere para o caminho correto do seu arquivo
 // Importe a classe Localizacao

void main() {
  group('ItemVizualizar', () {
    late ItemVizualizar item;

    setUp(() {
      // Configuração antes de cada teste
      item = ItemVizualizar(
        idItem: 1,
        descricao: 'Item de Teste',
        localizacaoAtual: 'Estoque 1',
        potencia: 100,
        patrimonio: 'PATRIMONIO123',
        numeroDeSerie: 'SN123456',
        numeroNotaFiscal: 'NF123456',
        comentarioManutencao: 'Sem comentários',
        dataEntrada: DateTime.parse('2023-01-01T00:00:00'),
        ultimaQualificacao: DateTime.parse('2023-06-01T00:00:00'),
        dataNotaFiscal: DateTime.parse('2023-06-01T00:00:00'),
        proximaQualificacao: DateTime.parse('2024-01-01T00:00:00'),
        prazoManutencao: DateTime.parse('2024-06-01T00:00:00'),
        estado: 'Em uso',
        categoria: Categoria(idCategoria: 1, nome: 'Categoria Teste'),
        status: 'Ativo',
        modelo: Modelo(idModelo: 1, nome: 'Modelo Teste', marca: Marca(idMarca: 1, nome: 'Marca Teste')),
        localizacao: Localizacao(idLocalizacao: 1, nome: 'Localização Teste'),
      );
    });

    test('fromJson should create an ItemVizualizar instance from a JSON map', () {
      final json = {
        'id_item': 1,
        'descricao': 'Item de Teste',
        'localizacao_atual': 'Estoque 1',
        'potencia': 100,
        'patrimonio': 'PATRIMONIO123',
        'numero_de_serie': 'SN123456',
        'numero_nota_fiscal': 'NF123456',
        'comentario_manutencao': 'Sem comentários',
        'data_entrada': '2023-01-01T00:00:00',
        'ultima_qualificacao': '2023-06-01T00:00:00',
        'data_nota_fiscal': '2023-06-01T00:00:00',
        'proxima_qualificacao': '2024-01-01T00:00:00',
        'prazo_manutencao': '2024-06-01T00:00:00',
        'estado': 'Em uso',
        'categoria': {'id_categoria': 1, 'nome': 'Categoria Teste'},
        'status': 'Ativo',
        'modelo': {
          'id_modelo': 1,
          'nome': 'Modelo Teste',
          'marca': {'id_marca': 1, 'nome': 'Marca Teste'},
        },
        'localizacao': {'id_localizacao': 1, 'nome': 'Localização Teste'},
      };
      final newItem = ItemVizualizar.fromJson(json);

      expect(newItem.idItem, 1);
      expect(newItem.descricao, 'Item de Teste');
      expect(newItem.localizacaoAtual, 'Estoque 1');
      expect(newItem.potencia, 100);
      expect(newItem.patrimonio, 'PATRIMONIO123');
      expect(newItem.numeroDeSerie, 'SN123456');
      expect(newItem.numeroNotaFiscal, 'NF123456');
      expect(newItem.comentarioManutencao, 'Sem comentários');
      expect(newItem.dataEntrada, DateTime.parse('2023-01-01T00:00:00'));
      expect(newItem.ultimaQualificacao, DateTime.parse('2023-06-01T00:00:00'));
      expect(newItem.dataNotaFiscal, DateTime.parse('2023-06-01T00:00:00'));
      expect(newItem.proximaQualificacao, DateTime.parse('2024-01-01T00:00:00'));
      expect(newItem.prazoManutencao, DateTime.parse('2024-06-01T00:00:00'));
      expect(newItem.estado, 'Em uso');
      expect(newItem.categoria.idCategoria, 1);
      expect(newItem.status, 'Ativo');
      expect(newItem.modelo.idModelo, 1);
      expect(newItem.modelo.marca.idMarca, 1);
      expect(newItem.localizacao.idLocalizacao, 1);
    });
  });
}
