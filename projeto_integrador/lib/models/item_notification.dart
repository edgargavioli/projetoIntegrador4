class ItemNotification {
  final String descricao;
  final DateTime? proximaManutencao;

  ItemNotification({
    required this.descricao,
    this.proximaManutencao
  });

  factory ItemNotification.fromJson(Map<String, dynamic> json) {
    return ItemNotification(
      descricao: json['descricao'],
      proximaManutencao: json['proximaManutencao'] != null ? DateTime.parse(json['proximaManutencao']) : null,
    );
  }
}