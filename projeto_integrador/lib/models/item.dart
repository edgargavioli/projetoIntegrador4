class Item {
  final int id;
  final String descricao;
  final String localizacaoAtual;
  final int? potencia;
  final String estado;
  final String numeroDeSerie;
  final String numeroNotaFiscal;
  final String comentarioManutencao;
  final String patrimonio;
  final int categoria;
  final String status;
  final int modelo;
  final String marca;
  final int localizacao;
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
    required this.patrimonio,
    required this.categoria,
    required this.status,
    required this.modelo,
    required this.marca,
    required this.localizacao,
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
      estado: json['estado'],
      numeroDeSerie: json['numero_de_serie'],
      numeroNotaFiscal: json['numero_nota_fiscal'],
      comentarioManutencao: json['comentario_manutencao'],
      patrimonio: json['patrimonio'],
      categoria: json['categoria'],
      status: json['status'],
      modelo: json['modelo'],
      marca: json['marca'],
      localizacao: json['localizacao'],
      dataEntrada: DateTime.parse(json['data_entrada']),
      ultimaQualificacao: DateTime.parse(json['ultima_qualificacao']),
      dataNotaFiscal: DateTime.parse(json['data_nota_fiscal']),
      proximaQualificacao: DateTime.parse(json['proxima_qualificacao']),
      prazoManutencao: DateTime.parse(json['prazo_manutencao']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_item': id,
      'descricao': descricao,
      'localizacao_atual': localizacaoAtual,
      'potencia': potencia,
      'estado': estado,
      'numero_de_serie': numeroDeSerie,
      'numero_nota_fiscal': numeroNotaFiscal,
      'comentario_manutencao': comentarioManutencao,
      'patrimonio': patrimonio,
      'categoria': categoria,
      'status': status,
      'modelo': modelo,
      'marca': marca,
      'localizacao': localizacao,
      'data_entrada': dataEntrada.toIso8601String(),
      'ultima_qualificacao': ultimaQualificacao.toIso8601String(),
      'data_nota_fiscal': dataNotaFiscal.toIso8601String(),
      'proxima_qualificacao': proximaQualificacao.toIso8601String(),
      'prazo_manutencao': prazoManutencao.toIso8601String(),
    };
  }
}
