class ItemList {
  final int id;
  final String descricao;
  final String estado;

  ItemList({
    required this.id,
    required this.descricao,
    required this.estado,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) {
    ItemList item = ItemList(
      id: json['id_item'],
      descricao: json['descricao'],
      estado: json['estado'],
    );
    return item;
  }

  Map<String, dynamic> toJson() {
    return {
      'id_item': id,
      'descricao': descricao,
      'estado': estado,
    };
  }
}
