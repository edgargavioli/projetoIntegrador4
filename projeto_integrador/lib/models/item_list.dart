class Item_List {
  final int id;
  final String descricao;
  final String estado;

  Item_List({
    required this.id,
    required this.descricao,
    required this.estado,
  });

  factory Item_List.fromJson(Map<String, dynamic> json) {
    Item_List item = Item_List(
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
