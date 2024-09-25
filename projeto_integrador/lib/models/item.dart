import 'package:projeto_integrador/models/estado.dart';

class Item {
  final int id;
  final String descricao;
  final String localizacaoAtual;
  final int potencia;
  final Estado estado;
  final String numeroDeSerie;
  final String numeroNotaFiscal;
  final String comentarioManutencao;
  final DateTime dataEntrada;
  final DateTime ultimaQualificacao;
  final DateTime dataNotaFiscal;
  final DateTime proximaQualificacao;
  final DateTime prazoManutencao;

  Item({
    required this.id,
    required this.descricao,
    required this.localizacaoAtual,
    required this.potencia,
    required this.estado,
    required this.numeroDeSerie,
    required this.numeroNotaFiscal,
    required this.comentarioManutencao,
    required this.dataEntrada,
    required this.ultimaQualificacao,
    required this.dataNotaFiscal,
    required this.proximaQualificacao,
    required this.prazoManutencao,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id_item'],
      descricao: json['descricao'],
      localizacaoAtual: json['localizacao_atual'],
      potencia: json['potencia'],
      estado: Estado.fromJson(json['estado']),
      numeroDeSerie: json['numero_de_serie'],
      numeroNotaFiscal: json['numero_nota_fiscal'],
      comentarioManutencao: json['comentario_manutencao'],
      dataEntrada: DateTime.parse(json['data_entrada']),
      ultimaQualificacao: DateTime.parse(json['ultima_qualificacao']),
      dataNotaFiscal: DateTime.parse(json['data_nota_fiscal']),
      proximaQualificacao: DateTime.parse(json['proxima_qualificacao']),
      prazoManutencao: DateTime.parse(json['prazo_manutencao']),
    );
  }
}
