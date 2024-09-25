class Estado {
  final int id_estado;
  final String nome;

  Estado({
    required this.id_estado,
    required this.nome,
  });

  factory Estado.fromJson(Map<String, dynamic> json) {
    return Estado(
      id_estado: json['id_estado'],
      nome: json['nome'],
    );
  }
}
