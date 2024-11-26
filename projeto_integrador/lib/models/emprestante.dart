class Emprestante {
  final int id_emprestante;
  final String num_identificacao;
  final String nome;
  final String status_emprestante;

  Emprestante({
    required this.id_emprestante,
    required this.num_identificacao,
    required this.nome,
    required this.status_emprestante,
  });

  factory Emprestante.fromJson(Map<String, dynamic> json) {
    Emprestante emprestante = Emprestante(
      id_emprestante: json['id_emprestante'],
      num_identificacao: json['num_identificacao'],
      nome: json['nome'],
      status_emprestante: json['status_emprestante'],
    );
    return emprestante;
  }

  Map<String, dynamic> toJson() {
    return {
      'id_emprestante': id_emprestante,
      'num_identificacao': num_identificacao,
      'nome': nome,
      'status_emprestante': status_emprestante,
    };
  }
}
