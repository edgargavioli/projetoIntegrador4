class Marca {
  final int id_marca;
  final String? nome;

  Marca({
    required this.id_marca,
    required this.nome,
  });

  factory Marca.fromJson(Map<String, dynamic> json) {
    return Marca(
      id_marca: json['id_marca'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_marca': id_marca,
      'nome': nome,
    };
  }
}
