class ItemNotification {
  final String descricao;
  final DateTime? proximaQualificacao;

  ItemNotification({
    required this.descricao,
    this.proximaQualificacao, // Adicionar este campo no construtor
  });

  factory ItemNotification.fromJson(Map<String, dynamic> json) {
    return ItemNotification(
      descricao: json['descricao'],
      proximaQualificacao: json['proximaQualificacao'] != null ? DateTime.parse(json['proximaQualificacao']) : null, // Adicionar essa linha
    );
  }
}
