class ItemNotification {
  final String descricao;
  final DateTime? proxima_qualificacao;

  ItemNotification({required this.descricao, this.proxima_qualificacao});

  factory ItemNotification.fromJson(Map<String, dynamic> json) {
    return ItemNotification(
      descricao: json['descricao'],
      proxima_qualificacao: json['proxima_qualificacao'] != null
          ? DateTime.parse(json['proxima_qualificacao'])
          : null,
    );
  }
}
