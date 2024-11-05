class ItemVizualizar {
  final int idItem;
  final String descricao;
  final String localizacaoAtual;
  final int? potencia;
  final String patrimonio;
  final String numeroDeSerie;
  final String numeroNotaFiscal;
  final String comentarioManutencao;
  final DateTime dataEntrada;
  final DateTime ultimaQualificacao;
  final DateTime dataNotaFiscal;
  final DateTime proximaQualificacao;
  final DateTime prazoManutencao;
  final String estado;
  final Categoria categoria;
  final String status;
  final Modelo modelo;
  final Localizacao localizacao;

  ItemVizualizar({
    required this.idItem,
    required this.descricao,
    required this.localizacaoAtual,
    required this.potencia,
    required this.patrimonio,
    required this.numeroDeSerie,
    required this.numeroNotaFiscal,
    required this.comentarioManutencao,
    required this.dataEntrada,
    required this.ultimaQualificacao,
    required this.dataNotaFiscal,
    required this.proximaQualificacao,
    required this.prazoManutencao,
    required this.estado,
    required this.categoria,
    required this.status,
    required this.modelo,
    required this.localizacao,
  });

  factory ItemVizualizar.fromJson(Map<String, dynamic> json) {
    return ItemVizualizar(
      idItem: json['id_item'],
      descricao: json['descricao'],
      localizacaoAtual: json['localizacao_atual'],
      potencia: json['potencia'],
      patrimonio: json['patrimonio'],
      numeroDeSerie: json['numero_de_serie'],
      numeroNotaFiscal: json['numero_nota_fiscal'],
      comentarioManutencao: json['comentario_manutencao'],
      dataEntrada: DateTime.parse(json['data_entrada']),
      ultimaQualificacao: DateTime.parse(json['ultima_qualificacao']),
      dataNotaFiscal: DateTime.parse(json['data_nota_fiscal']),
      proximaQualificacao: DateTime.parse(json['proxima_qualificacao']),
      prazoManutencao: DateTime.parse(json['prazo_manutencao']),
      estado: json['estado'],
      categoria: Categoria.fromJson(json['categoria']),
      status: json['status'],
      modelo: Modelo.fromJson(json['modelo']),
      localizacao: Localizacao.fromJson(json['localizacao']),
    );
  }
}

class Categoria {
  final int idCategoria;
  final String nome;

  Categoria({required this.idCategoria, required this.nome});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      idCategoria: json['id_categoria'],
      nome: json['nome'],
    );
  }
}

class Modelo {
  final int idModelo;
  final String nome;
  final Marca marca;

  Modelo({required this.idModelo, required this.nome, required this.marca});

  factory Modelo.fromJson(Map<String, dynamic> json) {
    return Modelo(
      idModelo: json['id_modelo'],
      nome: json['nome'],
      marca: Marca.fromJson(json['marca']),
    );
  }
}

class Marca {
  final int idMarca;
  final String nome;

  Marca({required this.idMarca, required this.nome});

  factory Marca.fromJson(Map<String, dynamic> json) {
    return Marca(
      idMarca: json['id_marca'],
      nome: json['nome'],
    );
  }
}

class Localizacao {
  final int idLocalizacao;
  final String nome;

  Localizacao({required this.idLocalizacao, required this.nome});

  factory Localizacao.fromJson(Map<String, dynamic> json) {
    return Localizacao(
      idLocalizacao: json['id_localizacao'],
      nome: json['nome'],
    );
  }
}
